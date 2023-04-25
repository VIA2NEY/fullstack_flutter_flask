import 'package:flutter/material.dart';
import 'package:integration_flask/Deuxieme_Projet/home_page.dart';


import 'Api/AuthentificationApi.dart';


class LoginPage extends StatefulWidget {
  const LoginPage({ Key? key }) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  final txtnomUtilisateur = TextEditingController();
  final txtMdp = TextEditingController();

  Future authetification() async {

    txtnomUtilisateur.text = "vianney";
    txtMdp.text = "123";

    // Si le user a entrer des valeur
    if (txtnomUtilisateur.text.isNotEmpty && txtMdp.text.isNotEmpty) {
        
        var responseJson = await Authentification.login(
              txtnomUtilisateur.text, txtMdp.text
        );
        print("***************** DEBUT Auth *****************");
        print(responseJson['message']) ;
        print("****************** FIN Auth ******************");
        if(responseJson == null ){ //en generale quand la connexion passe pas (mal gerer)
          
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Une erreur est survenue, veuillez réessayer')));
        } else {

          if (responseJson['message'] == 'Authentification reussie') {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const HomePageView()),
          );
          } else { // (mal gerer)

            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Ce utilisateur est inconnue !')));
            
          }

        }
      } else { //Si le user na r ecrit
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Veuillez renseigner tous les champs !')));
      }

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Authentification"),
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

              await authetification();

              // Navigator.push(
              //   context, 
              //   MaterialPageRoute(builder: (context) => HomePageView() )
              // );
              
            },
           
          ),


          ],
        ),
      ),
    );
  }
}