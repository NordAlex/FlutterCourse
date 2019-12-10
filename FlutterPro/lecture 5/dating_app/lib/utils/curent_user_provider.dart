import 'package:firebase_auth/firebase_auth.dart';

class UserProvider{
  
  static FirebaseUser _curentUser;

  static FirebaseUser getCurentUser()
  {
    return _curentUser;
  }

  static void setCurentUser(FirebaseUser user)
  {
    _curentUser = user;
  }
}