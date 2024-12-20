import os
import base64
import numpy as np
import cv2
from flask import Flask, jsonify
from flask_socketio import SocketIO, emit
import mediapipe as mp
import tensorflow as tf

app = Flask(__name__)
socketio = SocketIO(app, cors_allowed_origins="*")  # Allow CORS for SocketIO

# Load the Keras CNN model
model = tf.keras.models.load_model('asl_finetuned_model2.h5')

# Initialize MediaPipe Hands
mp_hands = mp.solutions.hands
mp_drawing = mp.solutions.drawing_utils
hands = mp_hands.Hands(max_num_hands=1)

# Parameters
imgSize = 300  # Size used in dataset
input_size = 224  # Expected size by the model
labels = list("ABCDEFGHIJKLMNOPQRSTUVWXYZ")

def preprocess_image_for_model(img):
    """Preprocess the image for prediction."""
    img_resized = cv2.resize(img, (input_size, input_size))
    img_normalized = img_resized.astype('float32') / 255.0
    img_expanded = np.expand_dims(img_normalized, axis=0)
    return img_expanded

@socketio.on('frame')
def handle_frame(data):
    """Handles incoming frames, performs prediction, and emits results."""
    try:
        # Decode the base64-encoded image
        image_data = base64.b64decode(data['input_data'])
        np_image = np.frombuffer(image_data, dtype=np.uint8)

        # Convert to OpenCV image format
        img = cv2.imdecode(np_image, cv2.IMREAD_COLOR)
        if img is None:
            emit('error', {'error': 'Could not decode image'})
            return

        # Convert the image to RGB (required for MediaPipe)
        imgRGB = cv2.cvtColor(img, cv2.COLOR_BGR2RGB)

        # Process image and detect hands
        result = hands.process(imgRGB)

        if result.multi_hand_landmarks:
            for hand_landmarks in result.multi_hand_landmarks:
                # Create a blank white image for landmarks
                imgWhite = np.ones((imgSize, imgSize, 3), np.uint8) * 255

                # Draw landmarks
                mp_drawing.draw_landmarks(
                    imgWhite, hand_landmarks, mp_hands.HAND_CONNECTIONS,
                    mp_drawing.DrawingSpec(color=(0, 0, 255), thickness=3),
                    mp_drawing.DrawingSpec(color=(0, 255, 0), thickness=2)
                )

                # Preprocess the image for model prediction
                img_processed = preprocess_image_for_model(imgWhite)

                # Make prediction using the model
                predictions = model.predict(img_processed)
                predicted_index = np.argmax(predictions)
                predicted_label = labels[predicted_index]

                # Emit the prediction to the client
                emit('prediction', {'prediction': predicted_label})
        else:
            emit('error', {'error': 'No hand detected'})

    except Exception as e:
        print(f'Error during prediction: {e}')
        emit('error', {'error': 'An error occurred during processing.'})

if __name__ == '__main__':
    socketio.run(app, host='0.0.0.0', port=5000, debug=True)