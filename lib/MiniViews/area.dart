// ignore_for_file: prefer_const_constructors

import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:page_transition/page_transition.dart';
import 'package:pizzato/Constant/utility.dart';
import 'package:pizzato/Views/my_cart.dart';
import 'package:provider/provider.dart';

class Area extends StatefulWidget {
  @override
  State<Area> createState() => _AreaState();
}

class _AreaState extends State<Area> {
  // Map<MarkerId, Marker> markers = <MarkerId, Marker>{};
  Set<Marker> _markers = {};

  // getMarkers(double lat, double lng) {
  void _onMapcreated(GoogleMapController mapController) {
    setState(() {
      _markers.add(Marker(
        markerId: MarkerId('id-1'),
        position: Utility.latLng,
        icon: BitmapDescriptor.defaultMarker,
        infoWindow: InfoWindow(title: 'Your City', snippet: 'Country'),
      ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Google Map'),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pushReplacement(
                context,
                PageTransition(
                    child: MyCart(),
                    type: PageTransitionType.leftToRightWithFade));
          },
          icon: Icon(Icons.backspace_rounded),
        ),
      ),
      body: Stack(
        children: [
          GoogleMap(
            myLocationEnabled: true,
            mapToolbarEnabled: true,
            markers: _markers,
            onMapCreated: _onMapcreated,
            mapType: MapType.hybrid,
            initialCameraPosition: CameraPosition(
              target: Utility.latLng,
              zoom: 18,
            ),
            onTap: (argument) async {
              setState(() {
                _markers.add(Marker(
                  markerId: MarkerId('id-1'),
                  position: LatLng(argument.latitude, argument.longitude),
                  icon: BitmapDescriptor.defaultMarker,
                  infoWindow:
                      InfoWindow(title: 'Your City', snippet: 'Country'),
                ));
              });
              var address = await placemarkFromCoordinates(
                  argument.latitude, argument.longitude);
              Placemark place = address[0];
              dynamic mainAdd =
                  '${place.street},${place.subLocality}, ${place.locality}';
              Utility.finalAdd = mainAdd;

              log("LAT_LONg ${argument.latitude} ${argument.longitude}");
              log("FINAL_ADD ${Utility.finalAdd}");
            },
          ),
          Positioned(
            top: 645,
            child: Container(
              width: 400,
              height: 50,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30.0),
                  color: Colors.transparent),
              child: Text(
                '${Utility.finalAdd}',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 25,
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
