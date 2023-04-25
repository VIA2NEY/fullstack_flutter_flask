import 'package:flutter/material.dart';
import 'package:integration_flask/Deuxieme_Projet/Models/modele_client.dart';

import 'Api/clientapi.dart';

class ModifierClient extends StatefulWidget {

  final Client client ;

   ModifierClient( this.client) ;

  @override
  State<ModifierClient> createState() => _ModifierClientState();
}

class _ModifierClientState extends State<ModifierClient> {

  final txtnomClt = TextEditingController();
  final txtContact = TextEditingController();

  bool nomCltValider = false;
  bool contactValider = false;

  @override
  void initState() {

    txtnomClt.text = widget.client.nomClt.toString() ; /* toString a cause des null j'ai mis */
    txtContact.text = widget.client.contact.toString();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Modification de client"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
  
            const Text(
              "Modifier les details de l'utilisateur",
              style: TextStyle(
                fontSize: 20,
                color: Colors.blue,
                fontWeight: FontWeight.w500
              ),
            ),

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
                    "Modifier".toUpperCase()
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
                     var resultat = await ClientApi().modifClient(widget.client.idClt!, txtnomClt.text, txtContact.text);
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
                    "Annuler".toUpperCase()
                  ),
                  onPressed: (){
                    Navigator.pop(context) ;
                  }, 
                  
                ),
              ),
            ],
          )



          ],
        ),
      ),

    );
  }
}