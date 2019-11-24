import 'package:dating_app/details/bloc/details_bloc.dart';
import 'package:dating_app/details/bloc/details_event.dart';
import 'package:dating_app/details/bloc/details_state.dart';
import 'package:dating_app/models/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DetailsPage extends StatefulWidget {

  const DetailsPage({Key key, @required this.user}) : super(key: key);

  final User user;

  @override
  _DetailsPageState createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {


  @override
  void didChangeDependencies() {
    BlocProvider.of<DetailsBloc>(context)..add(ProcessUserDataEvent(widget.user));
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.user.name),
      ),
      body: BlocBuilder<DetailsBloc, DetailsState>(
        builder: (context, state) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Hero(
                  tag: 'avatar',
                  child: Image.network(
                    widget.user.image,
                    fit: BoxFit.fill,
                    height: 400,
                    width: 400,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: BlocBuilder<DetailsBloc, DetailsState>(
                    builder: (context, state) {
                      if (state is UserProcessedState) {
                        return Text(
                          '${state.user.name} is ${state.distance} km away from you!',
                          style: Theme.of(context).textTheme.headline,
                        );
                      }
                      else if (state is ProcessingFailedState) {
                        return Text(
                          'Please turn on the geolocation',
                          style: Theme.of(context).textTheme.headline,
                        );
                      } 
                      else {
                        return const CircularProgressIndicator();
                      }
                    },
                  ),
                ),
              ],
            ),
          );
        }
      ),
    );
  }

 
 
}
