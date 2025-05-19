from flask import Blueprint, request, jsonify, current_app
import os
import uuid

upload_bp = Blueprint('upload_bp', __name__)

ALLOWED_EXTENSIONS = {'png', 'jpg', 'jpeg', 'gif'}

def allowed_file(filename):
    return '.' in filename and \
           filename.rsplit('.', 1)[1].lower() in ALLOWED_EXTENSIONS

@upload_bp.route('/upload_image', methods=['POST'])
def upload_image():
    if 'image' not in request.files:
        return jsonify({'success': False, 'status': 400, 'message': 'No file part', 'response': None})

    file = request.files['image']

    if file.filename == '':
        return jsonify({'success': False, 'status': 400, 'message': 'No selected file', 'response': None})

    if file and allowed_file(file.filename):
        filename = str(uuid.uuid4()) + '.' + file.filename.rsplit('.', 1)[1].lower()
        filepath = os.path.join(current_app.config['UPLOAD_FOLDER'], filename)
        file.save(filepath)

        image_url = f'/uploads/{filename}'

        return jsonify({
            'success': True,
            'status': 200,
            'message': 'Image uploaded successfully.',
            'response': {'image_url': image_url}
        })

    return jsonify({'success': False, 'status': 400, 'message': 'Invalid file type', 'response': None})
