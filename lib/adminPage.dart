import 'package:provider/provider.dart';
import 'package:swe444/List_info_admin.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:swe444/Services/auth.dart';
import 'package:swe444/Services/database.dart';
import 'package:swe444/models/meals.dart';
import 'package:swe444/models/user.dart';
import 'package:swe444/NewRecipe.dart';
import 'package:cool_alert/cool_alert.dart';

class Admin_page extends StatefulWidget {
  final double weidth, height;
  final User user;

  Admin_page(this.weidth, this.height, this.user);

  @override
  State<StatefulWidget> createState() {
    return admin_page(weidth, height, 0, user);
  }
}

class admin_page extends State<Admin_page> {
  final double weidth, height;
  final User user;
  int _category;
  var cat = [
    "assets/Juice_page@3x.png",
    "assets/Apptizers_page@3x.png",
    "assets/Main Dishes_page@3x.png",
    "assets/Salads_page@3x.png",
    "assets/Soup_page@3x.png",
    "assets/Sweets_page@3x.png"
  ];
  var cat1 = ["Juice", "Appetizers", "Main Dishes", "Salads", "Soup", "Sweets"];

  admin_page(this.weidth, this.height, this._category, this.user);

  int mode = 0;

  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<Meal>>.value(
      value: DatabaseService().meals,
      child: Scaffold(
        backgroundColor: Color(0xffF5F5F5),
        appBar: AppBar(
          backgroundColor: Color(0xff262523),
          title: Text(
            cat1[_category],
            style: TextStyle(
              fontSize: 25,
            ),
          ),
        ),
        bottomNavigationBar: CurvedNavigationBar(
          backgroundColor: Color(0xff262523),
          height: 55,
          items: [
            Image.asset('assets/Juice_icon@3x.png'),
            Image.asset('assets/Appetizers_icon@3x.png'),
            Image.asset('assets/Main Dishes_icon@3x.png'),
            Image.asset('assets/Salads_icon@3x.png'),
            Image.asset('assets/Soup_icon@3x.png'),
            Image.asset('assets/Sweets_icon@3x.png'),
            Icon(Icons.logout),
          ],
          onTap: selepage,
        ),

        body: Container(
          child: new ListInfo_admin(weidth, height),
        ),
      ),
    );
  }

  void selepage(int index) {
    final AuthServices _auth = AuthServices();
    setState(
      () {
        if (index < 6) {
          setState(() {
            listInfo_admin.category = index;
            _category = index;
          });
        } else {
          CoolAlert.show(
              context: context,
              type: CoolAlertType.confirm,
              barrierDismissible: false,
              text: "Are you sure want to logout?",
              onConfirmBtnTap: () async {
                await _auth.SignOut();
                Navigator.of(context).pop();
              });
        }
      },
    );
  }
}
