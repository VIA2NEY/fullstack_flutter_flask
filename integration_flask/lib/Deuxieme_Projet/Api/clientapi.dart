import 'dart:convert';
import 'package:http/http.dart' as http;

import '../Models/modele_client.dart';

class ClientApi {

  Future<List<Client>> fetchClients() async {

    final url = Uri.parse('http://10.0.2.2:5000/listclient');  
    final response = await http.get(url);
    if (response.statusCode == 200) {
      List<dynamic> jsonResponse = json.decode(response.body);
      return jsonResponse.map((client) => Client.fromJson(client)).toList();
    } else {
      throw Exception('Failed to load clients from API');
    }
    
  }

  Future<Client> creationClient(String nomClt, String contact) /*Future<void> creationClient(String nomClt, String contact)*/ async {
    var client = http.Client();
    final url = Uri.parse('http://10.0.2.2:5000/creation_clt');

    final response = await client.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'Nom_clt': nomClt,
        'Contact': contact,
      }),
    );

    if (response.statusCode == 201) {
      print('Nouveau client '+nomClt+' contact :' +contact + ' créé avec succès');
      return Client.fromJson(jsonDecode(response.body));
    } else {
      // print('Erreur lors de la création du client');
      throw Exception('Erreur lors de la création du client');
    }
  }


  Future<Map<String, dynamic>> rechercheCltById(int id) async {
    final url = Uri.parse('http://10.0.2.2:5000/listclient$id');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      return jsonData;
    } else {
      // Si la requête a échoué, on renvoie une erreur sous forme de Map
      return {'error': 'Impossible de récupérer le client'};
    }
  }


  Future<Client> modifClient(int id, String nom, String contact) async {
    final response = await http.put(Uri.parse('http://10.0.2.2:5000/updateclient/$id'), 
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'Nom_clt': nom, 'Contact': contact}));
    if (response.statusCode == 200) {
      // print('Client mis à jour avec succès');
      return Client.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Erreur lors de la mise à jour du client');
    }
  }


  /*Future<void> suprimClientById(int id)*/ Future<Client> suprimClientById(int id) async {
    final url = Uri.parse('http://10.0.2.2:5000/deleteclient/$id');
    
    final response = await http.delete(url);
    
    if (response.statusCode == 200) {
      // print('Client supprimé avec succès.');
      return Client.fromJson(jsonDecode(response.body));
    } else {
      // final body = jsonDecode(response.body);
      // print('Erreur lors de la suppression du client: ${body['message']}');
      throw Exception('Erreur lors de la création du client');
    }
  }

  // Future<List<Client>> getallClient() async {

  //   print("Lancement de la recuperation des clients");
  //   final url = Uri.parse('http://10.0.2.2:5000/listclient');  
  //   final response = await http.get(url);

  //   if (response.statusCode == 200) {
  //     print("OOK list des client get");

  //     // final jsonData = jsonDecode(response.body);
  //     // List<Client> clients = [];
  //     Map jsonData = jsonDecode(response.body);

  //     if (jsonData.isEmpty) {
  //       jsonEncode({"Null"});
  //     } else {
  //       return jsonDecode(response.body);
  //     }

  //     // Map jsonData = null ? jsonEncode({"Nothing"}) : jsonDecode(response.body);
  //     List clients = [];

  //     for (var json in jsonData) {
  //       clients.add(Client.fromJson(json));
  //     }
  //     return clients;
  //   } else {
  //     throw Exception('Impossible de charger l\'album');
  //   }

  // }

  // Future<List<Client>> getallClient() async {
    // print("Lancement de la recuperation des clients");
  //   final url = Uri.parse('http://10.0.2.2:5000/listclient');  
  //   final response = await http.get(url);
  //   if (response.statusCode == 200) {
  //     print("OOK list des client get");
  //     final jsonData = jsonDecode(response.body) as List<dynamic>;
  //     return jsonData.map((json) => Client.fromJson(json)).toList();
  //   } else {
  //     throw Exception('Impossible de charger les clients');
  //   }
  // }

  // Future<Client> /*Future<List<Client>>*/ getallClient() async {

  //   print("Lancement de la recuperation des clients");
  //   final url = Uri.parse('http://10.0.2.2:5000/listclient');  
  //   final response = await http.get(url);

  //   if (response.statusCode == 200) {

  //     print("OOK list des client get");

  //     return Client.fromJson(jsonDecode(response.body));
  //   } else {

  //     throw Exception('Impossible de charger l\'album');
  //   }
    
  // }

  // Future login(String nomUtilisateur,String mdp) async {
  //   print("Lancement");
  //   final url = Uri.parse('http://10.0.2.2:5000/login');
  //   final response = await http.post(
  //     url,
  //     headers: <String, String>{'Content-Type': 'application/json; charset=UTF-8'}, 
  //     body: json.encode({
  //       "username": nomUtilisateur,
  //       "password": mdp,
  //     })
  //   );
  //   //Je le cree pour pouvoir decoder la reponse et prendre en particulier le message
  //   var responseJson = null;

  //   //Test si la connection aek l'api marche
  //   if (response.statusCode == 201 || response.statusCode == 200) {

  //     responseJson = json.decode(response.body);//Decoder la reponse
  //     print('connexion réussie ' + nomUtilisateur.toString() + " Le response.body est "+ response.body +" et le responseJson du message est "+responseJson['message'] );

  //     if (responseJson['message'] == 'connexion réussie') {
  //       Navigator.push(
  //         context,
  //         MaterialPageRoute(builder: (context) => const HomePage()),
  //       );
  //     } else {
  //       ScaffoldMessenger.of(context).showSnackBar(
  //           SnackBar(content: Text('Ce utilisateur est inconnue !')));
  //     }

  //   } else {
  //     throw Exception('Echec de connexion' );
  //   }
  // }
  
}