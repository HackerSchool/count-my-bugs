from random import *
from email.message import EmailMessage
import ssl
import smtplib
import json
from flask import Flask, jsonify, request
from flask_cors import CORS
import cv2 as cv
import numpy as np
import base64


app = Flask(__name__)
CORS(app)

test = ""

@app.route("/post", methods=["POST"])
def apost_req():
    global test
    output = request.get_json(force = True)
    image_array = np.array(output, dtype=np.uint8)
    image = cv.imdecode(image_array, cv.IMREAD_GRAYSCALE)
    test = image
    return jsonify(output)

@app.route("/get", methods=["GET"])
def get_req():
    global test
    retval, buffer = cv.imencode('.jpg', test)
    test = base64.b64encode(buffer).decode('utf-8')
    return jsonify(test)

if __name__ == '__main__':
    app.run(debug=True,port=2000)
