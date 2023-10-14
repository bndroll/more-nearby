import mediapipe as mp
from mediapipe.tasks import python
from mediapipe.tasks.python import vision
import cv2
import numpy as np
import tensorflow as tf
from tensorflow.keras.models import load_model

from fastapi import FastAPI, File, UploadFile
from fastapi.middleware.cors import CORSMiddleware


model_path = '/Users/jho00/Workspace/hackatons/gesture-recognizer/gesture_recognizer.task'
model = load_model('mp_hand_gesture')
# Load class names
f = open('gesture.names', 'r')
classNames = f.read().split('\n')
f.close()
print(classNames)
GestureRecognizer = mp.tasks.vision.GestureRecognizer
GestureRecognizerOptions = mp.tasks.vision.GestureRecognizerOptions
VisionRunningMode = mp.tasks.vision.RunningMode

app = FastAPI()

origins = [
    "*"
]

app.add_middleware(
    CORSMiddleware,
    allow_origins=origins,
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

import shutil

@app.get("/")
def read_root():
    return {"Hello": "World"}


@app.post("/recognize/")
def create_file(file: UploadFile = File(...)):
	with open("samples/test.jpeg", "wb") as buffer:
	    shutil.copyfileobj(file.file, buffer)

    cv2_image = cv2.imread('samples/test.jpeg')
    # print(x, y)
    cv2_image = cv2.flip(cv2_image, 1)
    x,y,c = cv2_image.shape
    mpHands = mp.solutions.hands
    hands = mpHands.Hands(max_num_hands=1, min_detection_confidence=0.7)
    framergb = cv2.cvtColor(cv2_image, cv2.COLOR_BGR2RGB)
    result = hands.process(framergb)
    landmarks = []
    if result.multi_hand_landmarks:
        for handslms in result.multi_hand_landmarks:
            for lm in handslms.landmark:
                # print(id, lm)
                lmx = int(lm.x * x)
                lmy = int(lm.y * y)

                landmarks.append([lmx, lmy])

    prediction = model.predict([landmarks])
    classID = np.argmax(prediction)
    className = classNames[classID]
    print(className)


	return { "result": className }