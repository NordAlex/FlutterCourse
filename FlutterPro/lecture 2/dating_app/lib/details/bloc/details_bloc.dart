import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong/latlong.dart';
import 'package:location_permissions/location_permissions.dart';
import './bloc.dart';

class DetailsBloc extends Bloc<DetailsEvent, DetailsState> {
  @override
  DetailsState get initialState => UserProcessingState();

  @override
  Stream<DetailsState> mapEventToState(DetailsEvent event) async* {
    if (event is ProcessUserDataEvent) {
      final permission = await _getPermission();
      if(permission != PermissionStatus.granted)
      {
        yield ProcessingFailedState();
        return;
      }
      try
      {
        final coordinates = await _getCoordinates();
        final distance = Distance().as(LengthUnit.Kilometer, coordinates,
            LatLng(event.user.latitude, event.user.longitude));
        yield UserProcessedState(user: event.user, distance: distance);
      }
      catch(exeption)
      {
        yield ProcessingFailedState();
      }
    }
  }

  Future<PermissionStatus> _getPermission() async{
    final permission = LocationPermissions();
    final status = await permission.requestPermissions();
    return status;
  }

  Future<LatLng> _getCoordinates() async {
    final geolocator = Geolocator();
    final position = await geolocator.getLastKnownPosition(
        desiredAccuracy: LocationAccuracy.high);
    return LatLng(position.latitude, position.longitude);
  }
}
