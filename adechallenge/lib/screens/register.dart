import 'package:adechallenge/utils/dialogs.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

/*
This screen has a form which is used to register new users on the app. It asks for an email and password (two fields
to confirm it), and when the register button is clicked, the form is validated showing the corresponding errors on the
fields. Then, if everything is ok, a dialog appears. When the button on the dialog is clicked, it will go back to
the login page.
 */
class Register extends StatefulWidget {
  @override
  _RegisterState createState() {
    return new _RegisterState();
  }
}

class _RegisterState extends State<Register> {
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
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Theme.of(context).accentColor,
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
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
                children: [_emailField(), _passwordField(), _confirmPasswordField(), _button()],
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

  Widget _confirmPasswordField() {
    return Container(
      margin: EdgeInsets.only(top: 8.0),
      child: TextFormField(
        obscureText: true,
        validator: (v) {
          if (v!.isEmpty)
            return "Este campo no puede estar vacío";
          else if (v != password)
            return "Las contraseñas no coinciden";
          else
            return null;
        },
        decoration:
            InputDecoration(border: OutlineInputBorder(), labelText: "Contraseña", prefixIcon: Icon(Icons.check)),
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
              await _auth.createUserWithEmailAndPassword(email: email, password: password);
              acceptDialogRegister(context, "Cuenta registrada con éxito.");
            } on FirebaseAuthException catch (e) {
              String message = "";
              if(e.code == 'weak-password')
                message = "La contraseña es muy débil.";
              else if (e.code == 'email-already-in-use')
                message = "El correo electrónico ya está en uso.";
              errorDialog(context, message);
            }
          }
        },
        child: Text(
          "Registrarse",
        ),
      ),
    );
  }
}
