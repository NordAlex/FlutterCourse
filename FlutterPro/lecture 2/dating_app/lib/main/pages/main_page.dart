import 'package:dating_app/details/pages/details_page.dart';
import 'package:dating_app/main/bloc/bloc.dart';
import 'package:dating_app/widgets/user_buttons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  void didChangeDependencies() {
    BlocProvider.of<MainBloc>(context)..add(LoadNewUser());
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Almost Tinder'),
      ),
      body: Center(
          child: SingleChildScrollView(
        child: Column(
          children: <Widget>[_buildProfile(), _buidbuttons()],
        ),
      )),
    );
  }

  Widget _buidbuttons() {
    return UserButtons(
      onReload: () {
        BlocProvider.of<MainBloc>(context)..add(LoadNewUser());
      },
      onNext: () {
        final state = BlocProvider.of<MainBloc>(context).state;
        if (state is UserLoadedState) {
          Navigator.of(context).push<void>(MaterialPageRoute(
            builder: (context) => DetailsPage(user: state.user),
          ));
        }
      },
    );
  }

  Widget _buildProfile() {
    return BlocBuilder<MainBloc, MainState>(
      builder: (context, state) {
        if (state is UserLoadedState) {
          return Column(
            children: <Widget>[
              Hero(
                tag: 'avatar',
                child: Image.network(
                  state.user.image,
                  fit: BoxFit.fill,
                  height: 300,
                  width: 300,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 24.0),
                child: Text(
                  state.user.name,
                  style: Theme.of(context).textTheme.display1,
                ),
              ),
            ],
          );
        }
        return const CircularProgressIndicator();
      },
    );
  }
}
