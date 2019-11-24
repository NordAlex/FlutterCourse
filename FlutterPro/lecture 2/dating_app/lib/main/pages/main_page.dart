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
  final _title = 'Almost Tinder';

  @override
  void didChangeDependencies() {
    const PageStorageKey<String>('test');
    BlocProvider.of<MainBloc>(context)..add(LoadNewUser());
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_title),
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
      onReload: () => _reloadUser(),
      onNext: () => _showDetails(),
    );
  }

  Widget _buildProfile() {
    return BlocBuilder<MainBloc, MainState>(
      builder: (context, state) {
        if (state is UserLoadedState) {
          return Container(
            height: 390,
            child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Hero(
                tag: 'avatar',
                child: Image.network(
                  state.user.image,
                  fit: BoxFit.fill,
                  height: 300,
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
          ));
        }
        else if(state is UserLoadingState)
        {
          return Container(
            height: 390,
            child: Center(
              child: const CircularProgressIndicator(),
            ),
          );
        }
        
        return Container(
            height: 390,
            child: const Text('Network error'));
      },
    );
  }

  void _reloadUser() => BlocProvider.of<MainBloc>(context)..add(LoadNewUser());

  void _showDetails() {
    final state = BlocProvider.of<MainBloc>(context).state;
    if (state is UserLoadedState) {
      Navigator.of(context).push<void>(MaterialPageRoute(
        builder: (context) => DetailsPage(user: state.user),
      ));
    }
  }
}
