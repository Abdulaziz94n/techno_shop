import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'my_home_page.dart';

class LoginPage extends StatefulWidget {
  final Function toggleView;

  LoginPage({Key key, this.toggleView});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _loginFormKey = GlobalKey<FormState>();
  TextEditingController emailInputController;
  TextEditingController pwdInputController;

  @override
  initState() {
    emailInputController = new TextEditingController();
    pwdInputController = new TextEditingController();
    super.initState();
  }

  String emailValidator(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value)) {
      return 'Email format is invalid';
    } else {
      return null;
    }
  }

  String pwdValidator(String value) {
    if (value.length < 5) {
      return 'Password must be longer than 8 characters';
    } else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Sign in"),
          actions: [
            FlatButton.icon(
                icon: Icon(Icons.person),
                label: Text('Sign up'),
                onPressed: () {
                  widget.toggleView();
                })
          ],
        ),
        body: Container(
            padding: const EdgeInsets.all(20.0),
            child: SingleChildScrollView(
                child: Form(
              key: _loginFormKey,
              child: Column(
                children: <Widget>[
                  TextFormField(
                    decoration: InputDecoration(
                        labelText: 'Email*', hintText: "john.doe@gmail.com"),
                    controller: emailInputController,
                    keyboardType: TextInputType.emailAddress,
                    validator: emailValidator,

                  ),
                  TextFormField(
                    decoration: InputDecoration(
                        labelText: 'Password*', hintText: "****"),
                    controller: pwdInputController,
                    obscureText: true,
                    validator: pwdValidator,
                  ),
                  SizedBox(height: 40,),
                  RaisedButton(
                      child: Text("Login"),
                      color: Theme.of(context).primaryColor,
                      textColor: Colors.grey.shade900,
                      onPressed: ()  {
                        if (_loginFormKey.currentState.validate()) {
                          FirebaseAuth.instance
                              .signInWithEmailAndPassword(
                                  email: emailInputController.text,
                                  password: pwdInputController.text)
                              .then(
                            (currentUser) {
                              if (currentUser != null) {
                                print('Login done');
                               Navigator.push(context, MaterialPageRoute(builder: (context)=> MyHomePage()));
                              }
                              // else {
                              //   Firestore.instance
                              //       .collection('users')
                              //       .document(currentUser.user.uid)
                              //       .get()
                              //       .then((fullinfo) {
                              //     print('login failed');
                              //   });
                              // }
                            },
                          );
                        }
                      })
                ],
              ),
            ))));
  }
}
