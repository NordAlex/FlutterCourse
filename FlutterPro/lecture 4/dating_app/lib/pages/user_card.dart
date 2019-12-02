import 'package:dating_app/models/user.dart';
import 'package:flutter/material.dart';

class UserCard extends StatefulWidget {
  const UserCard(this.user);

  final User user;
  @override
  _UserCardState createState() => _UserCardState();
}

class _UserCardState extends State<UserCard>{

  @override
  Widget build(BuildContext context) {
       return Column(
        children: <Widget>[
          Image.network(
            widget.user.image,
            fit: BoxFit.fill,
            height: 300,
            width: 300,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 24.0),
            child: Text(
              widget.user.name,
              style: Theme.of(context).textTheme.display1,
            ),
          ),
        ],

    );
  }
}
