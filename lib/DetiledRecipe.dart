import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:provider/provider.dart';
import 'package:swe444/Services/database.dart';
import 'package:swe444/models/meals.dart';
import 'package:swe444/models/profile.dart';
import 'package:swe444/models/user.dart';
import 'package:cool_alert/cool_alert.dart';

class DetildPage extends StatefulWidget {
  final double weidth, height;
  final Meal meal;

  DetildPage(this.weidth, this.height, this.meal);

  @override
  State<StatefulWidget> createState() {
    return detildPage(weidth, height, meal);
  }
}

class detildPage extends State<DetildPage> {
  final double weidth, height;
  final Meal meal;
  String TextIngOrSteps;
  String TextSteps;
  String TextIng;

  detildPage(this.weidth, this.height, this.meal);

  void initState() {
    TextIngOrSteps = "${meal.step}";
  }

  String MyEmail = "";
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    Stream<List<profile1>> users = DatabaseService(uid: user.uid).users;
    users.listen((event) {
      event.forEach((element) {
        if (element.uid == user.uid) {
          setState(() {
            MyEmail = element.email;
            // print(MyEmail + "=={");
          });
        }
      });
    });
    TextIng = "${meal.ingredients}";
    TextSteps = "${meal.step}";
    print(MyEmail + "<email>");
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xfff2780c),
        title: Text(
          '${meal.title}',
          style: TextStyle(
            fontSize: 25,
          ),
        ),
        //delete button in app bar
        actions: meal.email == MyEmail
            ? [
                Padding(
                  padding: EdgeInsets.only(right: 20.0),
                  child: GestureDetector(
                    onTap: () {
                      CoolAlert.show(
                          context: context,
                          type: CoolAlertType.confirm,
                          text:
                              "This recipe will be deleted immediately. You can not undo this action",
                          title:
                              "Are you sure you want to delete '${meal.title}'",
                          confirmBtnText: "Delete",
                          cancelBtnText: "Cancel",
                          confirmBtnColor: Color(0xfff2780c),
                          onConfirmBtnTap: () {
                            DatabaseService().removeMeal(meal.id);
                            Navigator.of(context).pop();
                            Navigator.of(context).pop();
                          });
                      // DatabaseService().removeMeal(meal.id);
                      // Navigator.of(context).pop();
                    },
                    child: Icon(Icons.delete),
                  ),
                ),
              ]
            : null,
      ),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Column(
              children: [
                //Picture
                Container(
                  width: weidth,
                  height: height / 2.5,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(24),
                        bottomRight: Radius.circular(24)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.4),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: Offset(0, 2), // changes position of shadow
                      ),
                    ],
                    image: DecorationImage(
                      image: NetworkImage(meal.imageURL.toString()),
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                ),
                SizedBox(
                  height: height * 0.065,
                ),
                //Description divider
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Divider(
                        thickness: 1,
                      ),
                    ),
                    Text(
                      '     Description     ',
                      style: TextStyle(color: Colors.black, fontSize: 25),
                    ),
                    Expanded(
                      child: Divider(
                        thickness: 1,
                      ),
                    ),
                  ],
                ),
                //Recipe description
                Container(
                  alignment: Alignment.topLeft,
                  padding:
                      EdgeInsets.only(right: 25, left: 25, bottom: 15, top: 15),
                  child: AutoSizeText(
                    "${meal.description}",
                    style: TextStyle(
                      fontSize: 18,
                    ),
                    maxLines: 4,
                    minFontSize: 15,
                  ),
                ),
                //Ingredients divider
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Divider(
                        thickness: 1,
                      ),
                    ),
                    Text(
                      '     Ingredients     ',
                      style: TextStyle(color: Colors.grey, fontSize: 25),
                    ),
                    Expanded(
                      child: Divider(
                        thickness: 1,
                      ),
                    ),
                  ],
                ),
                //Recipe Ingerdients
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  alignment: Alignment.topLeft,
                  child: AutoSizeText(
                    "${meal.ingredients}",
                    style: TextStyle(
                      fontSize: 20,
                    ),
                    maxLines: 20,
                    minFontSize: 15,
                  ),
                ),
                //Steps divider
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Divider(
                        thickness: 1,
                      ),
                    ),
                    Text(
                      '     Steps     ',
                      style: TextStyle(color: Colors.grey, fontSize: 25),
                    ),
                    Expanded(
                      child: Divider(
                        thickness: 1,
                      ),
                    ),
                  ],
                ),
                //Recipe steps
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  alignment: Alignment.topLeft,
                  child: AutoSizeText(
                    "${meal.step}",
                    style: TextStyle(
                      fontSize: 20,
                    ),
                    maxLines: 20,
                    minFontSize: 15,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
              ],
            ),
            //Recipe name and Est. time
            Positioned(
              top: height / 2.775,
              right: 15,
              left: 15,
              child: Column(
                children: [
                  Container(
                    width: weidth * 0.5,
                    height: height * 0.04,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(12),
                          topRight: Radius.circular(12)),
                      color: Color.fromRGBO(242, 171, 39, 1),
                    ),
                    child: AutoSizeText(
                      "${meal.title}",
                      style: TextStyle(
                        fontSize: 25,
                        color: Colors.white,
                      ),
                      maxLines: 1,
                    ),
                  ),
                  Container(
                    width: weidth * 0.5,
                    height: height * 0.04,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(12),
                          bottomRight: Radius.circular(12)),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: Offset(0, 3), // changes position of shadow
                        )
                      ],
                    ),
                    child: Text(
                      "Estimated time: " + meal.duration.toString() + " min.",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  double sizeW(double weidth, double ratio) {
    if (weidth <= 375) {
      return 354 * ratio;
    } else if (weidth > 375 && weidth <= 480) {
      return 436 * ratio;
    } else if (weidth > 480 && weidth < 800) {
      return 784 * ratio;
    } else
      return 900 * ratio;
  }

  double sizeh(double height) {
    if (height <= 569) {
      return 582 * 0.18;
    } else if (height > 569 && height <= 812) {
      return 740 * 0.18;
    } else if (height > 812 && height < 896) {
      return 882 * 0.19;
    } else if (height > 896 && height <= 1024) {
      return 992 * 0.19;
    } else
      return 1100 * 0.19;
  }
}
