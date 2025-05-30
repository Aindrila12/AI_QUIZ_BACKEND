from flask import Blueprint, request, jsonify
from app.validation.integration_validation import *
from app.dao.integration_dao import *
import bcrypt
import uuid
import time
import jwt

integration_bp = Blueprint('integration', __name__)

secretKey = 'dXNlckBleGFtcGxlLmNvbV8xNzE2OTg4OTE0'


@integration_bp.route('/client-registration', methods=['POST'])
def clientRegistration():
    try:
        data = request.json
        # print(data)
        if not validate_client_registration_form(data):
            return jsonify({
                'success': False,
                'status': 400,
                'message': 'Please fill in all required fields.',
                'response': None
            })


        if checkClient(data):
            return jsonify({
                'success': False,
                'status': 500,
                'message': 'Sorry, the Company email you provided is already registered. Please try with a different email.',
                'response': None
            })
            
        if checkUser(data):
            return jsonify({
                'success': False,
                'status': 500,
                'message': 'Sorry, the User email or username you provided is already registered. Please try with a different email or username.',
                'response': None
            })
            
            
        
        timestamp = str(int(time.time()))
        namespace = uuid.NAMESPACE_DNS

        data['integrationkey'] = uuid.uuid5(namespace, data['companyEmail'] + timestamp)
            
        insertedClientId = insertIntoClient(data)
        
        if insertedClientId:
            
            data['insertedClientId'] = insertedClientId
            data["password"] = data["password"].encode('utf-8')
            
            salt = bcrypt.gensalt()
            data["password"] = bcrypt.hashpw(data["password"], salt)
            
            insertedUserId = insertIntoUser(data)
            
            return jsonify({
                'success': True,
                'status': 200,
                'message': 'Your registration was successful',
                'response': {
                    'integrationkey': data['integrationkey'],
                    'secretkey': secretKey
                }
            })
            
        else:
            return jsonify({
                'success': False,
                'status': 500,
                'message': 'Something went wrong. Please try again later.',
                'response': None
            })

    except Exception as e:
        print(f"Error in /client-registration: {e}")
        return jsonify({
            'success': False,
            'status': 500,
            'message': 'Something went wrong. Please try again later.',
            'response': None
        })
        
        
        
@integration_bp.route('/client-redirection', methods=['POST'])
def clientRedirection():
    try:
        
        # mypayload = {
        # "integrationkey": "aecdadda-b797-5da6-913b-70af39cd7b87",
        # "username": "niloo.rera@bihar.gov.in"
        # }
        
        # encoded = jwt.encode(mypayload, secretKey, algorithm="HS256")
        # print("Token:", encoded)
        
        data = request.json
        # print(data)
        if not validate_token_present(data):
            return jsonify({
                'success': False,
                'status': 400,
                'message': 'Please provide a valid token.',
                'response': None
            })            
            

        try:
            jsonValue = jwt.decode(data['token'], secretKey, algorithms=["HS256"])
            data["username"] = jsonValue["username"]
            data["integrationkey"] = jsonValue["integrationkey"]
            
        except jwt.ExpiredSignatureError:
            print("Token has expired")
            return jsonify({
                'success': False,
                'status': 400,
                'message': 'Please provide a valid token.',
                'response': None
            })  
        except jwt.InvalidTokenError:
            print("Invalid token")
            return jsonify({
                'success': False,
                'status': 400,
                'message': 'Please provide a valid token.',
                'response': None
            })  
            
        user = checkAuthentication(data)
        
        if user:            
            return jsonify({
                'success': True,
                'status': 200,
                'message': 'You are successfully authenticated.',
                'response': {
                    "userdetails": user,
                    "clientdetails": user
                }
            })            
        else:
            return jsonify({
                'success': False,
                'status': 400,
                'message': 'Please provide a valid token.',
                'response': None
            }) 

    except Exception as e:
        print(f"Error in /client-registration: {e}")
        return jsonify({
            'success': False,
            'status': 500,
            'message': 'Something went wrong. Please try again later.',
            'response': None
        })