def validate_category_sample_excel(data):
    required_fields = ['clientid']
    for field in required_fields:
        if not data.get(field):
            return False
    return True