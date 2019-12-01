import 'package:dating_app/models/user.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong/latlong.dart';
import 'package:location_permissions/location_permissions.dart';

class DetailsPage extends StatefulWidget {
  const DetailsPage({Key key, this.user}) : super(key: key);

  final User user;

  @override
  _DetailsPageState createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage>
    with TickerProviderStateMixin {
  AnimationController _imageOpacityController;
  AnimationController _textOpacityController;

  Animation<double> _imageOpacityAnimation;
  Animation<double> _textOpacityAnimation;

  @override
  void initState() {
    super.initState();

    _textOpacityController = AnimationController(
        vsync: this, duration: const Duration(seconds: 2));
    _textOpacityAnimation =
        Tween(begin: 0.0, end: 1.0).animate(_textOpacityController)
          ..addListener((() {
            setState(() {});
          }));

      _textOpacityController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.user.name),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[Image.network(
              widget.user.image,
              fit: BoxFit.fill,
              height: 400,
              width: 400,
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: FutureBuilder<LatLng>(
                future: _getCoordinates(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    final km = Distance().as(
                        LengthUnit.Kilometer,
                        snapshot.data,
                        LatLng(widget.user.latitude, widget.user.longitude));
                    return FadeTransition(opacity: _textOpacityAnimation, child:Text(
                      '${widget.user.name} is $km km away from you!',
                      style: Theme.of(context).textTheme.headline,
                    ));
                  } else if (snapshot.hasError) {
                    return Text(
                      'Please turn on the geolocation',
                      style: Theme.of(context).textTheme.headline,
                    );
                  } else {
                    return const CircularProgressIndicator();
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<LatLng> _getCoordinates() async {
    final permission = LocationPermissions();
    await permission.requestPermissions();

    final geolocator = Geolocator();
    final position = await geolocator.getLastKnownPosition(
        desiredAccuracy: LocationAccuracy.high);
    return LatLng(0, 0);
  }
}
