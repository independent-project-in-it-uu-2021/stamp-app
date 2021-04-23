from firebase import firebase
#from firebase_admin import firebase
import firebase_admin
from firebase_admin import db
#import json


import firebase_admin
from firebase_admin import credentials

cred = credentials.Certificate("/home/daniel/kex/stamp-app/stamp-db6ad-firebase-adminsdk-tu6j1-5f9c6e5cea.json")
#create SDK:
firebase_admin.initialize_app(cred)


#Set db url
firebase= firebase.FirebaseApplication('https://stamp-db6ad-default-rtdb.europe-west1.firebasedatabase.app/', None)
#https://your_storage.firebaseio.com
location = '/stamp-db6ad-default-rtdb/student/'
#WRITING data TO SERVER
data = {"Gholam":{
    'name': 'user1',
    'email': 'user1@student.uu.se',
    'phone': 46701234567,
    'pwd': 'abc123',
    'pwd_confirm': 'abc123', #bool?
    'program': 'IT',
    'image': 'img_url',
    }   
}
result = firebase.post(location, data)
print(result)    

#RETRIVEING ALL DATA FROM SERVER

retrive = firebase.get(location, None)
print(retrive)

#UPDATING DATABASE FROM SERVER
test_user_id = 'MYyZHu3C2EAqdD8TzGx'
firebase.put(location + test_user_id, 'name', 'Gholam')

#DELETING DATA FROM DATABASE
test_del_id = '-MYyZ-oXjvMBI74gsEfw'
firebase.delete(location, test_del_id)

