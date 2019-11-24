
import 'package:dating_app/models/user.dart';
import 'package:flutter/material.dart';

abstract class DetailsState{
  const DetailsState();
}

class InitialDetailsState extends DetailsState {
}

class UserProcessedState extends DetailsState {

  const UserProcessedState({@required this.user, @required this.distance});
    final User user;
    final num distance; 
}
