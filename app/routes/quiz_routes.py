from flask import Blueprint, request, jsonify
import random
from app.dao.quiz_dao import *
from app.validation.quiz_validation import *
from app.utility.feedback_messages import *
import config
import pickle

# ======== Prediction by model ========
import joblib
import numpy as np
import pandas as pd
# ======== Prediction by model ========

# Load the saved file

quiz_bp = Blueprint('quiz', __name__)

# saved_objects_overall = joblib.load("models/feedback_model.pkl")
# model = saved_objects_overall['model']
# label_encoder = saved_objects_overall['label_encoder']
# message_map = saved_objects_overall['message_map']

# To fetch the topics
@quiz_bp.route('/topics', methods=['POST'])
def topics():
    try:
        data = request.json
        if not validate_topic_data(data):
            return jsonify({
                'success': False,
                'status': 400,
                'message': 'Every fields are required to start.',
                'response': None
            })
        topics = fetch_all_topics(data)
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
        # Decide next level only after 4th, 7th, 10th... questions answered
        # if total_count >= 3 and (total_count - 4) % 3 == 0:
        if total_count % 3 == 0:
            for [i, item] in enumerate(all_answers):
                item["qsn_no"] = i + 1
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



@quiz_bp.route('/get_summary', methods=['POST'])
def get_summary():
    try:
        data = request.get_json()
        attemptid = data.get('attemptid')
        userid = data.get('userid')
        topicid = data.get("topicid")  # Assuming all answers belong to same topic

        if not validate_generate_score_data(data):
            return jsonify({
                'success': False,
                'status': 400,
                'message': 'Some fields are missing',
                'response': None
            })

        # 1. Get current score
        answers = get_answers_by_attemptid(attemptid, topicid)
        if not answers:
            return jsonify({
                'success': False,
                'status': 404,
                'message': 'No answers found for this attempt.',
                'response': None
            })

        total = len(answers)
        correct = sum(1 for ans in answers if ans['iscorrect'])
        percentage = round((correct / total) * 100)

        # 2. Generate feedback message
        # feedback = get_feedback_message([percentage])

        # 3. Get previous scores
        previous_scores = []
        previous_scores_obj = []
        overall_feedback = ''
        consent = check_user_consent(userid)
        topicname = get_topic_name(topicid)


        if consent:
            previous_attempts = get_completed_attempts_by_user(userid, topicid)

            if len(previous_attempts) > 0:
                for row in previous_attempts:
                    past_answers = get_answers_by_attemptid(row['attemptid'], topicid)
                    if past_answers:
                        total_prev = len(past_answers)
                        correct_prev = sum(1 for ans in past_answers if ans['iscorrect'])
                        score = round((correct_prev / total_prev) * 100)
                        previous_scores.append(score)
                        previous_scores_obj.append({
                            "attemptdate": row['createdat'],
                            "score": score
                        })

            # Get overall feddback by comparing previous scores
            # model = joblib.load('models/historical_performance_prediction.joblib')
            model = joblib.load('models/historical_performance_prediction.joblib')
            with open('models/label_to_messages.pkl', 'rb') as f:
                label_to_messages = pickle.load(f)

            # Predict on new scores
            features = extract_features(previous_scores)
            label_id = model.predict([features])[0]
            overall_feedback = random.choice(label_to_messages[label_id])
            # overall_feedback = model.predict([features])

            # print("Predicted feedback:", overall_feedback[0])



        # ========================= Current Feedback ===========================
        feedbackmodel = joblib.load('models/predict_feedback.joblib')
        pred_score = round(feedbackmodel.predict(pd.DataFrame({'percentage': [percentage]}))[0])
        # print(f"Predicted score: {pred_score}")
        pred_score = max(0, min(5, pred_score))  # Clamp
        # print(f"Clamped score: {pred_score}")
        current_feedback = random.choice(score_to_message[pred_score])

        
        # 4. Check consent

        return jsonify({
            'success': True,
            'status': 200,
            'message': 'Score and feedback generated successfully.',
            'response': { 
                'currentScore' : {
                    'current_score': percentage,
                    'current_feedback': current_feedback,
                },               
                'previousScores': {
                    "overall_feedback": overall_feedback,
                    "previous_scores": previous_scores_obj
                    },
                'consent': consent,
                "topic_name": topicname
            }
        })
    except Exception as e:
        print("get_summary>>>>>>>>>>>>>>>", e)
        return jsonify({
            'success': False,
            'status': 500,
            'message': 'Something went wrong. Please try again later.',
            'response': None
        })
    

    
@quiz_bp.route("/submitConsent", methods=["POST"])
def submit_consent():
    try:
        data = request.json
        if not validate_consent_request(data):
            return jsonify({
                "status": "error",
                "message": "Some fields are missing",
                "response": None
            }), 400

        clientid = data['clientid']
        userid = data['userid']
        consent = data['consent']

        result = save_user_consent(clientid, userid, consent)
        if result:
            return jsonify(
                {
                    'success': True,
                    'status': 100,
                    'message': 'Consent saved successfully',
                    'response': None
                }
            )
        else:
            return jsonify(
                {
                    'success': False,
                    'status': 500,
                    'message': 'Failed to save consent',
                    'response': None
                }
            )

    except Exception as e:
        print("submitConsent >>>>>>>>", e)
        return jsonify({
            'success': False,
            'status': 500,
            'message': 'Something went wrong. Please try again later.',
            'response': None
        })



def extract_features(score_list):
    arr = np.array(score_list)
    x = np.arange(len(arr))
    slope = np.polyfit(x, arr, 1)[0] if len(arr) > 1 else 0
    return [
        np.mean(arr),
        np.std(arr),
        np.min(arr),
        np.max(arr),
        slope
    ]


