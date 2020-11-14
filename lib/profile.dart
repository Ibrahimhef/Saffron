import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:swe444/Profile_list.dart';
import 'package:swe444/Services/auth.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:swe444/shared/loading.dart';
import 'Profile_list.dart';
import 'package:auto_size_text/auto_size_text.dart';


class Profile extends StatefulWidget {
  final double weidth, height;
  final List ListOfRecipeces;
  final String name;
  final String email;
  Profile(
      this.weidth, this.height, this.ListOfRecipeces, this.email, this.name);

  @override
  State<StatefulWidget> createState() {
    return profile(weidth, height, ListOfRecipeces, this.email, this.name);
  }
}

class profile extends State<Profile> {
  final double weidth, height;
  final List ListOfRecipeces;
  final String name;
  final String email;
  profile(
      this.weidth, this.height, this.ListOfRecipeces, this.email, this.name);
  List ListOwnRec = [];
  final AuthServices _auth = AuthServices();
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    // collectInfo();
    return loading
        ? Loading()
        : Scaffold(
            backgroundColor: Color(0xfff2f2f2),
            appBar: AppBar(
              backgroundColor: Color(0xffd93d1a),
              title: Text(
                'Profile',
                style: TextStyle(
                  fontSize: 25,
                  fontFamily: 'OleoScript',
                ),
              ),
            ),
            body: Stack(
              children: [
                Center(
                  child: Container(
                    height: height * 0.5,
                    width: weidth * 0.8,
                    padding: EdgeInsets.all(30),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(25),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 5,
                          blurRadius: 7,
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.account_circle,
                          size: 80,
                        ),
                        AutoSizeText(
                          name,
                          style: TextStyle(
                            fontSize: 40,
                            fontFamily: 'OleoScript',
                          ),
                          maxLines: 2,
                          minFontSize: 30,
                        ),
                        Text(
                          'We will miss you',
                          style: TextStyle(
                            fontSize: 25,
                            fontFamily: 'OleoScript',
                            color: Colors.grey[600],
                          ),
                        ),
                        //--------
                        SizedBox(
                          height: 20,
                        ),
                        //--------
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            RaisedButton(
                              elevation: 5,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  side: BorderSide(color: Colors.red)),
                              color: Color(0xffDD7804),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: AutoSizeText(
                                  'Log out',
                                  style: TextStyle(
                                      fontFamily: 'OleoScript', fontSize: 20),
                                ),
                              ),
                              onPressed: () async {
                                setState(() {
                                  loading = true;
                                });
                                await _auth.SignOut();
                                Navigator.of(context).pop();
                              },
                            ),
                            RaisedButton(
                              elevation: 5,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  side: BorderSide(color: Colors.red)),
                              color: Color(0xffDD7804),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: AutoSizeText(
                                  'Your Recipes',
                                  style: TextStyle(
                                      fontFamily: 'OleoScript', fontSize: 20),
                                ),
                              ),
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    new MaterialPageRoute(
                                        builder: (context) =>
                                        new Profile_list(weidth, height, ListOfRecipeces,email)));
                              },
                            ),
                          ],
                        ),

                      ],
                    ),
                  ),
                ),

              ],
            ),
          );
  }
}
