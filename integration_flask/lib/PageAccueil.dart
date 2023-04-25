import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context) ;
          },
          icon: Icon(Icons.arrow_back_ios)
        ),
      ),
      body: Center(
        child: Text(
          "HELLO THERE !!!"
        ),
      ),
    );
  }
}