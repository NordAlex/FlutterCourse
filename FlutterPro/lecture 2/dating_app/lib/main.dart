import 'package:dating_app/details/bloc/details_bloc.dart';
import 'package:dating_app/main/bloc/main_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'details/pages/details_page.dart';
import 'main/pages/main_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

     return MultiBlocProvider(
      providers: [
        BlocProvider<MainBloc>(
          builder: (context) => MainBloc()
        ),
        BlocProvider<DetailsBloc>(
          builder: (context) => DetailsBloc()
        ),
      ],
      child: MaterialApp(
        title: 'Destiny',
        debugShowCheckedModeBanner: false,
        theme: ThemeData.dark(),
        initialRoute: '/',
        routes: {
          '/': (context) => MainPage(),
          '/details': (context) => const DetailsPage(),
        },
      ),
    );
  }
}
