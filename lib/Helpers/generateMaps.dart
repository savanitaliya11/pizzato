// ignore_for_file: void_checks, prefer_const_constructors

import 'dart:async';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:pizzato/Constant/utility.dart';

String finalAdd = 'Searching for....';

class GenerateMaps extends ChangeNotifier {
  String finalAdd = 'Searching for....';
  Future<Position> getCurrentPosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      await Geolocator.openLocationSettings();
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }

  Future GetAddressFromLatLong(Position position) async {
    List<Placemark> placemarks =
        await placemarkFromCoordinates(position.latitude, position.longitude);
    Placemark place = placemarks[0];
    dynamic Address = '${place.street},${place.subLocality}, ${place.locality}';
    // ' ${place.subLocality}, ${place.locality}, ${place.postalCode}, ${place.country}';
    finalAdd = Address;
    print('${finalAdd}');
    notifyListeners();
  }

  LatLng? currentPostion;
  void getUserLocation() async {
    var position = await GeolocatorPlatform.instance.getCurrentPosition(
        locationSettings: LocationSettings(accuracy: LocationAccuracy.high));

    currentPostion = LatLng(position.latitude, position.longitude);
    //log('CURRENTPOSITION==>>>>>>>>>>>>>${currentPostion}');

    Utility.latLng = currentPostion!;

    var address =
        await placemarkFromCoordinates(position.latitude, position.longitude);
    Placemark place = address[0];
    dynamic mainAdd = '${place.street},${place.subLocality}, ${place.locality}';
    log('MAINADDRES==>>>>>>>>>>>>>${mainAdd}');
    finalAdd = mainAdd;
    notifyListeners();
  }
}
