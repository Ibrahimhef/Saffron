import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:swe444/homeTest.dart';
import 'package:swe444/login.dart';
import 'package:swe444/main.dart';
import 'package:swe444/models/user.dart';
import 'package:swe444/screens/authenicate/authenticate.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    // print(user);
//check if signin later next screen category otherwise next screen login page
    if (user == null) {
      return Authentcate();
    } else {
      return catogory(user);
    }
  }
}
