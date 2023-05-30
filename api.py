from random import *
from email.message import EmailMessage
import ssl
import smtplib
import json
from flask import Flask, jsonify, request
from flask_cors import CORS


app = Flask(__name__)
CORS(app)

test = ""

@app.route("/post", methods=["POST"])
def apost_req():
    global test
    output = request.get_json(force = True)
    test = output
    print(output)
    return jsonify(output)

@app.route("/get", methods=["GET"])
def get_req():
    global test
    return jsonify(test)

if __name__ == '__main__':
    app.run(debug=True,port=2000)
