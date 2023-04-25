# from flask import Flask, request, jsonify
# from flask_sqlalchemy import SQLAlchemy
# from werkzeug.security import generate_password_hash


# db = SQLAlchemy()


# class Utilisateur(db.Model):
#     id = db.Column(db.Integer, primary_key=True)
#     name = db.Column(db.String(30), nullable=False)
#     password = db.Column(db.String(10), nullable=False)


# class Client(db.Model):
#     id = db.Column(db.Integer, primary_key=True)
#     name = db.Column(db.String(100), nullable=False)
#     phone = db.Column(db.String(100), nullable=False)


# app = Flask(__name__)

# # db = SQLAlchemy()
# app.config["SQLALCHEMY_DATABASE_URI"] = "mysql+pymysql://root:@localhost:3306/test_fullstack "
# app.config['SECRET_KEY'] = "random string"
# app.config["SQLALCHEMY_TRACK_MODIFICATIONS"] = False

# db.init_app(app)


# #Authentification
# @app.route("/login",methods=['POST']) 
# def connexion_utilisateur():

#     passhash = generate_password_hash('1234')
#     print(passhash)

#     contenu = request.get_json()
#     username = contenu['username']
#     password = contenu['password']

#     # Pour tout element (utilisateur) dans la loginList
#     for utilisateur in loginList:
#         if utilisateur['username'] == username and utilisateur['password'] == password:
#             return jsonify({'message': 'connexion réussie'})
#     return jsonify({'message': 'connexion echouee l utilisateur n est pas reconnue'})


# @app.route("/home", methods=['POST'])
# def homelogin():

#     # _json = request.json
#     # _json = request.get_json()
#     _json = request.json
#     username = _json['username']
#     password = _json['password'] 

#     std = Utilisateur.query.filter_by(name=username, password=password).first()
#     if std:
#         return jsonify({'message': 'connexion réussie'})
#     else:
#         return jsonify({'message': 'connexion echouee l utilisateur n est pas reconnue'})




# if __name__ == "__main__":

#     app.run(debug=True, port=4000)