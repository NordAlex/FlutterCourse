import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:lecture6_examination/models/User.dart'; 

class UserProvider {
  Future<User> getNewUser() async {
    final response = await http.get('https://randomuser.me/api/');
    if (response.statusCode == 200) {
      return User.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load user');
    }
  }
}