from flask import Flask, request, jsonify
from flask_expects_json import expects_json
import mysql.connector
from mysql.connector import MySQLConnection, Error
import os
app = Flask(__name__)

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
    return "Welcome to CG Backend Web Page"
    
@app.route("/postnumbers", methods=['POST'])
@expects_json(schema)
def postNumbers():
        numberone = int(request.json.get('numberone', ''))
        numbertwo = int(request.json.get('numbertwo', ''))
        total = numberone + numbertwo
        db_connection = connect()
        cursor = db_connection.cursor()
        sql = ("INSERT INTO Numbers(numberone, numbertwo, total) " \
                        "VALUES(%s,%s,%s)")
        values = (numberone, numbertwo, total)
        cursor.execute(sql, values)
        print ('The total is: ',total)
        db_connection.commit()
        
        return str(total)

def connect():
    """ Connect to MySQL database """
    conn = None
    dbHost = os.environ['DBHOST']
    dbName = os.environ['DBNAME']
    dbUser = os.environ['DBUSER']
    dbPass = os.environ['DBPASS']
    config = {
        'user': dbUser,
        'password': dbPass,
        'host': dbHost,
        'database': dbName,
    }
    try:
        conn = mysql.connector.connect(**config)
        if conn.is_connected():
            return conn
 
    except Error as e:
        print(e)

if __name__ == '__main__':
    app.run(use_reloader=True, host='0.0.0.0', port=8080)