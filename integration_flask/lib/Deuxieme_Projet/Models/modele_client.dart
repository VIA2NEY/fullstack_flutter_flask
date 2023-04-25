import 'package:flutter/material.dart';

// class Client {


//   final int Id;
//   final String nom ;
//   final String contact ;

  

//   Client(
//     {
//       required this.Id,
//       required this.nom,
//       required this.contact,
//     }
//   );

//   factory Client.fromjson(Map<String, dynamic>json) => Client( 
//     Id: json["Id_clt"],
//     nom: json["Nom_clt"],
//     contact: json["Contact"] 
//   );

//   Map<String, dynamic> toJson() => {
//     "Id_clt" : Id,
//     "Nom_clt" : nom,
//     "Contact" : contact
//   };

// }

class Client {
  final int? contact;
  final int? idClt;
  final String? nomClt;

  const Client({
    required this.contact,
    required this.idClt,
    required this.nomClt
  });

  factory Client.fromJson(Map<String, dynamic> json) {
    return Client(
      contact: json['Contact'], 
      idClt: json['Id_clt'], 
      nomClt: json['Nom_clt']
    );
    
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Contact'] = contact/*this.contact*/;
    data['Id_clt'] = idClt/*this.idClt*/;
    data['Nom_clt'] = nomClt/*this.nomClt*/;
    return data;
  }

  @override
  String toString (){
    String result = nomClt.toString();/** */
    return result;
  }
}
