import firebase_admin
from firebase_admin import credentials
from firebase_admin import firestore
from numpy import rec

cred = credentials.Certificate("./serviceAccountKey.json")
firebase_admin.initialize_app(cred)

db = firestore.client()

def recipe_details(recipeName):
    result = db.collection('recipes').where('name','==',recipeName).get()
    if (result):
        data = {}
        for doc in result:
            data = doc.to_dict()
    
        ingredients = data['ingredients'].split('* ')
        del data['ingredients']
        data['ingredients'] = ingredients
        return data
    else:
        return False
    