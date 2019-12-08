import 'package:dating_app/pages/home_page.dart';
import 'package:dating_app/pages/login_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Widget startPage = LoginPage();
    return FutureBuilder<FirebaseUser>(
        future: FirebaseAuth.instance.currentUser(),
        builder: (BuildContext context, AsyncSnapshot<FirebaseUser> snapshot) {
          if (snapshot.hasData) {
            startPage =  HomePage(snapshot.data);
          }
          return MaterialApp(
            title: 'Destiny',
            debugShowCheckedModeBanner: false,
            theme: ThemeData.dark(),
            home: startPage,);
        });
  }
}
