import 'dart:convert';

import 'package:dating_app/models/user.dart';
import 'package:dating_app/pages/details_page.dart';
import 'package:dating_app/pages/user_buttons.dart';
import 'package:dating_app/pages/user_card.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> with TickerProviderStateMixin {
  Future<User> _user;

  final _offcetStart = -300.0;
  final _offcetFinish = 0.0;

  final _fadingStart = 1.0;
  final _fadingFinish = 0.0;

  final _offcetDuration = 200;
  final _fadingDuration = 300;

  AnimationController _offcetController;
  AnimationController _fadingController;

  Animation<double> _offcetAnimation;
  Animation<double> _fadingAnimation;

  @override
  void initState() {
    super.initState();
    _user = _generateUser();

    _offcetController = AnimationController(
        vsync: this, duration: Duration(milliseconds: _offcetDuration));
    _offcetAnimation = Tween(begin: _offcetStart, end: _offcetFinish)
        .animate(_offcetController)
          ..addListener(() {
            setState(() {});
          });

    _fadingController = AnimationController(
        vsync: this, duration: Duration(milliseconds: _fadingDuration));
    _fadingAnimation = Tween(begin: _fadingStart, end: _fadingFinish)
        .animate(_fadingController)
          ..addListener((() {
            setState(() {});
          }));

    _offcetController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Almost Tinder'),
      ),
      body: Center(
        child: FutureBuilder<User>(
            future: _user,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      FadeTransition(
                          opacity: _fadingAnimation,
                          child: Transform.translate(
                              offset: Offset(_offcetAnimation.value, 0),
                              child: UserCard(snapshot.data))),
                      UserButtons(
                          onReload: () => _reloadUser(),
                          onNext: () =>
                              _navigateDetails(context, snapshot.data)),
                    ],
                  ),
                );
              } else if (snapshot.hasError) {
                return const Text(
                    'Something is wrong. Check your internet connection. :-(');
              } else {
                return const CircularProgressIndicator();
              }
            }),
      ),
    );
  }

  Future<User> _generateUser() async {
    final uri = Uri.https('randomuser.me', '/api/1.3');
    final response = await http.get(uri);
    return _parseUser(response.body).whenComplete(() {
      _offcetController.reset();
      _fadingController.reset();
      _offcetController.forward();
    });
  }

  Future<User> _parseUser(String response) async {
    final Map<String, dynamic> parsed = json.decode(response);
    return User.fromRandomUserResponse(parsed);
  }

  void _reloadUser() {
    setState(() {
      _fadingController.reset();
      _fadingController.forward();
      _user = _generateUser();
    });
  }

  void _navigateDetails(BuildContext context, User selectedUser) {
    Navigator.of(context).push<void>(
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => DetailsPage(
          user: selectedUser,
        ),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(1.0, 0.0);
          const end = Offset.zero;
          const curve = Curves.ease;

          final tween =
              Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

          return SlideTransition(
            position: animation.drive(tween),
            child: child,
          );
        },
      ),
    );
  }
}
