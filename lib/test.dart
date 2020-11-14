import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class userList extends StatefulWidget {
  @override
  _userListState createState() => _userListState();
}

class _userListState extends State<userList> {
  @override
  Widget build(BuildContext context) {
    final datainf = Provider.of<QuerySnapshot>(context);
    for (var doc in datainf.documents) {
      // print(doc.data);
    }
    return Container();
  }
}
