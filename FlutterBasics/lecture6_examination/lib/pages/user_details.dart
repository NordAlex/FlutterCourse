import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lecture6_examination/models/User.dart';

class UserDetailsPage extends StatelessWidget
{
  const UserDetailsPage(this._user);

  final User _user;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(),
      body: Row(
        children: <Widget>[
          Image.network(_user.picture.large)
        ],
      )
    
    ,);
  }
  
}