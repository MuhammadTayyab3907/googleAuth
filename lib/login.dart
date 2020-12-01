import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_email_auth/dashboard.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FlutterLogin(
      title: "SAGAS DAD",
      onLogin: _loginUser,
      onSignup: _signupUser,
      onSubmitAnimationCompleted: () async {
        final FirebaseAuth _auth = FirebaseAuth.instance;
        await _auth.currentUser().then((user) => user != null
            ? Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => DashboardScreen()))
            : Fluttertoast.showToast(
                msg: "User not register before",
                toastLength: Toast.LENGTH_LONG,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.teal,
                textColor: Colors.white,
                fontSize: 19));
      },
      onRecoverPassword: _recoveryPassword,
    );
  }

  Future<String> _loginUser(LoginData loginData) {
    _handelSignIn(loginData.name.trim(), loginData.password)
        .then((user) => Fluttertoast.showToast(
            msg: "Welcome ${user.email}",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.teal,
            textColor: Colors.white,
            fontSize: 19))
        .catchError((e) => Fluttertoast.showToast(
            msg: '${e}',
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 19));
  }

  Future<FirebaseUser> _handelSignIn(String email, String password) async {
    FirebaseAuth _auth = FirebaseAuth.instance;
    FirebaseUser _user = (await _auth.signInWithEmailAndPassword(
            email: email, password: password))
        .user;
    return _user;
  }

  Future<String> _signupUser(LoginData loginData) {
    _handelSignUp(loginData.name.trim(), loginData.password)
        .then((user) => Fluttertoast.showToast(
            msg: "Welcome ${user.email}",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.teal,
            textColor: Colors.white,
            fontSize: 19))
            .catchError((e) => Fluttertoast.showToast(
            msg: '${e}',
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 19));
  }

  Future<FirebaseUser> _handelSignUp(String email, String password) async {
    FirebaseAuth _auth = FirebaseAuth.instance;
    FirebaseUser _user = (await _auth.createUserWithEmailAndPassword(
            email: email, password: password))
        .user;
    return _user;
  }

  Future<String> _recoveryPassword(String email) async {
    FirebaseAuth _auth = FirebaseAuth.instance;
    await _auth.sendPasswordResetEmail(email: email).catchError((e) =>
        Fluttertoast.showToast(
            msg: '${e}',
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 19));
  }
}
