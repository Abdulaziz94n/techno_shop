import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_app_layout/screen/my_home_page.dart';
import 'package:flutter_app_layout/services/database.dart';
import 'package:flutter_app_layout/model/product.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class SignUp extends StatefulWidget {
  final Function toggleView;
  SignUp({Key key, this.toggleView });

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final GlobalKey<FormState> _signUpFormKey = GlobalKey<FormState>();
  TextEditingController emailController;
  TextEditingController passwordController;
  TextEditingController nameController;
  TextEditingController pwdConfirmedController;

  @override
  void initState() {
    emailController = new TextEditingController();
    passwordController = new TextEditingController();
    nameController = new TextEditingController();
    pwdConfirmedController = new TextEditingController();

    super.initState();
  }

  String _emailValidator(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value)) {
      return 'Email format is invalid';
    } else {
      return null;
    }
  }

  String _pwdValidator(String value) {
    if (value.length < 5) {
      return 'Password must be longer than 5 characters';
    } else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {


    return Scaffold(
        appBar: AppBar(
          title: Text('Sign Up'),
          actions: [
            FlatButton.icon(icon: Icon(Icons.person),label: Text('Sign in'), onPressed: () {
              widget.toggleView();
            })
          ],
        ),
        body: Container(
            padding: const EdgeInsets.all(20.0),
            child: SingleChildScrollView(
                child: Form(
                  key: _signUpFormKey,
                  child: Column(
                  children: <Widget>[
                    TextFormField(
                    // onChanged: (val) {
                    //   setState(() {
                    //     emailController.text = val;
                    //   });
                    // },
                    decoration:
                        InputDecoration(labelText: 'Name*', hintText: "john"),
                    controller: nameController,
                    //  keyboardType: TextInputType.emailAddress,
                    //   validator: _emailValidator,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                        labelText: 'Email*', hintText: "john.doe@gmail.com"),
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                   // validator: _emailValidator,
                    validator: (val) => val.isEmpty ? 'Enter an Email' : null,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                        labelText: 'Password*', hintText: "****"),
                    controller: passwordController,
                    obscureText: true,
                    //validator: _pwdValidator,
                    validator: (val) => val.length < 6 ? 'Enter a 6 + length password' : null,
                  ),
                  SizedBox(height: 40,),
                  RaisedButton(
                      child: Text("SignUp"),
                      color: Theme.of(context).primaryColor,
                      textColor: Colors.grey.shade900,
                      onPressed: () async {
                        if (_signUpFormKey.currentState.validate()) {
                          FirebaseAuth.instance
                              .createUserWithEmailAndPassword(
                                  email: emailController.text,
                                  password: passwordController.text)
                              .then(
                            (createdUser) {
                              if (createdUser != null) {
                                Firestore.instance
                                    .collection('users')
                                    .document(createdUser.user.uid)
                                    .setData({
                                  'name': nameController.text,
                                  'email': createdUser.user.email,
                                  'id': createdUser.user.uid,
                                });
                                print('SignUp done');
                                Navigator.push(context, MaterialPageRoute(builder: (context)=> MyHomePage()));
                              }
                              // else {
                              //   Firestore.instance
                              //       .collection('users')
                              //       .document(createdUser.user.uid)
                              //       .get()
                              //       .then((fullinfo) {
                              //     print('full info');
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
