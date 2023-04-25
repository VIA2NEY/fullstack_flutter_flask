import 'package:flutter/material.dart';
import 'package:integration_flask/Deuxieme_Projet/AjouterClient.dart';
import 'package:integration_flask/Deuxieme_Projet/ModifierClient.dart';

import 'Api/clientapi.dart';
import 'Models/modele_client.dart';

class HomePageView extends StatefulWidget {
  const HomePageView({ Key? key }) : super(key: key);

  @override
  State<HomePageView> createState() => _HomePageViewState();
}

class _HomePageViewState extends State<HomePageView> {

  // late Future<Client> getclient ;
  // late Future<List<Client>> getclient;
  late List<Client> getclient;
  bool _isLoading = true;

  Future<void> showBoiteDialog(String title, String msg) async {
    return showDialog<void>(
      context: context, 
      builder: (BuildContext context){
        return AlertDialog(
          title: Text(title),
          content:  SingleChildScrollView(
            child: Text(msg),
          ),

          actions: [
            TextButton(
              child: Text('Ok'),
              onPressed: (){
                Navigator.of(context).pop();
              } 
              
            )
          ],
        );
      }
    );
  }

  @override
  void initState() {

    super.initState();
    // getclient = ClientApi().getallClient() as List<Client> ;
    getClient();

  }

  Future<void> getClient() async {
    // getclient = await ClientApi().getallClient();
    getclient = await ClientApi().fetchClients();
    print(getclient.length);
    setState(() {
      _isLoading = false;
    });
    // print(getclient);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(),

      body: _isLoading
            ? Center(child: CircularProgressIndicator())
            : Column(
              children: [

                TextField(
                  onChanged: (value) => _runFilter(value),
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(0),
                    prefixIcon: Icon(
                      Icons.search,
                      color: Color(0xFF3A3A3A),
                      size: 20,
                    ),
                    prefixIconConstraints: BoxConstraints(
                      maxHeight: 20,
                      minWidth: 25,
                    ),
                    border: InputBorder.none,
                    hintText: 'Chercher ',
                    hintStyle: TextStyle(color: Color(0xFF717171)),
                  ),
                ),
                
                getclient.isEmpty 
                ? Center(child : Text("Aucun client n'a éte Ajouter !!!")) 
                :Expanded(
                  child: ListView.builder(
                    itemCount: getclient.length,
                    itemBuilder: (context, index){
                      return Card(
                        child: ListTile(
                          leading: Icon(Icons.person),
                          title: Text(
                            getclient[index].nomClt.toString(),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          subtitle: Text(
                            getclient[index].contact.toString(),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: Icon(Icons.edit) ,
                                onPressed: () async {
                                  
                                  Navigator.push(
                                    context, 
                                    MaterialPageRoute(builder: (context) => ModifierClient(getclient[index]) )
                                  ).then((data) {
                                    if (data != null) {
                                      getClient();// En gros c'est sa qui permet de reload automatiquement
                                      showBoiteDialog("Succes", " Les details de "+ data.toString() +" ont été mis a jour avec succes");
                                    } 
                
                                  });
                
                                }
                              ),
                              IconButton(
                                icon: Icon(Icons.delete) ,
                                onPressed: () async{
                                  Client client = await ClientApi().suprimClientById(getclient[index].idClt!); /*nulcheck a cause de erreur a rgler la ou jai mis les we en null la */
                
                                  getClient();
                                  showBoiteDialog("Succes", " Les details de "+ client.toString() +" on été suprimer avec succés avec succes");
                                }
                              )
                            ],
                          ),
                        ),
                      );
                    }
                  ),
                ),
              ],
            ),

      
      /*FutureBuilder<List<Client>>/*<Client>*/(
        future: getclient,
        builder: (context, snapshot) {

          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index){
                return Card(
                  child: ListTile(
                    leading: Icon(Icons.person),
                    title: Text(
                      snapshot.data![index].nomClt.toString(),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    subtitle: Text(
                      snapshot.data![index].contact.toString(),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(Icons.edit) ,
                          onPressed: (){}
                        ),
                        IconButton(
                          icon: Icon(Icons.delete) ,
                          onPressed: (){}
                        )
                      ],
                    ),
                  ),
                );
              }
            );


          } else if (snapshot.hasError) {
            return Text('${snapshot.error}');
          }

          // By default, show a loading spinner.
          return Center(child: const CircularProgressIndicator());

        },*/

      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () async {
          Navigator.push(
                context, 
                MaterialPageRoute(builder: (context) => AjouterClient() )
              ).then((data) {
                if (data != null) {
                  getClient();// En gros c'est sa qui permet de reload automatiquement
                  showBoiteDialog("Succes", " Les details de "+ data.toString() +" ajouter avec succes");
                } 

              });
        },
      ),
      
    );
  }

  void _runFilter(String enteredKeyword) {
    List<Client> client = [];
    if (enteredKeyword.isEmpty) {
      getClient();
    } else {
      client = getclient
          .where((item) => item.nomClt!
              .toLowerCase()
              .contains(enteredKeyword.toLowerCase()))
          .toList();
    }

    setState(() {
      getclient = client;
    });
  }

}