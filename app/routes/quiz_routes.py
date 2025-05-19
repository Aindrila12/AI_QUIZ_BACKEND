from flask import Blueprint, request, jsonify
import random
from app.dao.quiz_dao import *
from app.validation.quiz_validation import *
import config

quiz_bp = Blueprint('quiz', __name__)

# To fetch the topics
@quiz_bp.route('/topics', methods=['POST'])
def topics():
    try:
        topics = fetch_all_topics()
        if topics:
            return jsonify({
                'success': True,
                'status': 200,
                'message': '',
                'response': topics
            })
        else:
            return jsonify({
                'success': False,
                'status': 500,
                'message': 'Couldn’t load topics right now. Please try again soon.',
                'response': None
            })
    except Exception as e:
        return jsonify({
            'success': False,
            'status': 500,
            'message': 'Something went wrong. Please try again later.',
            'response': None
        })

@quiz_bp.route('/select_topic', methods=['POST'])
def start_attempt():
    try:
        data = request.json

        if not validate_quiz_attempt_data(data):
            return jsonify({
                'success': False,
                'status': 400,
                'message': 'Every fields are required to start.',
                'response': None
            })

        attemptid = create_attempt(data)

        if attemptid:
            return jsonify({
                'success': True,
                'status': 200,
                'message': 'Quiz started! Good luck!',
                'response': {
                    "attempt_id": attemptid
                }
            })
        else:
            return jsonify({
                'success': False,
                'status': 500,
                'message': 'Couldn’t start the quiz. Please try again.',
                'response': None
            })

    except Exception as e:
        return jsonify({
            'success': False,
            'status': 500,
            'message': 'Something went wrong. Please try again later.',
            'response': None
        })
    

@quiz_bp.route('/start_quiz', methods=['POST'])
def start_quiz():
    try:
        data = request.json

        if not validate_start_quiz_data(data):
            return jsonify({
                'success': False,
                'status': 400,
                'message': 'Every fields are required.',
                'response': None
            })

        userid = data['userid']
        topicid = data['topicid']

        levelid = 2  # default intermediate

        attemptid = check_attempt(data)

        if attemptid["iscompleted"] == 1:
            return jsonify({
                'success': False,
                'status': 400,
                'message': 'You have already completed the quiz.',
                'response': None
            })

        if check_user_consent(userid):
            score = get_previous_performance(userid, topicid)
            if score is not None:
                percentage = score * 100
                if percentage <= 40:
                    levelid = 1
                elif percentage <= 60:
                    levelid = 2
                else:
                    levelid = 3

        question_arr = get_next_question_by_level(topicid, levelid)

        if question_arr:
            question = random.choice(question_arr)
            question["question_count"] = config.QSN_COUNT
            question["options"] = get_options_by_questionid(question["question_id"])
            return jsonify({
                'success': True,
                'status': 200,
                'message': 'Here is your first question!',
                'response': question
            })
        else:
            return jsonify({
                'success': False,
                'status': 404,
                'message': 'No questions available for this topic and level.',
                'response': None
            })

    except Exception as e:
        print(f"Error in /start_quiz: {e}")
        return jsonify({
            'success': False,
            'status': 500,
            'message': 'Something went wrong. Please try again later.',
            'response': None
        })


@quiz_bp.route('/submit_answer', methods=['POST'])
def submit_answer():
    try:
        data = request.json

        if not validate_submit_answer_data(data):
            return jsonify({
                'success': False,
                'status': 400,
                'message': 'All fields are required.',
                'response': None
            })
        
        currentlevel = data.get('current_level')

        # Step 1: Check correct flag from options table
        is_correct = get_option_correct_flag(data['optionid'])
        if is_correct is None:
            return jsonify({
                'success': False,
                'status': 500,
                'message': 'Something went wrong while verifying answer correctness.',
                'response': None
            })

        data["iscorrect"] = is_correct

        # Step 2: Store answer
        if not store_user_answer(data):
            return jsonify({
                'success': False,
                'status': 500,
                'message': 'Failed to store answer.',
                'response': None
            })
        

        # Step 3: Mark attempt as completed if last question
        print("111111111111111", data.get('is_last'), data.get("is_last") == 0)
        if data.get('is_last'):
            if update_attempt_complete(data['attemptid']):
                return jsonify({
                    'success': True,
                    'status': 200,
                    'message': 'Quiz completed. Well done!',
                    'response': None
                })
            else:
                return jsonify({
                    'success': False,
                    'status': 500,
                    'message': 'Something went wrong while updating attempt.',
                    'response': None
                })

        # --- New Logic ---

        # Fetch all answers for this attempt (with question numbers)
        all_answers = get_all_answers_for_attempt(data['attemptid'])
        total_count = len(all_answers)
        next_level = 2  # default starting level
        print(">>>>>>>>>>>>>>>>>>>>>>>>>", total_count, total_count % 3 == 0 )
        # Decide next level only after 4th, 7th, 10th... questions answered
        # if total_count >= 3 and (total_count - 4) % 3 == 0:
        if total_count % 3 == 0:
            for [i, item] in enumerate(all_answers):
                item["qsn_no"] = i + 1
            print("percentage >>>>>>>>>", all_answers)
            percentage = calculate_set_correctness(all_answers)


            if percentage <= 60:
                if currentlevel == 1:
                    next_level = 1  # intermediate or easy
                else:
                    next_level = currentlevel - 1
            else:
                if currentlevel == 3:
                    next_level = 3  # hard
                else:
                    next_level = currentlevel + 1
        else:
            next_level = data.get('current_level', 2)

        # Step 4: Get next question excluding already attempted
        exclude_ids = data.get('attempted_questions', [])
        next_question = get_next_question_by_level(data['topicid'], next_level, exclude_ids)

        if next_question:
            question = random.choice(next_question)
            question["question_count"] = config.QSN_COUNT
            question["options"] = get_options_by_questionid(question["question_id"])
            return jsonify({
                'success': True,
                'status': 200,
                'message': 'Here’s your next question!',
                'response': question
            })
        else:
            return jsonify({
                'success': False,
                'status': 404,
                'message': 'No more questions available at this level.',
                'response': None
            })

    except Exception as e:
        print(f"Error in /submit_answer: {e}")
        return jsonify({
            'success': False,
            'status': 500,
            'message': 'Something went wrong. Please try again later.',
            'response': None
        })


def calculate_set_correctness(answers):
    # answers is list of dicts: [{'iscorrect': 1, 'qsn_no': 1}, ...]

    total_answered = len(answers)
    if total_answered == 0:
        return 0, 0, 0  # no answers, no correctness

    # Calculate current set number
    set_number = (total_answered - 1) // 3 + 1
    start_qsn_no = (set_number - 1) * 3 + 1
    end_qsn_no = set_number * 3

    # Filter answers in current set
    current_set_answers = [a for a in answers if start_qsn_no <= a['qsn_no'] <= end_qsn_no]

    total_in_set = len(current_set_answers)
    correct_in_set = sum(a['iscorrect'] for a in current_set_answers)

    # Calculate percentage correctness for this set
    percentage = (correct_in_set / total_in_set) * 100 if total_in_set > 0 else 0

    return percentage

# def calculate_set_correctness(answers):
#     total_answered = len(answers)
#     if total_answered == 0:
#         return 0

#     # Determine current set by index instead of qsn_no
#     set_number = (total_answered - 1) // 3 + 1
#     start_index = (set_number - 1) * 3
#     end_index = set_number * 3

#     # Slice based on list index
#     current_set_answers = answers[start_index:end_index]

#     total_in_set = len(current_set_answers)
#     correct_in_set = sum(a['iscorrect'] for a in current_set_answers)

#     percentage = (correct_in_set / total_in_set) * 100 if total_in_set > 0 else 0
#     return percentage



