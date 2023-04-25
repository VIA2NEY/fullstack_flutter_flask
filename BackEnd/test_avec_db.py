from flask import Flask, request, jsonify
from flask_sqlalchemy import SQLAlchemy
# from werkzeug.security import generate_password_hash,check_password_hash

import json

db = SQLAlchemy()

class Utilisateur(db.Model):
    Id_user = db.Column(db.Integer, primary_key=True)
    Nom_user = db.Column(db.String(30), nullable=False)
    Mdp = db.Column(db.String(10), nullable=False)


class Client(db.Model):
    Id_clt = db.Column(db.Integer, primary_key=True)
    Nom_clt = db.Column(db.String(100), nullable=False)
    Contact = db.Column(db.String(100), nullable=False)


app = Flask(__name__)

app.config["SQLALCHEMY_DATABASE_URI"] = "mysql+pymysql://root:@localhost:3306/fullstack_flask_flutter"
app.config['SECRET_KEY'] = "random string"
app.config["SQLALCHEMY_TRACK_MODIFICATIONS"] = False

db.init_app(app)


@app.route("/listuser", methods=['GET'])
def get_utilisateurs():
    utilisateurs = Utilisateur.query.all()
    result = []
    for chaqueutilisateur in utilisateurs:
        utilisateur_datajson = {}
        utilisateur_datajson['Id_user'] = chaqueutilisateur.Id_user
        utilisateur_datajson['Nom_user'] = chaqueutilisateur.Nom_user
        utilisateur_datajson['Mdp'] = chaqueutilisateur.Mdp
        result.append(utilisateur_datajson)
    return jsonify(result)


@app.route('/authentification', methods=['POST'])
def authentification():
    nom_utilisateur = request.json['username']
    mdp = request.json['password']
    utilisateur = Utilisateur.query.filter_by(Nom_user=nom_utilisateur).first()
    if utilisateur:
        if utilisateur.Mdp == mdp:
            response = jsonify({"message": "Authentification reussie"})
            response.status_code = 200
            return response
        else:
            response = jsonify({"message": "Mot de passe incorrect"})
            response.status_code = 401
            return response
    else:
        response = jsonify({"message": "Nom d'utilisateur incorrect"})
        response.status_code = 401
        return response

# @app.route('/authentification', methods=['POST'])
# def authentification():
    # nom_utilisateur = request.json['Nom_user']
    # mdp = request.json['Mdp']
    # utilisateur = Utilisateur.query.filter_by(Nom_user=nom_utilisateur).first()


    # print('Le MDP hasher dans la bd est ' + utilisateur.Mdp)
    # hashed_password = generate_password_hash(mdp, method='sha256')
    # print('Le MDP a tester est ' + mdp +' et son hashage donne ---'+ hashed_password)
    # is_valid_password = check_password_hash(utilisateur.Mdp, mdp )
    # print(is_valid_password)

    # if utilisateur:
    #     if check_password_hash(utilisateur.Mdp, mdp):
    #         response = jsonify({"message": "Authentification réussie"})
    #         response.status_code = 200
    #         return response
    #     else:
    #         response = jsonify({"message": "Mot de passe incorrect"})
    #         response.status_code = 401
    #         return response
    # else:
    #     response = jsonify({"message": "Nom d'utilisateur incorrect"})
    #     response.status_code = 401
    #     return response


@app.route('/creation_utilisateur', methods=['POST'])
def creation_utilisateur():
    nom_utilisateur = request.json['Nom_user']
    mdp = request.json['Mdp']
    nouveau_utilisateur = Utilisateur(Nom_user=nom_utilisateur, Mdp=mdp)
    db.session.add(nouveau_utilisateur)
    db.session.commit()
    response = jsonify({"message": "Nouvel utilisateur créé avec succès"})
    response.status_code = 201
    return response


#Requête pour client

@app.route("/listclient", methods=['GET'])
def get_clients():
    clients = Client.query.all()
    result = []
    for chaqueclients in clients:
        clients_datajson = {}
        clients_datajson['Id_clt'] = chaqueclients.Id_clt
        clients_datajson['Nom_clt'] = chaqueclients.Nom_clt
        clients_datajson['Contact'] = chaqueclients.Contact
        result.append(clients_datajson)
    # return jsonify(result)
    return json.dumps(result)

@app.route('/creation_clt', methods=['POST'])
def creation_client():
    nom_clt = request.json['Nom_clt']
    contact = request.json['Contact']
    nouveau_client = Client(Nom_clt=nom_clt, Contact=contact) #cree new clt qui a pour nom .. et contact ..
    db.session.add(nouveau_client)
    db.session.commit()
    response = jsonify({"message": "Nouvel client créé avec succès"})
    response.status_code = 201
    return response

#Recherche client par id 
@app.route('/listclient/<int:id>', methods=['GET'])
def getClientserbyId(id):
    # clients = Client.query.get(id) not in it
    # clients = Client.query.filter_by(Id_clt=id).first()
    # result = []

    # clients_datajson = {}
    # clients_datajson['Id_clt'] = clients.Id_clt
    # clients_datajson['Nom_clt'] = clients.Nom_clt
    # clients_datajson['Contact'] = clients.Contact
    # result.append(clients_datajson)
    # return jsonify(result)

    client = Client.query.filter_by(Id_clt=id).first()
    if client is None:
        return jsonify({'message': 'Aucun client trouvé avec cet ID'}), 404
    
    result = [{
        'Id_clt': client.Id_clt,
        'Nom_clt': client.Nom_clt,
        'Contact': client.Contact
    }]
    
    return jsonify(result)
    #Chercher a resoudre quand le user entre un id qui n'est pas dans la bd

# @app.route('/listclient/<nom>', methods=['GET'])
# # Recherche user par nom
# def getUserbyNom(nom): 
#     client = Client.query.filter_by(Id_clt=nom).first()
#     if client is None:
#         return jsonify({'message': 'Aucun client trouvé avec ce nom'}), 404
    
#     result = [{
#         'Id_clt': client.Id_clt,
#         'Nom_clt': client.Nom_clt,
#         'Contact': client.Contact
#     }]

#     return jsonify(result)


# @app.route('/listclient/<nom>', methods=['GET'])
# # Recherche user par nom
# def getUserbyNom(nom): 
#     clients = Client.query.filter_by(Nom_clt=nom).first()
#     result = []

#     clients_datajson = {}
#     clients_datajson['Id_clt'] = clients.Id_clt
#     clients_datajson['Nom_clt'] = clients.Nom_clt
#     clients_datajson['Contact'] = clients.Contact
#     result.append(clients_datajson)
#     return jsonify(result)

#Modification client par id 
@app.route('/updateclient/<id>', methods=['PUT']) 
#PUT permet de faire des Modifications 
def UpdateClientbyId(id):
    clients = Client.query.filter_by(Id_clt=id).first()

    updNom_clt = request.json['Nom_clt']
    updContact = request.json['Contact']

    clients.Nom_clt = updNom_clt
    clients.Contact = updContact

    db.session.commit()
    response = jsonify({"message": "La modification du client ayant pour id " + id + ", nom "+ clients.Nom_clt + " effectéé avec succès, son nom est maitenant " + updNom_clt})

    return response #jsonify(result)


#Supprimer client par id 
@app.route('/deleteclient/<id>', methods=['DELETE']) 
#PUT permet de faire des Modifications 
def DeleteClientbyId(id):
    clients = Client.query.filter_by(Id_clt=id).first()

    db.session.delete(clients)
    db.session.commit()

    response = jsonify({"message": "La suppresion a éte effectéé avec succès"})

    return response




if __name__ == "__main__":

    app.run(debug=True, port=4000)