from flask import Flask, jsonify, request
import pyautogui

app = Flask(__name__)

@app.route('/ping', methods=['GET'])
def ping():
    return jsonify({'message': 'pong'})

def move_cursor(xOffset, yOffset):
    current_x, current_y = pyautogui.position()
    new_x = current_x + xOffset
    new_y = current_y + yOffset
    pyautogui.moveTo(new_x, new_y, duration=0.1)

@app.route('/click', methods=['POST'])
def click_button():
    data = request.get_json()
    if not data:
        return jsonify({"error": "Invalid input"}), 400

    button = data.get('button')
    if button is None:
        return jsonify({"error": "Invalid input"}), 400

    pyautogui.click(button=button)
    return jsonify({"message": "Success"}), 200

@app.route('/move_cursor', methods=['POST'])
def move_cursor_handler():
    data = request.get_json()
    if not data:
        return jsonify({"error": "Invalid input"}), 400

    xOffset = data.get('xOffset')
    yOffset = data.get('yOffset')
    if xOffset is None or yOffset is None:
        return jsonify({"error": "Invalid input"}), 400
    move_cursor(xOffset, yOffset)
    return jsonify({"message": "Success"}), 200

if __name__ == '__main__':
    app.run(host='192.168.1.3', port=5000, debug=True)