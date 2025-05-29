from flask import Blueprint, jsonify, request
import os
from datetime import datetime
from openpyxl import Workbook
from openpyxl.worksheet.datavalidation import DataValidation
from openpyxl.workbook.defined_name import DefinedName
from app.dao.quiz_dao import *
from app.validation.master_validation import validate_category_sample_excel

master_bp = Blueprint('master', __name__)

@master_bp.route('/category_sample_excel', methods=['POST'])
def generate_sample_excel():
    try:
        data = request.json

        if not validate_category_sample_excel(data):
            return jsonify({
                'success': False,
                'status': 400,
                'message': 'Invalid input data.',
                'response': {}
            })

        topics = fetch_all_topics(data)

        topic_names = [t['name'] for t in topics]
        topic_map = {t['name']: t['topic_id'] for t in topics}

        if not topic_names:
            return jsonify({
                'success': False,
                'status': 400,
                'message': 'No topics found to generate dropdown.',
                'response': {}
            })

        wb = Workbook()
        ws = wb.active
        ws.title = "Categories"

        # Hidden sheet for dropdown values
        hidden_ws = wb.create_sheet("DropdownData")
        for idx, topic_name in enumerate(topic_names, start=1):
            hidden_ws.cell(row=idx, column=1).value = topic_name
        hidden_ws.sheet_state = 'hidden'

        # Define named range for dropdown
        dropdown_range = f'DropdownData!$A$1:$A${len(topic_names)}'
        wb.defined_names.add(DefinedName(name='TopicList', attr_text=dropdown_range))

        # Headers
        ws.append(["topicname", "categoryname"])

        # Add 10 blank rows
        for _ in range(10):
            ws.append(["", ""])

        # Create and apply dropdown data validation
        dv = DataValidation(
            type="list",
            formula1="=TopicList",
            allow_blank=False,
            showDropDown=True
        )
        dv.error = 'Please select a valid topic from the dropdown.'
        dv.errorTitle = 'Invalid Selection'
        dv.prompt = 'Select a topic from the list.'
        dv.promptTitle = 'Topic Dropdown'
        ws.add_data_validation(dv)

        for row in range(2, 12):  # Rows 2–11 in column A
            dv.add(ws[f"A{row}"])

        # Save file
        timestamp = datetime.now().strftime("%Y%m%d%H%M%S")
        filename = f"category_sample_{timestamp}.xlsx"
        save_path = os.path.join(os.getcwd(), "public", "downloads")
        os.makedirs(save_path, exist_ok=True)
        full_path = os.path.join(save_path, filename)
        wb.save(full_path)

        return jsonify({
            'success': True,
            'status': 200,
            'message': 'Excel generated successfully.',
            'response': filename
        })

    except Exception as e:
        return jsonify({
            'success': False,
            'status': 500,
            'message': 'Error generating Excel file.',
            'response': str(e)
        })
