import 'package:adechallenge/utils/dialogs.dart';
import 'package:adechallenge/utils/navigations.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// This screen has a form which is used to login users on the app. It asks for an email and password and when the login
/// button is clicked, the form is validated showing the corresponding errors on the
/// fields. Then, if everything is ok, the user is redirected to the search_venues screen.
class Login extends StatefulWidget {
  @override
  _LoginState createState() {
    return new _LoginState();
  }
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  late String email;
  late String password;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Text("ADEChallenge", style: Theme.of(context).textTheme.headline5),
        ),
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: 30.0),
          child: Form(
            key: _formKey,
            autovalidateMode: AutovalidateMode.disabled,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [_emailField(), _passwordField(), _button(), _registerYet()],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _emailField() {
    return Container(
      child: TextFormField(
        textCapitalization: TextCapitalization.words,
        validator: (v) {
          if (v!.isEmpty)
            return "This field cannot be empty.";
          else if (!RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(v))
            return "Not valid email.";
          else
            return null;
        },
        decoration: InputDecoration(
            border: OutlineInputBorder(), labelText: "Email", prefixIcon: Icon(Icons.email)),
        onChanged: (value) => this.email = value,
      ),
    );
  }

  Widget _passwordField() {
    return Container(
      margin: EdgeInsets.only(top: 8.0),
      child: TextFormField(
        obscureText: true,
        validator: (v) {
          if (v!.isEmpty)
            return "This field cannot be empty.";
          else if (v.length <= 5)
            return "Password must have 6 characters at least.";
          else
            return null;
        },
        decoration:
        InputDecoration(border: OutlineInputBorder(), labelText: "Password", prefixIcon: Icon(Icons.lock)),
        onChanged: (value) => password = value,
      ),
    );
  }

  Widget _button() {
    return Container(
      margin: EdgeInsets.only(top: 16.0),
      padding: EdgeInsets.symmetric(horizontal: 30.0),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
            primary: Theme.of(context).primaryColor,
            elevation: 3
        ),
        onPressed: () async {
          if(_formKey.currentState!.validate()){
            try {
              await _auth.signInWithEmailAndPassword(email: email, password: password);
              SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
              sharedPreferences.setString("loggedUser", _auth.currentUser!.uid);
              navigateToSearchVenues(context);
            } on FirebaseAuthException catch (e) {
              String message = "";
              if(e.code == 'user-not-found')
                message = "User not found.";
              else if (e.code == 'wrong-password')
                message = "Wrong password given.";
              errorDialog(context, message);
            }
          }
        },
        child: Text(
          "Log in",
        ),
      ),
    );
  }

  Widget _registerYet() {
    return Container(
        margin: EdgeInsets.only(top: 24.0),
        child: Align(
            alignment: Alignment.bottomCenter,
            child: Column(children: <Widget>[
              new Text(
                "Not registered yet?",
              ),
              ElevatedButton(
                onPressed: () {
                  navigateToRegister(context);
                },
                child: new Text(
                  "Register now!",
                ),
              )
            ])));
  }
}