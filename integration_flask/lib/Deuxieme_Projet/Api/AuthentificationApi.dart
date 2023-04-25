import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Authentification {
  
  /*Future login*/static dynamic login(String nomUtilisateur,String mdp) async {
    print("Lancement de login dans class Authentification");
    final url = Uri.parse('http://10.0.2.2:5000/authentification');
    final response = await http.post(
      url,
      headers: <String, String>{'Content-Type': 'application/json; charset=UTF-8'}, 
      body: json.encode({
        "username": nomUtilisateur,
        "password": mdp,
      })
    );
    //Je le cree pour pouvoir decoder la reponse et prendre en particulier le message
    // var responseJson;

    //Test si la connection aek l'api marche
    if (response.statusCode == 201 || response.statusCode == 200) {

      var responseJson = json.decode(response.body);//Decoder la reponse
      print(' Api Oook nom Utilisateur ' + nomUtilisateur.toString() + " connexion en cour ... "+ response.body );
      return responseJson;

    } else {
      // throw Exception('Echec de connexion' );
      var responseJson = json.decode(response.body);
      print('Api User ou mdp inconnue '+ responseJson.toString());
    }
  }


}