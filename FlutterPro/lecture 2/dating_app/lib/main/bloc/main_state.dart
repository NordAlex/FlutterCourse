import 'package:dating_app/models/user.dart';
import 'package:flutter/material.dart';

@immutable
abstract class MainState {
  const MainState(); 
}

class UserLoadingState extends MainState {}

class UserLoadedState extends MainState{ 

  const UserLoadedState(this.user);

  final User user;
}

class UserLoadingFailed extends MainState{
}


