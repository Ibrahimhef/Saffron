import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:swe444/models/profile.dart';

class UserList extends StatefulWidget {
  @override
  _UserListState createState() => _UserListState();
}

class _UserListState extends State<UserList> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<List<profile1>>(context);
    return ListView.builder(
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.all(126.0),
          child: Column(
            children: [
              Text(user[index].email),
              Text(user[index].name),
              Text(user[index].password)
            ],
          ),
        );
      },
      itemCount: user.length,
    );
  }
}
