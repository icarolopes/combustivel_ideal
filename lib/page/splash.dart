import 'package:combustivel_ideal/page/Home.dart';
import 'package:flutter/material.dart';

class SplashHome extends StatefulWidget {
  @override
  _SplashHomeState createState() => _SplashHomeState();
}

class _SplashHomeState extends State<SplashHome> {

  @override
  void initState() {
    Future.delayed(Duration(seconds: 5)).then((_) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute (
          builder: (context) => Home()
        )
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold (
      body: Padding (
        padding: EdgeInsets.all(35.0),
        child: Column (
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container (
              child: Text (
                'Icaro Lopes',
                textAlign: TextAlign.center
              )
            ),
            Container (
              child: Image.asset('images/logo.png')
            ),
            Container (
              child: Text (
                'v0.1',
                textAlign: TextAlign.center,
              )
            )
          ],  
        )
      )
    );
  }
}