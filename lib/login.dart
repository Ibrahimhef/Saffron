import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:swe444/Services/auth.dart';
import 'package:swe444/main.dart';
import 'TextStyle.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'shared/loading.dart';
// import 'package:firebase/firebase.dart';

class Login extends StatefulWidget {
  final Function toggleView;
  final double weidth, height;

  Login(this.weidth, this.height, {this.toggleView});

  @override
  State<StatefulWidget> createState() {
    return Loginstate(weidth, height);
  }
}

class Loginstate extends State<Login> {
  final Function toggleView;
  final double weidth, height;

  Loginstate(this.weidth, this.height, {this.toggleView});

  final AuthServices _authServices = AuthServices();
  static String email = '';
  static String password = '';
  String error = '';
  static Text errorMessage = new Text("");
  static final _formKey = GlobalKey<FormState>();
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : SingleChildScrollView(
            child: Container(
                height: height,
                width: weidth,
                child: Stack(
                  children: [
                    //login header
                    Positioned(
                      right: 0,
                      top: -7,
                      child: Image(
                          width: weidth + 25,
                          height: height / 2.5,
                          image: AssetImage('assets/headOfLoginPage@3x.png'),
                          fit: BoxFit.fill),
                    ),
                    // Login area
                    Positioned(
                      top: height * 0.687,
                      left: weidth * 0.10,
                      right: weidth * 0.10,
                      child: Center(
                        child: Container(
                          child: Column(
                            children: [
                              Container(
                                margin: EdgeInsets.only(bottom: 10),
                                child: InkWell(
                                  highlightColor: Colors.transparent,
                                  splashColor: Colors.transparent,
                                  onTap: () async {
                                    try {
                                      if (_formKey.currentState.validate()) {
                                        setState(() {
                                          loading = true;
                                        });

                                        dynamic result = await _authServices
                                            .SingInWithEmailAndPassword(
                                                email, password);

                                        // print(result.toString());
                                        // if (result == null) {

                                        //   setState(() {
                                        //     loading = false;
                                        //     error = "email is invalid";
                                        //     errorMessage = Text(error,
                                        //         style:
                                        //             textStyle().style5(weidth));
                                        //   });
                                        // } else {}
                                      }
                                    } catch (e) {
                                      // if (e is PlatformException) {
                                      if (e.code == "ERROR_WRONG_PASSWORD" ||
                                          e.code == "ERROR_USER_NOT_FOUND") {
                                        // print("this email already exist");
                                        setState(() {
                                          loading = false;
                                          error =
                                              'Email or Password is Incorrect';
                                          errorMessage = Text(error,
                                              style:
                                                  textStyle().style5(weidth));
                                        });
                                      }
                                      if (e.code == "ERROR_INVALID_EMAIL") {
                                        // print("here");
                                        setState(() {
                                          loading = false;
                                          error = 'Invalid Email';
                                          errorMessage = Text(error,
                                              style:
                                                  textStyle().style5(weidth));
                                        });
                                      }
                                      // } else {
                                      // setState(() {
                                      //   loading = false;
                                      // });

                                      print(e.toString());
                                      // }
                                    }
                                  },
                                  child: Image(
                                    width: weidth * 0.35,
                                    height: height * 0.05,
                                    image: AssetImage('assets/singin.png'),
                                  ),
                                ),
                              ),
                              InkWell(
                                highlightColor: Colors.transparent,
                                splashColor: Colors.transparent,
                                onTap: () async {
                                  _authServices.signinwithgoogleaccount();
                                },
                                child: Image(
                                  width: weidth * 0.4,
                                  height: height * 0.05,
                                  image:
                                      AssetImage('assets/googleSignIn@3x.png'),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),

                    //Username and password area
                    Form(
                        key: _formKey,
                        child: Positioned(
                          top: height * 0.54,
                          left: weidth * 0.15,
                          right: weidth * 0.15,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                margin: EdgeInsets.only(bottom: 20),
                                width: weidth * 0.75,
                                height: height / 20,
                                child: TextFormField(
                                  onChanged: (value) {
                                    email = value;
                                    email = email.trim();
                                  },
                                  validator: (value) =>
                                      value.isEmpty ? "Enter an email" : null,
                                  textInputAction: TextInputAction.next,
                                  onFieldSubmitted: (_) =>
                                      FocusScope.of(context).focusedChild,
                                  decoration: InputDecoration(
                                      icon: Icon(
                                        Icons.perm_identity,
                                        color: Colors.black54,
                                      ),
                                      border: UnderlineInputBorder(
                                          borderSide: new BorderSide(
                                              color: Colors.black54,
                                              width: 0.5,
                                              style: BorderStyle.none)),
                                      hintText: "email"),
                                ),
                              ),
                              Container(
                                width: weidth * 0.75,
                                height: height / 20,
                                child: TextFormField(
                                  textInputAction: TextInputAction.done,
                                  onChanged: (value) => password = value,
                                  validator: (value) =>
                                      value.isEmpty ? "Enter a password" : null,
                                  obscureText: true,
                                  decoration: InputDecoration(
                                      icon: Icon(
                                        Icons.lock,
                                        color: Colors.black54,
                                      ),
                                      // border: InputBorder.none,
                                      hintText: "password"),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.all(7),
                                child: errorMessage,
                              )
                            ],
                          ),
                        )),
                    Positioned(
                      top: height * 0.9,
                      child: Container(
                        width: weidth,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            InkWell(
                              highlightColor: Colors.transparent,
                              splashColor: Colors.transparent,
                              onTap: () {
                                // Navigator.push(
                                //     context,
                                //     new MaterialPageRoute(
                                //         builder: (context) => new SingupPage()));
                                widget.toggleView();
                              },
                              child: Text("Sign-up",
                                  style: textStyle().style1(weidth)),
                            ),
                            InkWell(
                              highlightColor: Colors.transparent,
                              splashColor: Colors.transparent,
                              onTap: () {
                                Navigator.push(
                                    context,
                                    new MaterialPageRoute(
                                        builder: (context) =>
                                            new ForgetPage()));
                              },
                              child: Text(" Forget password?",
                                  style: textStyle().style1(weidth)),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                )),
          );
  }
}
