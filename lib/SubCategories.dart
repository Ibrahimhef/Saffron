import 'package:provider/provider.dart';
import 'package:swe444/List_info.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:swe444/Services/database.dart';
import 'package:swe444/models/meals.dart';
import 'package:swe444/models/profile.dart';
import 'package:swe444/models/user.dart';
import 'package:swe444/profile.dart';
import 'package:swe444/NewRecipe.dart';

class Catogory extends StatefulWidget {
  final double weidth, height;
  final User user;

  Catogory(this.weidth, this.height, this.user);

  @override
  State<StatefulWidget> createState() {
    return catogory(weidth, height, 0, user);
  }
}

class catogory extends State<Catogory> {
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

  catogory(this.weidth, this.height, this._category, this.user);

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
          height: 50,
          items: [
            Image.asset('assets/Juice_icon@3x.png'),
            Image.asset('assets/Appetizers_icon@3x.png'),
            Image.asset('assets/Main Dishes_icon@3x.png'),
            Image.asset('assets/Salads_icon@3x.png'),
            Image.asset('assets/Soup_icon@3x.png'),
            Image.asset('assets/Sweets_icon@3x.png'),
            Icon(Icons.person)
          ],
          onTap: selepage,
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
                context,
                new MaterialPageRoute(
                    builder: (context) => new AddPage(weidth, height, user)));
          },
          backgroundColor: Color(0xff262523),
          child: Icon(Icons.add),
        ),
        body: Container(
          child: new ListInfo(weidth, height),
        ),
      ),
    );
  }

  void selepage(int index) {
    // print("email:${user.email}");
    setState(
      () {
        if (index < 6) {
          setState(() {
            listInfo.category = index;
            _category = index;
          });
        } else {
          List ListOwnRec = [];
          String MyEmail = '';
          String MyName = '';
          final user = Provider.of<User>(context);
          Stream<List<profile1>> users = DatabaseService(uid: user.uid).users;
          users.listen((event) {
            event.forEach((element) {
              if (element.uid == user.uid) {
                setState(() {
                  MyEmail = element.email;
                  MyName = element.name;
                });
              }
            });
          });
          ListOwnRec.clear();
          Stream<List<Meal>> meals = DatabaseService(uid: user.uid).meals;
          meals.listen((event) {
            event.forEach((element) {
              if (MyEmail == element.email) {
                ListOwnRec.add(element);
              }
            });
          });
          Navigator.push(context, new MaterialPageRoute(builder: (_) {
            return Profile(weidth, height, ListOwnRec, MyEmail, MyName);
          }));
        }
      },
    );
  }
}

class recipe {
  final String name, decraption, path, time;
  final int caterogry;

  recipe({this.name, this.decraption, this.path, this.time, this.caterogry});

  String getName() {
    return this.name;
  }
}
