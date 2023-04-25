from flask import Flask , request , jsonify
import json
import random
import requests

app = Flask(__name__)

ListVille = []

loginList = [{"username": "vianney" , "password" : "123"}]

@app.route("/get_marker",methods=['GET'])
def getMarker():

    listMarker = ['Bassam','Gonzagueville','Cocody','marcory']
    villeChoisit = listMarker[random.randint(0 , 3)]

    return json.dumps({ "Ville" : villeChoisit })

#Ajoutter parametre
@app.route("/get/<nom>/<annee>",methods=['GET'])
def getInfo(nom, annee):

    return "Tu t appelle " + nom + " et tu a " + annee + " ans"

#Pour les post on a besoin de request
#Post dans ma liste vide
@app.route("/ajouter_ville",methods=['POST']) 
def ajouterVille():

    data = request.get_json()
    ListVille.append(data["Villename"])
    # return jsonify({'message': 'Donnée ajoutée avec succès'})

    #La condition sert a voir si il y'a quelque chose dans le username
    if "Villename" in data:
        ListVille.append(data["Villename"])
        return "Cree avec succes !", 200
    else:
        return 'mauvaise requete',400


@app.route("/villeAjoutter",methods=['GET'])
def getVilleajoutter():
    
    return jsonify( ListVille )


#Authentification
@app.route("/login",methods=['POST']) 
def connexion_utilisateur():

    contenu = request.get_json()
    username = contenu['username']
    password = contenu['password']

    # Pour tout element (utilisateur) dans la loginList
    for utilisateur in loginList:
        if utilisateur['username'] == username and utilisateur['password'] == password:
            return jsonify({'message': 'connexion réussie'})
    return jsonify({'message': 'connexion echouee l utilisateur n est pas reconnue'})

# def login():

#     json.dumps({ "Ville" : villeChoisit })
#     _json = request.json
#     # _json = request.get_json()
#     _nom = _json['username']
#     _mdp = _json['password']
#     print(_nom + _mdp)

#     return jsonify({"vous ete connecter "})
    # if _nom and _mdp :
    #     return jsonify({"vous ete connecter ent tant que"})
    # else :
    #     return jsonify({ 'mauvaise requete' })



if __name__ == "__main__":

    app.run(debug=True)
    print("L api est lancee ")