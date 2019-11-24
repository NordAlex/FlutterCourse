import 'dart:async';
import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:dating_app/models/user.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import './bloc.dart';

class MainBloc extends Bloc<MainPageEvent, MainState> {
  @override
  MainState get initialState => UserLoadingState();

  @override
  Stream<MainState> mapEventToState(
    MainPageEvent event, 
  ) async* {
    if(event is LoadNewUser){
      yield UserLoadingState();

      final user =  await _generateUser();
      yield UserLoadedState(user);
    }
  }

  Future<User> _generateUser() async {
    final uri = Uri.https('randomuser.me', '/api/1.3');
    final response = await http.get(uri);
    return compute(_parseUser, response.body);
  }

    static User _parseUser(String response) {
    final Map<String, dynamic> parsed = json.decode(response);
    return User.fromRandomUserResponse(parsed);
  }
}
