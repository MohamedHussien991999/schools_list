import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:schools_list/model/school_model.dart';
import 'package:schools_list/widgets/body_details_school/body_details_school.dart';

class DetailsSchool extends StatefulWidget {
  const DetailsSchool({super.key, required this.schoolModel});
  final SchoolModel schoolModel;
  @override
  State<DetailsSchool> createState() => _DetailsSchoolState();
}

class _DetailsSchoolState extends State<DetailsSchool> {
  final Completer<GoogleMapController> _controller = Completer();

  late CameraPosition _initialPosition;

  final List<Marker> myMarker = [];

  @override
  void initState() {
    myMarker.add(
      Marker(
        visible: true,
        markerId: const MarkerId("first"),
        position:
            LatLng(widget.schoolModel.latitude, widget.schoolModel.longitude),
        infoWindow: InfoWindow(
          title: widget.schoolModel.name,
          snippet: widget.schoolModel.street,
        ),
      ),
    );
    _initialPosition = CameraPosition(
      target: LatLng(widget.schoolModel.latitude, widget.schoolModel.longitude),
      zoom: 14,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BodyDetailsSchool(widget: widget, initialPosition: _initialPosition, myMarker: myMarker, controller: _controller);
  }
}
