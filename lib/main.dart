import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'dashboard.dart';
import 'login.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    checkUserAlreadyLogin().then((islogin) {
      if (islogin == true) {
        print("Already login");
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => DashboardScreen()),
            (route) => false);
      } else {
        print("Not login");
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => LoginScreen()),
            (route) => false);
      }
    });
    return Scaffold(
      body: Card(
        child: Center(
          child: Text(
            "Loading...",
            style: TextStyle(
                fontSize: 25,
                color: Colors.indigo,
                fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }

  checkUserAlreadyLogin() async{
    FirebaseAuth _auth = FirebaseAuth.instance ;
    return _auth.currentUser().then((user) => user!= null ? true : false).catchError((onError)=>false);
  } 
}
