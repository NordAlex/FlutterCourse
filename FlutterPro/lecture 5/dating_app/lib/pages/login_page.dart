import 'package:dating_app/pages/home_page.dart';
import 'package:dating_app/utils/curent_user_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  LoginPage({Key key}) : super(key: key);

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  final _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Please authorize'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(left: 15, right: 15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextField(
                controller: _emailController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Email',
                ),
              ),
              Container(
                height: 5,
              ),
              TextField(
                controller: _passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Password',
                ),
              ),
              Container(
                height: 15,
              ),
              RaisedButton(
                onPressed: () => _login(context),
                child: const Text('Login'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _login(BuildContext context) async {
    final email = _emailController.text;
    final password = _passwordController.text;
    if (email != null && password != null) {
      try {
        final authResult = await _auth.signInWithEmailAndPassword(
            email: email, password: password);
        _navigateToMain(context, authResult.user);
      } catch (e) {
        switch (e.code) {
          case 'ERROR_USER_NOT_FOUND':
            await _signInNewUser(context);
            break;
          default:
            await _showErrorMessage(context, e.message);
            break;
        }
      }
    }
  }

  Future<void> _signInNewUser(BuildContext context) async {
    final email = _emailController.text;
    final password = _passwordController.text;
    try {
      final authResult = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      _navigateToMain(context, authResult.user);
    } catch (e) {
        await _showErrorMessage(context, e.message);
      }
    }
  

  Future<void> _showErrorMessage(BuildContext context, String message) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('oh vey'),
          content: Text(message),
          actions: <Widget>[
            FlatButton(
              child: const Text('Ok'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _navigateToMain(BuildContext context, FirebaseUser user) {
    UserProvider.setCurentUser(user);
    Navigator.pushReplacement(
      context,
      MaterialPageRoute<void>(
        builder: (context) => const HomePage(),
      ),
    );
  }
}
