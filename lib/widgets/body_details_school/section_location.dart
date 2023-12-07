import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class SectionLocation extends StatelessWidget {
  const SectionLocation({
    super.key,
    required CameraPosition initialPosition,
    required this.myMarker,
    required Completer<GoogleMapController> controller,
    required this.street,
  })  : _initialPosition = initialPosition,
        _controller = controller;

  final CameraPosition _initialPosition;
  final List<Marker> myMarker;
  final Completer<GoogleMapController> _controller;
  final String street;
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    MediaQuery.of(context).orientation == Orientation.portrait
        ? height = MediaQuery.of(context).size.height
        : height = MediaQuery.of(context).size.width;
    MediaQuery.of(context).orientation == Orientation.portrait
        ? width = MediaQuery.of(context).size.width
        : width = MediaQuery.of(context).size.height;
    return Column(
      children: [
        Text(
          "School Location",
          style: TextStyle(
            fontSize: height * 0.04,
            fontWeight: FontWeight.bold,
          ),
        ),
        Container(
          padding: const EdgeInsets.all(10),
          margin: EdgeInsets.symmetric(vertical: width * 0.03),
          decoration: const BoxDecoration(
            color: Color(0xffebedee),
            borderRadius: BorderRadius.all(
              Radius.circular(30.0),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                'assets/images/location.png',
                width: width * 0.04,
                height: height * 0.04,
              ),
              SizedBox(
                width: width * 0.02,
              ),
              Text(
                street,
                style: TextStyle(
                  fontSize: height * 0.02,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: height * 0.005,
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: width * 0.04),
          height: MediaQuery.of(context).size.height * 0.4,
          child: GoogleMap(
              initialCameraPosition: _initialPosition,
              mapType: MapType.normal,
              markers: Set<Marker>.of(myMarker),
              onMapCreated: (GoogleMapController controller) {
                _controller.complete(controller);
              },
              myLocationEnabled: true,
              scrollGesturesEnabled: false,
              zoomGesturesEnabled: false),
        ),
      ],
    );
  }
}
