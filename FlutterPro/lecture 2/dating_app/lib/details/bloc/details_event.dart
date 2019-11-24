import 'package:dating_app/models/user.dart';
import 'package:flutter/material.dart';

@immutable
abstract class DetailsEvent{
  const DetailsEvent();
}

class ProcessUserDataEvent extends DetailsEvent {
  
  const ProcessUserDataEvent(this.user);

  final User user;
}
