import 'dart:convert';
import 'package:app/utilities/http_methods.dart';
import 'package:app/widgets/scaffoldWidgets/bot_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '/widgets/http_response_popups.dart';

class NewUserPage extends StatefulWidget {
  const NewUserPage({Key? key}) : super(key: key);

  //final String title;

  @override
  State<NewUserPage> createState() => _NewUserPageState();
}

class _NewUserPageState extends State<NewUserPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController password2Controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final nameField = TextField(
        controller: nameController,
        obscureText: false,
        decoration: InputDecoration(
            contentPadding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
            hintText: "Name",
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))));

    final emailField = TextField(
        controller: emailController,
        obscureText: false,
        decoration: InputDecoration(
            contentPadding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
            hintText: "Email",
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))));

    final passwordField = TextField(
        controller: passwordController,
        obscureText: true,
        decoration: InputDecoration(
            contentPadding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
            hintText: "Password",
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))));

    final password2Field = TextField(
        controller: password2Controller,
        obscureText: true,
        decoration: InputDecoration(
            contentPadding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
            hintText: "Confirm Password",
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))));

    final createUserButton = Material(
        elevation: 5.0,
        borderRadius: BorderRadius.circular(30.0),
        color: const Color(0xff01A0C7),
        child: MaterialButton(
            minWidth: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
            onPressed: () {
              createUser(nameController.text, emailController.text,
                      passwordController.text, password2Controller.text)
                  .then((response) {
                if (response.statusCode == 200) {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) => httpRequestPopup(
                        context, "Success", "User successfully created"),
                  ).then((response) => Navigator.pop(context));
                } else {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) => httpRequestPopup(context,
                        "Error", "There was a problem creating the user"),
                  ).then((response) => Navigator.pop(context));
                }
              });
              //print("we made an account");
              //Navigator.pop(context);
            },
            child: Text('Create Account', textAlign: TextAlign.center)));

    return Scaffold(
      body: Center(
        child: Container(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(36.0),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(height: 45.0),
                  nameField,
                  SizedBox(height: 25.0),
                  emailField,
                  SizedBox(height: 25.0),
                  passwordField,
                  SizedBox(height: 25.0),
                  password2Field,
                  SizedBox(height: 25.0),
                  createUserButton,
                ]),
          ),
        ),
      ),
    );
  }
}
