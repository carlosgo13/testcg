from flask import Flask, request, jsonify
from flask_expects_json import expects_json
import requests, os
from flask_lambda import FlaskLambda
app = FlaskLambda(__name__)

schema = {
    'type': 'object',
    'properties': {
        'numberone': {'type': 'integer'},
        'numbertwo': {'type': 'integer'}
    },
    'required': ['numberone', 'numbertwo']
}

@app.route("/", methods=['GET'])
def main():
    return "Welcome to CG Frontend Web Page"
    
@app.route("/postnumbers", methods=['POST'])
@expects_json(schema)
def postNumbers():
    if request.json:
        numberone = request.json.get('numberone', '')
        numbertwo = request.json.get('numbertwo', '')
        resp = {"statusCode": 200,"body":{"total":sendNumbers(numberone, numbertwo)}}
        return (resp)

def sendNumbers(numberone, numbertwo):
    url = os.environ['BACKEND_URL']
    jsonObject = {'numberone':numberone, 'numbertwo':numbertwo}
    resp = requests.post(url, json=jsonObject)

    return (resp.text)

if __name__ == '__main__':
    app.run(use_reloader=True, host='0.0.0.0', port=80)