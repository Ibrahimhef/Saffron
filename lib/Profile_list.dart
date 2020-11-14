import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:swe444/Services/database.dart';
import 'package:swe444/profile_list_info.dart';
import 'package:swe444/models/meals.dart';
import 'package:provider/provider.dart';


class Profile_list extends StatefulWidget {
  final double weidth, height;
   List ListOfRecipeces;
  final String MyEmail ;
  Profile_list(this.weidth, this.height, this.ListOfRecipeces, this.MyEmail);
  @override
  State<StatefulWidget> createState() {
    return profile_list(weidth, height, 0, ListOfRecipeces,MyEmail);
  }
}

class profile_list extends State<Profile_list> {
  final double weidth, height;
  int _category;
   List ListOfRecipeces;
  final String MyEmail ;
  var cat = [
    "assets/Juice_page@3x.png",
    "assets/Apptizers_page@3x.png",
    "assets/Main Dishes_page@3x.png",
    "assets/Salads_page@3x.png",
    "assets/Soup_page@3x.png",
    "assets/Sweets_page@3x.png"
  ];
  var cat1 = ["Juice", "Appetizers", "Main Dishes", "Salads", "Soup", "Sweets"];

  profile_list(this.weidth, this.height, this._category, this.ListOfRecipeces, this.MyEmail);

  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<Meal>>.value(
      value:  DatabaseService().meals,
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
          ],
          onTap: (int index) {
            setState(() {
              _category = index;
              if(index != listInfo_pro.cat)
              listInfo_pro.cat = index;
            });
          },
        ),
        body: Container(
          child: new ListInfo_profile(weidth, height, ListOfRecipeces, MyEmail),
        ),
      ),
    );
  }
}
