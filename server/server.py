from firebase import firebase
from firebase_admin import db
#import json
firebase= firebase.FirebaseApplication('https://stamp-db6ad-default-rtdb.europe-west1.firebasedatabase.app/', None)
#https://your_storage.firebaseio.com
location = '/stamp-db6ad-default-rtdb/student/'
#WRITING data TO SERVER
data = {
    'name': 'user1',
    'email': 'user1@student.uu.se',
    'phone': 46701234567,
    'pwd': 'abc123',
    'pwd_confirm': 'abc123', #bool?
    'program': 'IT',
    'image': 'img_url',
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

