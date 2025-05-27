from flask import Blueprint, jsonify, request, send_file
import pandas as pd
import os
from datetime import datetime
from openpyxl import Workbook
from openpyxl.worksheet.datavalidation import DataValidation
from openpyxl.utils import get_column_letter
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

        topics = fetch_all_topics(data)  # Should return a list of dicts: [{'topic_id': 1, 'topic_name': 'Algebra'}, ...]

        topic_names = [t['name'] for t in topics]
        topic_map = {t['name']: t['topic_id'] for t in topics}  # For reverse mapping on upload

        # Create workbook and sheets
        wb = Workbook()
        ws = wb.active
        ws.title = "Categories"

        # Hidden sheet for dropdown values
        hidden_ws = wb.create_sheet("DropdownData")
        for idx, topic_name in enumerate(topic_names, start=1):
            hidden_ws.cell(row=idx, column=1).value = topic_name
        hidden_ws.sheet_state = 'hidden'

        # Headers
        ws.append(["topicname", "categoryname"])

        # Add 10 blank rows
        for _ in range(10):
            ws.append(["", ""])

        # Dropdown validation formula
        formula_range = f'DropdownData!$A$1:$A${len(topic_names)}'
        dv = DataValidation(type="list", formula1=f'={formula_range}', allow_blank=False, showDropDown=True)
        dv.error = 'Please select a valid topic from the dropdown.'
        dv.errorTitle = 'Invalid Selection'
        dv.prompt = 'Select a topic from the list.'
        dv.promptTitle = 'Topic Dropdown'

        # Attach validation and apply to rows
        ws.add_data_validation(dv)
        for row in range(2, 12):
            dv.add(ws[f"A{row}"])  # column A = topicname

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
