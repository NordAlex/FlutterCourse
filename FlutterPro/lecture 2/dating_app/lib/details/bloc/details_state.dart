
import 'package:dating_app/models/user.dart';
import 'package:flutter/material.dart';

abstract class DetailsState{
  const DetailsState();
}

class UserProcessingState extends DetailsState {
}

class ProcessingFailedState extends DetailsState {

  const ProcessingFailedState(this.errorMessage);

  final String errorMessage;
}

class UserProcessedState extends DetailsState {

  const UserProcessedState({@required this.user, @required this.distance});
    final User user;
    final num distance; 
}


