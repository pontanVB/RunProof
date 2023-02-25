from flask import Flask, redirect, request
import firebase
from cryptography.fernet import Fernet
import json
from config import settings
import requests


config = settings.config
key = settings.key
database = settings.database

f = Fernet(key)

decrypted_bytestring = f.decrypt(bytes(config))
decrypted_string = decrypted_bytestring.decode("utf-8")
config = json.loads(decrypted_string)

decrypted_bytestring = f.decrypt(bytes(database))
database = decrypted_bytestring.decode("utf-8")


app = Flask(__name__)
firebase_app = firebase.initialize_app(config)

@app.route("/api/data", methods=["GET"])
def get_protected_data():
    # Add any custom authentication logic here
    auth_token = request.headers.get('Authorization')
    auth = firebase_app.auth()
    try:
        id_token = auth.refresh(auth_token)["idToken"]
    except:
        raise PermissionError
    uid = auth.get_account_info(id_token)["users"][0]["localId"]
    
    url = database + "users/" + uid + ".json"
    params = {"auth": id_token} #, "shallow": "true"}
    # Redirect to the Firebase Realtime Database endpoint
    response = requests.get(url, params=params).json()
    
    return response
    # return redirect("https://<PROJECT_ID>.firebaseio.com/protected_data.json")

if __name__ == "__main__":
    app.run(ssl_context='adhoc')

