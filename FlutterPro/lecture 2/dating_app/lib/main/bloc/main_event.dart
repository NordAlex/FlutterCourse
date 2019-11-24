import 'package:flutter/material.dart';

@immutable
abstract class MainPageEvent{
  const MainPageEvent();
}

class LoadNewUser extends MainPageEvent {
  
}