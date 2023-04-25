import 'package:flutter/material.dart';
import 'package:integration_flask/Deuxieme_Projet/Api/clientapi.dart';

class AjouterClient extends StatefulWidget {
  const AjouterClient({ Key? key }) : super(key: key);

  @override
  State<AjouterClient> createState() => _AjouterClientState();
}

class _AjouterClientState extends State<AjouterClient> {

  final txtnomClt = TextEditingController();
  final txtContact = TextEditingController();

  bool nomCltValider = false;
  bool contactValider = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Creation de client"),
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
                hintText: 'Nom du client ',
                errorText: nomCltValider ? 
                      'la valeur du nom de client ne peut etre null' : 
                      null
              ),
              controller: txtnomClt,
            ),
          ),

          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            child: TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Contact',
                errorText: nomCltValider ? 
                      'Ajouter le contact du client' : 
                      null
              ),
              controller: txtContact,
            ),
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              /*Padding(
                padding: const EdgeInsets.symmetric(horizontal :12 , vertical: 12),
                child:*/ TextButton(
                  style: TextButton.styleFrom(
                    primary: Colors.white,
                    backgroundColor: Colors.blue
                  ),
                  child: Text(
                    "Sauvegarder".toUpperCase()
                  ),
                  onPressed: () async {
                    setState(() {
                      // Si les champs de text sont vides et on essaye de valider
                      txtnomClt.text.isEmpty 
                        ? nomCltValider = true 
                        : nomCltValider = false ;

                      txtContact.text.isEmpty 
                        ? contactValider = true 
                        : contactValider = false ;

                    });

                    if ( nomCltValider == false && contactValider == false) {
                      print("txtnomClt.text, " +txtnomClt.text +" txtContact.text " + txtContact.text);
                      //On cree resultat la je pense pour que quand on nif de save on est pas obliger de reload derriere pour que sa work
                     var resultat = await ClientApi().creationClient(txtnomClt.text, txtContact.text);
                     Navigator.pop(context,resultat);
                      
                    } 

                  }, 
                  
                ),
              /*),*/

              Padding(
                padding: const EdgeInsets.symmetric(horizontal :12 , vertical: 12),
                child: TextButton(
                  style: TextButton.styleFrom(
                    primary: Colors.white,
                    backgroundColor: Colors.red
                  ),
                  child: Text(
                    "Effacer".toUpperCase()
                  ),
                  onPressed: (){
                    txtnomClt.clear(); 
                    txtContact.clear();
                  }, 
                  
                ),
              ),
            ],
          )

          

          // ElevatedButton(
          //   child: Text("Valider"),
          //   onPressed: ()async {
          //     // await login(txtnomUtilisateur.text, txtMdp.text);

              // Navigator.push(
              //   context, 
              //   MaterialPageRoute(builder: (context) => HomePageView() )
              // );
              
          //   },
           
          // ),


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