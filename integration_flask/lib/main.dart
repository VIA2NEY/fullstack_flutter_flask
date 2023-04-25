import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'Deuxieme_Projet/Login.dart';
import 'PageAccueil.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
      
        primarySwatch: Colors.blue,
      ),
      home: LoginPage()/*const MyHomePage(title: 'Flutter Demo Home Page')*/,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);


  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  final txtnomUtilisateur = TextEditingController();
  final txtMdp = TextEditingController();

  Future login(String nomUtilisateur,String mdp) async {
    print("Lancement");
    final url = Uri.parse('http://10.0.2.2:5000/login');
    final response = await http.post(
      url,
      headers: <String, String>{'Content-Type': 'application/json; charset=UTF-8'}, 
      body: json.encode({
        "username": nomUtilisateur,
        "password": mdp,
      })
    );
    //Je le cree pour pouvoir decoder la reponse et prendre en particulier le message
    var responseJson = null;

    //Test si la connection aek l'api marche
    if (response.statusCode == 201 || response.statusCode == 200) {

      responseJson = json.decode(response.body);//Decoder la reponse
      print('connexion réussie ' + nomUtilisateur.toString() + " Le response.body est "+ response.body +" et le responseJson du message est "+responseJson['message'] );

      if (responseJson['message'] == 'connexion réussie') {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const HomePage()),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Ce utilisateur est inconnue !')));
      }

    } else {
      throw Exception('Echec de connexion' );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[


            Padding(
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
            child: TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Nom d\'utilisateur ',
              ),
              controller: txtnomUtilisateur,
            ),
          ),

          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            child: TextField(
              obscureText: true,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Mot de passe',
              ),
              controller: txtMdp,
            ),
          ),

          ElevatedButton(
            child: Text("Valider"),
            onPressed: ()async {
              await login(txtnomUtilisateur.text, txtMdp.text);
              print("tap");
              
            },
           
          ),


          ],
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: _incrementCounter,
      //   tooltip: 'Increment',
      //   child: const Icon(Icons.add),
      // ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
