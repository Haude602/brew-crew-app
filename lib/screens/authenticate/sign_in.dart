import 'package:brew_crew/services/auth.dart';
import 'package:brew_crew/shared/loading.dart';
import 'package:flutter/material.dart';
import "package:brew_crew/shared/constants.dart";

class SignIn extends StatefulWidget {
  final Function toggleView;
  SignIn({required this.toggleView});

  //const SignIn({Key? key}) : super(key: key);

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _auth = AuthService(); // to create instance of auth service
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  //text field state
  String email = '';
  String password = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            // return loading widget if loading is true otherwise scaffold
            backgroundColor: Colors.brown[100],
            appBar: AppBar(
                backgroundColor: Colors.brown[400],
                elevation: 0.0,
                title: Text('Sign in to Brew Crew'),
                actions: <Widget>[
                  FlatButton.icon(
                    onPressed: () {
                      widget.toggleView();
                    }, //this will help to go to another page when clicked
                    icon: Icon(Icons.person),
                    label: Text('Register'),
                  )
                ]),
            body: Container(
                padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50),
                child: Form(
                    key: _formKey,
                    child: Column(
                      children: <Widget>[
                        SizedBox(height: 20.0),
                        TextFormField(
                          decoration: textInputDecoration.copyWith(
                              // .copywith() is used to include hintText of inside decoration as it cant be constant in constants.dart
                              hintText: 'Email'),
                          validator: (val) =>
                              val!.isEmpty ? 'Enter an email' : null,
                          onChanged: (val) {
                            setState(() => email = val);
                          },
                        ),
                        SizedBox(height: 20.0),
                        TextFormField(
                          decoration: textInputDecoration.copyWith(
                              // .copywith() is used to include hintText of inside decoration as it cant be constant in constants.dart
                              hintText: 'Password'),
                          obscureText: true,
                          validator: (val) => val!.length < 6
                              ? 'Enter a 6+ char long Passwrod'
                              : null, //obscure means hidden text as asterics
                          onChanged: (val) {
                            setState(() => password = val);
                          },
                        ),
                        SizedBox(height: 20.0),
                        RaisedButton(
                            color: Colors.pink[400],
                            child: Text(
                              'Sign in',
                              style: TextStyle(color: Colors.white),
                            ),
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                setState(() => loading =
                                    true); // lpading screen only when valid
                                dynamic result =
                                    await _auth.signInWithEmailAndPassword(
                                        email, password);
                                if (result == null) {
                                  setState(() {
                                    error =
                                        'couldnot sign in with those credentials';
                                    loading =
                                        false; // no loading screen if there is error
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
