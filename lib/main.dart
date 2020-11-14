import 'dart:io';
import 'package:change_app_package_name/change_app_package_name.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:swe444/Services/auth.dart';
import 'package:swe444/models/user.dart';
import 'package:swe444/wrapper.dart';
import 'login.dart';
import 'singup.dart';
import 'forgetPassword.dart';
import 'SubCategories.dart';
import 'TextStyle.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:firebase_storage/firebase_storage.dart';

void main() {
  // runApp(DevicePreview(builder:(context) => MyHomePage()));
  runApp(MyHomePage());
}

class MyHomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MyApp();
  }
}

class MyApp extends State<MyHomePage> {
  File _image;
  String _uploadedFileURL;
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value(
      value: AuthServices().user,
      child: MaterialApp(
        // builder: DevicePreview.appBuilder,
        debugShowCheckedModeBanner: false,
        home: AnimatedSplashScreen(
          backgroundColor: Color.fromRGBO(242, 201, 54, 1),
          duration: 1500,
          splashIconSize: 380,
          splash: Image(
            image: AssetImage('assets/Saffron-logo.png'),
          ),
          nextScreen: Wrapper(),
        ),
      ),
    );
  }
}

class LoginPage extends StatelessWidget {
  final Function toggleView;

  LoginPage({this.toggleView});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final weidth = MediaQuery.of(context).size.width;
    return Scaffold(
        resizeToAvoidBottomPadding: true,
        backgroundColor: Colors.white,
        body: Login(
          weidth,
          height,
          toggleView: toggleView,
        ));
  }
}

class SingupPage extends StatelessWidget {
  final Function toggleView;

  SingupPage({this.toggleView});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final weidth = MediaQuery.of(context).size.width;
    return Scaffold(
      resizeToAvoidBottomPadding: true,
      backgroundColor: Colors.white,
      body: Container(
        child: Singup(
          weidth,
          height,
          toggleView: toggleView,
        ),
      ),
    );
  }
}

class ForgetPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final weidth = MediaQuery.of(context).size.width;
    return Scaffold(
        backgroundColor: Colors.white, body: ForgetPass(weidth, height));
  }
}

class catogory extends StatelessWidget {
  final User user;

  const catogory(this.user);
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final weidth = MediaQuery.of(context).size.width;
    return Catogory(weidth, height, user);
  }
}
