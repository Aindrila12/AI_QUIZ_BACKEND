from flask import Blueprint, request, jsonify
from openpyxl import Workbook
from datetime import datetime
from openpyxl.worksheet.datavalidation import DataValidation
from openpyxl import load_workbook
from openpyxl.styles import PatternFill
from app.validation.master_validation import *
from app.dao.master_dao import *
import os

master_bp = Blueprint('master', __name__)

@master_bp.route('/topic_sample_excel', methods=['POST'])
def topic_sample_excel():
    try:
        # Optional: Validate the incoming JSON if required
        data = request.json
        if not validate_category_sample_excel(data):
            return jsonify({
                'success': False,
                'status': 1001,
                'message': 'Some fields are missing.',
                'response': None
            })

        # Create a new Excel workbook
        wb = Workbook()
        ws = wb.active
        ws.title = "Topics"

        # Add headers
        ws.append(["Topic Name", "Description", "Categories"])
        # Set column widths
        ws.column_dimensions['A'].width = 20
        ws.column_dimensions['B'].width = 30
        ws.column_dimensions['C'].width = 40

        # Add example rows
        ws.append(["Math", "Basic mathematics", "Algebra,Geometry"])

        # Add additional blank rows for user input
        for _ in range(8):
            ws.append(["", "", ""])

        # Save the Excel file
        timestamp = datetime.now().strftime("%Y%m%d%H%M%S")
        filename = f"topic_sample_{timestamp}.xlsx"
        save_path = os.path.join(os.getcwd(), "public", "downloads")
        os.makedirs(save_path, exist_ok=True)
        full_path = os.path.join(save_path, filename)
        wb.save(full_path)

        return jsonify({
            'success': True,
            'status': 200,
            'message': 'Excel generated successfully.',
            'response': {"filename": filename}
        })

    except Exception as e:
        return jsonify({
            'success': False,
            'status': 500,
            'message': 'Error generating Excel file.',
            'response': str(e)
        })
    

@master_bp.route('/question_sample_excel', methods=['POST'])
def question_sample_excel():
    try:
        # Optional: Validate the incoming JSON if required
        data = request.json
        if not validate_category_sample_excel(data):
            return jsonify({
                'success': False,
                'status': 1001,
                'message': 'Some fields are missing.',
                'response': None
            })

        # Create workbook
        wb = Workbook()
        ws = wb.active
        ws.title = "Questions"

        # Define headers
        headers = [
            "Question", 
            "Question Type", 
            "Descriptive Answer", 
            "Options", 
            "Correct Answer"
        ]
        ws.append(headers)

        # Set column widths
        column_widths = [50, 20, 40, 40, 20]
        for i, width in enumerate(column_widths, start=1):
            ws.column_dimensions[chr(64 + i)].width = width

        # Add sample rows
        ws.append([
            "What is the capital of France?", 
            "MCQ", 
            "", 
            "Paris,London,Berlin", 
            "A"
        ])
        ws.append([
            "Explain the process of photosynthesis.", 
            "Descriptive", 
            "Photosynthesis is the process by which green plants convert sunlight into energy...", 
            "", 
            ""
        ])

        # Add dropdown for Question Type
        dv = DataValidation(
            type="list", 
            formula1='"MCQ,Descriptive"',
            allow_blank=False
        )
        dv.prompt = "Select the question type"
        dv.promptTitle = "Question Type"
        dv.error = "Invalid question type. Choose from MCQ or Descriptive."
        dv.errorTitle = "Invalid Selection"
        ws.add_data_validation(dv)

        # Apply dropdown to Question Type column (B2 to B11)
        for row in range(2, 12):  # First 10 input rows
            dv.add(ws[f"B{row}"])

        # Save file
        timestamp = datetime.now().strftime("%Y%m%d%H%M%S")
        filename = f"question_sample_{timestamp}.xlsx"
        save_path = os.path.join(os.getcwd(), "public", "downloads")
        os.makedirs(save_path, exist_ok=True)
        full_path = os.path.join(save_path, filename)
        wb.save(full_path)

        return jsonify({
            'success': True,
            'status': 200,
            'message': 'Sample question Excel generated successfully.',
            'response': {"filename": filename}
        })

    except Exception as e:
        return jsonify({
            'success': False,
            'status': 500,
            'message': 'Error generating Excel file.',
            'response': str(e)
        })




@master_bp.route('/upload_topics_excel', methods=['POST'])
def upload_topics_excel():
    try:
        # Get clientid from the form data
        if not validate_excel_upload_request(request, '.xlsx'):
            return jsonify({
                'success': False,
                'status': 1001,
                'message': 'Invalid request. Please check the uploaded file and required fields.',
                'response': None
            })
        
        clientid = request.form.get('clientid')
        file = request.files['file']

        wb = load_workbook(file)
        ws = wb.active

        errors = []
        valid_data = []
        all_rows = []

        for idx, row in enumerate(ws.iter_rows(min_row=2, values_only=True), start=2):
            topic_name, description, categories = row
            row_errors = []

            if not topic_name or not str(topic_name).strip():
                row_errors.append("Topic Name is required.")
            if not description or not str(description).strip():
                row_errors.append("Description is required.")

            row_data = {
                'clientid': int(clientid),
                'topic_name': str(topic_name).strip() if topic_name else '',
                'description': str(description).strip() if description else '',
                'categories': [cat.strip() for cat in str(categories).split(",")] if categories else []
            }

            all_rows.append((idx, row_data, row_errors))

            if row_errors:
                errors.append({'row': idx, 'errors': row_errors})
            else:
                valid_data.append(row_data)


        total = len(all_rows)
        valid = len(valid_data)
        valid_percent = (valid / total) * 100 if total > 0 else 0

        # If all rows are valid
        if valid == total:
            for item in valid_data:
                result = insert_topic(item, clientid)
                if result is None:
                    return jsonify({
                        'success': False,
                        'status': 500,
                        'message': f"Error inserting topic: {item['topic_name']}",
                        'response': None
                    })

            return jsonify({
                'success': True,
                'status': 200,
                'message': f"All {valid} topics inserted successfully.",
                'response': None
            })
        

        # Create error-highlighted Excel
        error_filename = f"topic_upload_errors_{datetime.now().strftime('%Y%m%d%H%M%S')}.xlsx"
        error_filepath = os.path.join(os.getcwd(), 'public', 'downloads')
        os.makedirs(error_filepath, exist_ok=True)
        full_error_path = os.path.join(error_filepath, error_filename)


        error_wb = Workbook()
        error_ws = error_wb.active
        error_ws.append(["Topic Name", "Description", "Categories", "Reason"])

        # Set column widths
        error_ws.column_dimensions['A'].width = 30  # Topic Name
        error_ws.column_dimensions['B'].width = 50  # Description
        error_ws.column_dimensions['C'].width = 40  # Categories
        error_ws.column_dimensions['D'].width = 60  # Reason

        red_fill = PatternFill(start_color='FFC7CE', end_color='FFC7CE', fill_type='solid')

        for i, (idx, data, errs) in enumerate(all_rows, start=2):
            row = [data['topic_name'], data['description'], ", ".join(data['categories']), ", ".join(errs) if errs else ""]
            error_ws.append(row)
            if errs:
                for col in range(1, 4):
                    error_ws.cell(row=i, column=col).fill = red_fill

        error_wb.save(full_error_path)

        # Log error file
        insert_error_log({"type": "topic", "filename": error_filename}, clientid)

        if valid_percent >= 80:
            for item in valid_data:
                insert_topic(item)
            return jsonify({
                'success': True,
                'status': 200,
                'message': f"{valid} out of {total} topics inserted. Errors logged in file.",
                'response': {'error_file': error_filename}
            })
        else:
            return jsonify({
                'success': False,
                'status': 500,
                'message': f"Less than 80% valid rows. No data inserted.",
                'response': {'error_file': error_filename}
            })

    except Exception as e:
        return jsonify({
            'success': False,
            'status': 500,
            'message': 'Error processing file.',
            'response': str(e)
        })


@master_bp.route('/topics', methods=['POST'])
def topics():
    try:
        data = request.json
        if not validate_topic_data(data):
            return jsonify({
                'success': False,
                'status': 400,
                'message': 'Every field is required to start.',
                'response': None
            })
        
        clientid = data.get('clientid')

        topics = fetch_all_topics(data)
        if not topics:
            return jsonify({
                'success': False,
                'status': 500,
                'message': 'Couldn’t load topics right now. Please try again soon.',
                'response': None
            })

        # Fetch categories grouped by topicid
        category_rows = get_categories(clientid)

        # Build topicid -> categories mapping
        topic_categories_map = {row['topicid']: row['categories'] for row in category_rows}

        # Merge categories into each topic
        for topic in topics:
            topic_id = topic.get('topic_id')
            topic['categories'] = topic_categories_map.get(topic_id, '')

        return jsonify({
            'success': True,
            'status': 200,
            'message': '',
            'response': topics
        })

    except Exception as e:
        print(f"Error in /topics: {e}")
        return jsonify({
            'success': False,
            'status': 500,
            'message': 'Something went wrong. Please try again later.',
            'response': None
        })
    
@master_bp.route('/update_topic', methods=['POST'])
def update_topic():
    try:
        data = request.json
        if not validate_update_topic_data(data):
            return jsonify({
                'success': False,
                'status': 400,
                'message': 'Every field is required to update.',
                'response': None
            })

        result = update_topic_data(data)
        if not result:
            return jsonify({
                'success': False,
                'status': 500,
                'message': 'Couldn’t update image right now. Please try again soon.',
                'response': None
            })

        return jsonify({
            'success': True,
            'status': 200,
            'message': 'Image updated successfully.',
            'response': None
        })

    except Exception as e:
        print(f"Error in /topics: {e}")
        return jsonify({
            'success': False,
            'status': 500,
            'message': 'Something went wrong. Please try again later.',
            'response': None
        })
    
@master_bp.route('/questions', methods=['POST'])
def questions():
    try:
        data = request.json
        if not validate_question_data(data):
            return jsonify({
                'success': False,
                'status': 400,
                'message': 'Every field is required to start.',
                'response': None
            })

        questions = fetch_all_questions(data)
        if not topics:
            return jsonify({
                'success': False,
                'status': 500,
                'message': 'Couldn’t load questions right now. Please try again soon.',
                'response': None
            })

        return jsonify({
            'success': True,
            'status': 200,
            'message': '',
            'response': questions
        })

    except Exception as e:
        print(f"Error in /topics: {e}")
        return jsonify({
            'success': False,
            'status': 500,
            'message': 'Something went wrong. Please try again later.',
            'response': None
        })
