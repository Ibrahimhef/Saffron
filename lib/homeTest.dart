import 'package:flutter/material.dart';
import 'package:swe444/Services/auth.dart';
import 'package:swe444/screens/home/user_list.dart';
import 'package:swe444/test.dart';
import 'models/profile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'Services/database.dart';
import 'package:provider/provider.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final AuthServices _auth = AuthServices();
    return StreamProvider<List<profile1>>.value(
        value: DatabaseService().users,
        child: Scaffold(
          body: UserList(),
        ));
  }
}
