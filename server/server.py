from firebase import firebase
firebase= firebase.FirebaseApplication('https://stamp-db6ad-default-rtdb.europe-west1.firebasedatabase.app/', None)#https://your_storage.firebaseio.com
result = firebase.get('/users', None)
#http://ozgur.github.io/python-firebase/
#eur3

data = {
    'name': 'user1',
    'email': 'user1@student.uu.se',
    'phone': 46701234567,
    'pwd': 'abc123',
    'pwd_confirm': 'abc123', #bool?
    'program': 'IT',
    'image': 'img_url',
}

result = firebase.post('/stamp-db6ad-default-rtdb/student', data)
print(result)



#def wri(dest):
#    from firebase_admin import db

#    ref = db.reference("/") #Setting ref to db root

#    import json
#    with open(dest, "r") as f:
#        file_cont = json.load(f)
#    ref.set(file_cont)
    #https://www.freecodecamp.org/news/how-to-get-started-with-firebase-using-python/
    