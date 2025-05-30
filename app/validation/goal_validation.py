def validate_get_goal_data(data):
    required_fields = ['clientid', 'userid']
    for field in required_fields:
        if field not in data or data[field] is None or data[field] == '':
            return False
    return True