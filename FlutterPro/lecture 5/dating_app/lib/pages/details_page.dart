import 'package:dating_app/models/user.dart';
import 'package:dating_app/utils/curent_user_provider.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong/latlong.dart';
import 'package:location_permissions/location_permissions.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DetailsPage extends StatelessWidget {
  DetailsPage({Key key, this.tinderUser}) : super(key: key);

  final User tinderUser;
  final databaseReference = Firestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(tinderUser.name),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Hero(
              tag: 'avatar',
              child: Image.network(
                tinderUser.image,
                fit: BoxFit.fill,
                height: 400,
                width: 400,
              ),
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
                        LatLng(tinderUser.latitude, tinderUser.longitude));
                    return Text(
                      '${tinderUser.name} is $km km away from you!',
                      style: Theme.of(context).textTheme.headline,
                    );
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
            Ink(
              decoration: ShapeDecoration(
                color: Colors.red,
                shape: CircleBorder(),
              ),
              child: IconButton(
                iconSize: 36,
                onPressed: () => _likeUser(),
                icon: Icon(Icons.favorite),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _likeUser() async {
    final myUser = UserProvider.getCurentUser();
    await databaseReference
        .collection('users')
        .document(myUser.uid)
        .collection('favorites')
        .add(<String, dynamic>{
      'name': tinderUser.name,
      'location': {'lat': tinderUser.latitude, 'long': tinderUser.longitude},
      'image': tinderUser.image
    });
  }

  Future<LatLng> _getCoordinates() async {
    final permission = LocationPermissions();
    await permission.requestPermissions();

    final geolocator = Geolocator();
    final position = await geolocator.getLastKnownPosition(
        desiredAccuracy: LocationAccuracy.high);
    return LatLng(position.latitude, position.longitude);
  }
}
