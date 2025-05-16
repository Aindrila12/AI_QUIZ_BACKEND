# app/validation/auth_validation.py

def validate_login_data(data):
    required_fields = ['username', 'password']
    for field in required_fields:
        if field not in data or data[field] is None or data[field] == '':
            return False
    return True
