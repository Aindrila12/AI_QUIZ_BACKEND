from flask import Flask
from flask_cors import CORS
from app.routes import auth_routes, quiz_routes

def create_app():
    app = Flask(__name__)
    CORS(app)  # 🔥 Enables CORS for all routes

    # Or to allow specific origins:
    # CORS(app, resources={r"/*": {"origins": "http://localhost:4200"}})

    app.register_blueprint(auth_routes.auth_bp, url_prefix='/auth')
    app.register_blueprint(quiz_routes.quiz_bp, url_prefix='/quiz')

    return app
