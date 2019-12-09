import 'package:dating_app/pages/home_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  LoginPage({Key key}) : super(key: key);

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

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
    final _auth = FirebaseAuth.instance;
    if (email != null && password != null) {
      try {
        final authResult = await _auth.signInWithEmailAndPassword(
            email: email, password: password);
        _navigateToMain(context, authResult.user);
      } catch (ERROR_USER_NOT_FOUND) {
        try{

        final authResult = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);
        _navigateToMain(context, authResult.user);
        }
        catch(e)
        {
          print(e.toString());
        }
      }
    }
  }

  void _navigateToMain(BuildContext context, FirebaseUser user) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute<void>(
        builder: (context) => HomePage(user),
      ),
    );
  }
}
