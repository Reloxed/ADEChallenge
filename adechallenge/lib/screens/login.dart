import 'package:adechallenge/utils/dialogs.dart';
import 'package:adechallenge/utils/navigations.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

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
            return "Este campo no puede estar vacío";
          else if (!RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(v))
            return "El email no es válido";
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
            return "Este campo no puede estar vacío";
          else if (v.length <= 5)
            return "La contraseña debe tener mínimo 6 caracteres";
          else
            return null;
        },
        decoration:
        InputDecoration(border: OutlineInputBorder(), labelText: "Contraseña", prefixIcon: Icon(Icons.lock)),
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

            } on FirebaseAuthException catch (e) {
              String message = "";
              if(e.code == 'user-not-found')
                message = "Usuario no encontrado.";
              else if (e.code == 'wrong-password')
                message = "Contraseña errónea.";
              errorDialog(context, message);
            }
          }
        },
        child: Text(
          "Iniciar sesión",
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
                "¿Aún no te has registrado?",
              ),
              ElevatedButton(
                onPressed: () {
                  navigateToRegister(context);
                },
                child: new Text(
                  "¡Regístrate!",
                ),
              )
            ])));
  }
}