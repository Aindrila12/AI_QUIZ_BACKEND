from flask import Flask
from flask_cors import CORS
from app.routes import auth_routes, quiz_routes, master_routes, file_upload, integration_routes
import os

def create_app():
    project_root = os.path.abspath(os.path.join(os.path.dirname(__file__), '..'))
    public_folder = os.path.join(project_root, 'public')
    app = Flask(__name__, static_folder=public_folder, static_url_path='/public')
    CORS(app)  # 🔥 Enables CORS for all routes

    # Or to allow specific origins:
    # CORS(app, resources={r"/*": {"origins": "http://localhost:4200"}})

    app.register_blueprint(auth_routes.auth_bp, url_prefix='/auth')
    app.register_blueprint(quiz_routes.quiz_bp, url_prefix='/quiz')
    app.register_blueprint(master_routes.master_bp, url_prefix='/master')
    app.register_blueprint(file_upload.file_upload, url_prefix='/fileupload')
    app.register_blueprint(integration_routes.integration_bp, url_prefix='/integration')

    return app
