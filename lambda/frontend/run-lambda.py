from flask_lambda import FlaskLambda
from app import main

http_server = main(FlaskLambda)