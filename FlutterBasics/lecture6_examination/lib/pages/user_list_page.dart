import 'package:flutter/material.dart';
import 'package:lecture6_examination/controls/circle_button.dart';
import 'package:lecture6_examination/models/User.dart';
import 'package:lecture6_examination/pages/user_details.dart';
import 'package:lecture6_examination/providers/user_provider.dart';

class UserListPage extends StatefulWidget {
  @override
  _UserListPageState createState() => _UserListPageState();
}

class _UserListPageState extends State<UserListPage> {
  final _userProvider = UserProvider();
  final _titleText = 'Almost tinder';
  final _errorMessage = 'Oh vey. Somethings went wrong';

  User _currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_titleText),
      ),
      body: Center(child: _fetchNewUser()),
    );
  }

  Widget _fetchNewUser() {
    return FutureBuilder<User>(
      future: _userProvider.getNewUser(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          _currentUser = snapshot.data;
          return _showResult(snapshot.data);
        } else if (snapshot.hasError) {
          return _showError(context);
        }
        return _showProgresIndicator();
      },
    );
  }

  Widget _showResult(User user) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Image.network(user.picture.medium),
        Text(user.name),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CircleButton(
                Icons.refresh, Colors.white, Colors.grey, _refreshUser),
            CircleButton(Icons.navigate_next, Colors.blue, Colors.white,
                _showDetailsPage)
          ],
        )
      ],
    );
  }

  Widget _showError(BuildContext context) {
    return Text(_errorMessage);
  }

  Widget _showProgresIndicator() => const CircularProgressIndicator();

  void _refreshUser() => setState;

  void _showDetailsPage() {
    Navigator.push<UserDetailsPage>(context,
        MaterialPageRoute(builder: (context) => UserDetailsPage(_currentUser)));
  }
}
