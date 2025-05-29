import os
from flask import request, jsonify, Blueprint
from werkzeug.utils import secure_filename
from datetime import datetime

file_upload = Blueprint('fileupload', __name__)

ALLOWED_IMAGE_EXTENSIONS = ('.jpg', '.jpeg', '.png', '.webp')
ALLOWED_EXCEL_EXTENSIONS = ('.xlsx',)

@file_upload.route('/upload_file', methods=['POST'])
def upload_file():
    try:
        file = request.files.get('file')

        if not file:
            return jsonify({'success': False, 'status': 400, 'message': 'No file uploaded.', 'response': {}})

        filename = secure_filename(file.filename)
        extension = os.path.splitext(filename)[1].lower()

        if extension in ALLOWED_IMAGE_EXTENSIONS:
            upload_folder = os.path.join(os.getcwd(), 'public', 'uploads')
        elif extension in ALLOWED_EXCEL_EXTENSIONS:
            upload_folder = os.path.join(os.getcwd(), 'public', 'downloads')
        else:
            return jsonify({'success': False, 'status': 400, 'message': 'Unsupported file format.', 'response': {}})

        os.makedirs(upload_folder, exist_ok=True)

        timestamp = datetime.now().strftime('%Y%m%d%H%M%S')
        new_filename = f"{timestamp}{extension}"
        file_path = os.path.join(upload_folder, new_filename)
        file.save(file_path)

        return jsonify({
            'success': True,
            'status': 200,
            'message': "File uploaded successfully.",
            'response': {'filename': new_filename}
        })

    except Exception as e:
        return jsonify({'success': False, 'status': 500, 'message': 'File upload failed.', 'response': str(e)})

