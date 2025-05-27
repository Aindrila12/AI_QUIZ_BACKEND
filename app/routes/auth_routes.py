# app/routes/auth_routes.py

from flask import Blueprint, request, jsonify
from app.dao.user_dao import *
from app.validation.auth_validation import validate_login_data
import bcrypt

auth_bp = Blueprint('auth_bp', __name__)

@auth_bp.route('/login', methods=['POST'])
def login():
    try:
        data = request.json
        if not validate_login_data(data):
            return jsonify({
                'success': False,
                "status": 400,
                'message': 'Please enter your username and password.',
                'response': None
            })

        result = get_user_by_credentials(data)
        if result:
            if bcrypt.checkpw(data["password"].encode('utf-8'), result["password"].encode('utf-8')):
                del result["password"]
                clientdtl = get_client_detail(result["clientid"])
                if clientdtl:
                    return jsonify({
                        'success': True,
                        "status": 200,
                        'message': 'Logged in successfully!',
                        'response': {
                            "userdetails": result,
                            "clientdetails": clientdtl
                        }
                    })
                else:
                    return jsonify({
                        'success': False,
                        "status": 401,
                        'message': 'No client found.',
                        'response': None
                    })
            else:
                return jsonify({
                    'success': False,
                    "status": 401,
                    'message': 'Incorrect password, please try again.',
                    'response': None
                })
        else:
            return jsonify({
                'success': False,
                "status": 401,
                'message': 'No account found with that username.',
                'response': None
            })

    except Exception as e:
        print(f"Error in login: {e}")
        return jsonify({
            'success': False,
            "status": 500,
            'message': 'Something went wrong, please try again later.',
            'response': None
        })

