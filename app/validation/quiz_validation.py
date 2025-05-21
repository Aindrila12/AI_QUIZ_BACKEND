# app/validation/quiz_validation.py

def validate_start_quiz_data(data):
    required_fields = ['user_id', 'topic_id']
    for field in required_fields:
        if field not in data or data[field] is None or data[field] == '':
            return False
    return True

def validate_quiz_attempt_data(data):
    required_fields = ['userid', 'topicid']
    for field in required_fields:
        if not data.get(field):
            return False
    return True

def validate_start_quiz_data(data):
    required_fields = ['userid', 'topicid', 'attemptid']
    return all(field in data and data[field] for field in required_fields)

def validate_submit_answer_data(data):
    required_fields = ['userid', 'topicid', 'attemptid', 'questionid', 'optionid', 'attempted_questions', 'is_last', 'current_level']
    return all(field in data and data[field] is not None for field in required_fields)

def validate_generate_score_data(data):
    required_fields = ['userid', 'topicid', 'attemptid']
    return all(field in data and data[field] for field in required_fields)

def validate_consent_request(data):
    required_fields = ['clientid', 'userid', 'consent']
    return all(field in data for field in required_fields)




