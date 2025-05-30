def validate_client_registration_form(data):
    required_fields = ["name", "email", "username", "password", "companyName", "licenceNumber", "companyPhone", "companyEmail", "companyLogo"]
    for field in required_fields:
        if not data.get(field):
            return False
    return True




def validate_token_present(data):
    required_fields = ["token"]
    for field in required_fields:
        if not data.get(field):
            return False
    return True