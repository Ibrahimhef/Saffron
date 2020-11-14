import 'package:flutter/material.dart';
import 'package:swe444/singup.dart';
import 'package:swe444/login.dart';
import 'package:swe444/main.dart';

class Authentcate extends StatefulWidget {
  @override
  _AuthentcateState createState() => _AuthentcateState();
}

class _AuthentcateState extends State<Authentcate> {
  bool showSignIn = true;
  void toggleView() {
    setState(() => showSignIn = !showSignIn);
  }

  @override
  Widget build(BuildContext context) {
    return showSignIn
        ? LoginPage(
            toggleView: toggleView,
          )
        : SingupPage(toggleView: toggleView);
  }
}
