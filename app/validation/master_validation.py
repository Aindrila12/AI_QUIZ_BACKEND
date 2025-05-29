def validate_category_sample_excel(data):
    required_fields = ['clientid']
    for field in required_fields:
        if not data.get(field):
            return False
    return True

def validate_topic_data(data):
    required_fields = ['clientid', "limit"]
    for field in required_fields:
        if not data.get(field):
            return False
    return True

def validate_question_data(data):
    required_fields = ['clientid', "limit"]
    for field in required_fields:
        if not data.get(field):
            return False
    return True

def validate_update_topic_data(data):
    required_fields = ['clientid', 'topicid', "image"]
    for field in required_fields:
        if not data.get(field):
            return False
    return True

def validate_excel_upload_request(request, allowed_extensions=('.xlsx',)):
    errors = []

    # Check required form fields
    required_fields = ["cliendtid"]
    for field in required_fields:
        if not request.form.get(field):
            errors.append(f"Missing required field: {field}")

    # Check for file
    if 'file' not in request.files:
        errors.append("No file uploaded.")
    else:
        file = request.files['file']
        if not file.filename.endswith(allowed_extensions):
            errors.append("Invalid file format. Only .xlsx is allowed.")

    return errors
