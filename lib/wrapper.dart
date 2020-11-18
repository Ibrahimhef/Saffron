import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:swe444/Services/database.dart';
import 'package:swe444/adminPage.dart';
import 'package:swe444/homeTest.dart';
import 'package:swe444/login.dart';
import 'package:swe444/main.dart';
import 'package:swe444/models/profile.dart';
import 'package:swe444/models/user.dart';
import 'package:swe444/screens/authenicate/authenticate.dart';

class Wrapper extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return wrapper();
  }
}

class wrapper extends State<Wrapper> {
  bool flag = false;

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    if (user == null) {
      return Authentcate();
    } else {
      Stream<List<profile1>> users = DatabaseService(uid: user.uid).users;
      users.listen((event) {
        event.forEach((element) {
          if (element.uid == user.uid ) {
            if(element.admin)
            setState(() {
              flag = true;
            });
          }
          else
            setState(() {
              flag =false;
            });
        });
      });
      return flag ? admin(user) : catogory(user);
    }
  }
}
