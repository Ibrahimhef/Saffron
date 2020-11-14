import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:swe444/Services/auth.dart';
import 'package:swe444/main.dart';
import 'package:swe444/screens/authenicate/authenticate.dart';
import 'TextStyle.dart';

class ForgetPass extends StatelessWidget {
  final double weidth, height;
  final AuthServices _authServices = AuthServices();
  ForgetPass(this.weidth, this.height);
  static String email = '';
  static final _formKey2 = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Container(
        height: height,
        width: weidth,
        child: Stack(
          children: [
            //header of ForgetPass
            Positioned(
              right: 0,
              top: -7,
              child: Image(
                  width: weidth,
                  height: height / 3.5,
                  image: AssetImage('assets/forgethead@3x.png'),
                  fit: BoxFit.fill),
            ),
            // Arrow for submit
            Positioned(
              top: height * 0.683,
              left: weidth * 0.10,
              right: weidth * 0.10,
              child: Center(
                child: InkWell(
                  highlightColor: Colors.transparent,
                  splashColor: Colors.transparent,
                  onTap: () async {
                    if (_formKey2.currentState.validate()) {
                      await _authServices.ForgetPassword(email);
                      Navigator.pop(
                          context,
                          new MaterialPageRoute(
                              builder: (context) => new LoginPage()));
                    }
                  },
                  child: Image(
                    width: weidth * 0.48,
                    height: height * 0.06,
                    image: AssetImage('assets/sendpass.png'),
                  ),
                ),
              ),
            ),
            // text right to Arrow for submit

            //Email submit area
            Form(
              key: _formKey2,
              child: Positioned(
                top: height * 0.55,
                left: weidth * 0.15,
                right: weidth * 0.15,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: weidth * 0.75,
                      height: height / 20,
                      child: TextFormField(
                        onChanged: (value) => email = value,
                        validator: (value) =>
                            value.isEmpty ? "Enter an email" : null,
                        decoration: InputDecoration(
                            icon: Icon(
                              Icons.mail_outline,
                              color: Colors.black54,
                            ),
                            border: UnderlineInputBorder(
                                borderSide: new BorderSide(
                                    color: Colors.black54,
                                    width: 0.5,
                                    style: BorderStyle.none)),
                            hintText: "Email"),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ));
  }
}
