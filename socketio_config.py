# socketio_config.py
from flask import Flask
from flask_socketio import SocketIO, emit
from flask_cors import CORS
app = Flask(__name__)  # or import it if defined elsewhere
CORS(app, supports_credentials=True)  # Allow cross-origin
socketio = SocketIO(app, cors_allowed_origins="*", async_mode="eventlet")

@socketio.on('connect')
def handle_connect():
    print('Client connected')
    emit('response', {'message': 'Connected to server'})

@socketio.on('disconnect')
def handle_disconnect():
    print('Client disconnected')
