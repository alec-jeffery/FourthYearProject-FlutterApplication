import 'package:app/widgets/http_response_popups.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../../utilities/http_methods.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<LoginPage> createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
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

    final loginButon = Material(
        elevation: 5.0,
        borderRadius: BorderRadius.circular(30.0),
        color: const Color(0xff01A0C7),
        child: MaterialButton(
            minWidth: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
            onPressed: () {
              try {
                loginUser(emailController.text, passwordController.text)
                    .then((response) {
                  if (response.statusCode == 200) {
                    Navigator.pushNamed(context, '/home-page');
                  } else {
                    httpRequestPopup(
                        context, "Error", "User could not be authenticated");
                  }
                });
              } on Exception {
                httpRequestPopup(context, "Error", "Something went wrong");
              }
            },
            child: const Text('Login', textAlign: TextAlign.center)));

    final newUserButton = TextButton(
      child: const Text("Create an account"),
      onPressed: () => Navigator.pushNamed(context, '/new-user-page'),
    );

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
                  // SizedBox is a Flutter "padding" widget.
                  // Gives space bewteen widgets for a cleaner view
                  const SizedBox(height: 45.0),
                  emailField,
                  const SizedBox(height: 25.0),
                  passwordField,
                  const SizedBox(height: 25.0),
                  loginButon,
                  const SizedBox(height: 10.0),
                  newUserButton,
                ]),
          ),
        ),
      ),
    );
  }
}
