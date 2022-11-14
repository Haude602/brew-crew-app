import 'package:brew_crew/shared/loading.dart';
import 'package:flutter/material.dart';
import "package:brew_crew/services/auth.dart";
import "package:brew_crew/shared/constants.dart";

class Register extends StatefulWidget {
  // const Register({Key? key}) : super(key: key);
  final Function toggleView;
  Register({required this.toggleView});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final _formKey = GlobalKey<
      FormState>(); // for validatin input fields and make user input id and pasword
  final AuthService _auth = AuthService();
  bool loading = false;

  // text field state
  String email = '';
  String password = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            backgroundColor: Colors.brown[100],
            appBar: AppBar(
                backgroundColor: Colors.brown[400],
                elevation: 0.0,
                title: Text('Sign Up in to Brew Crew'),
                actions: <Widget>[
                  FlatButton.icon(
                    onPressed: () {
                      widget.toggleView();
                    }, //this will help to go to another page when clicked
                    icon: Icon(Icons.person),
                    label: Text('Sign In'),
                  )
                ]),
            body: Container(
                padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50),
                child: Form(
                    key: _formKey, // validating form with formkey
                    child: Column(
                      children: <Widget>[
                        SizedBox(height: 20.0),
                        TextFormField(
                          decoration: textInputDecoration.copyWith(
                              // .copywith() is used to include hintText of inside decoration as it cant be constant in constants.dart
                              hintText:
                                  'Email'), // textInputDecoration is set of lines of code defined as constant in constants.dart for ease

                          validator: (val) => val!.isEmpty
                              ? 'Enter an email'
                              : null, // return null if true and string if empty

                          onChanged: (val) {
                            setState(() => email = val);
                          },
                        ),
                        SizedBox(height: 20.0),
                        TextFormField(
                          decoration: textInputDecoration.copyWith(
                              hintText: 'Password'),
                          obscureText:
                              true, //obscure means hidden text as asterics
                          validator: (val) => val!.length < 6
                              ? 'Enter a 6+ char long Passwrod'
                              : null,
                          onChanged: (val) {
                            setState(() => password = val);
                          },
                        ),
                        SizedBox(height: 20.0),
                        RaisedButton(
                            color: Colors.pink[400],
                            child: Text(
                              'Register',
                              style: TextStyle(color: Colors.white),
                            ),
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                setState(() => loading = true);
                                dynamic result =
                                    await _auth.registerWithEmailAndPassword(
                                        email, password);
                                if (result == null) {
                                  setState(() {
                                    error = 'Please supply a valid mail';
                                    loading = false;
                                  });
                                }
                              }
                            }),
                        SizedBox(
                            height:
                                12.0), // for showing error in register screen when something wents wrong
                        Text(
                          error,
                          style: TextStyle(color: Colors.red, fontSize: 14.0),
                        )
                      ],
                    ))),
          );
  }
}
