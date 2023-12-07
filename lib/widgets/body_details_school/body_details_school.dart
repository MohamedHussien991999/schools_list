import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:schools_list/views/details_school.dart';
import 'package:schools_list/widgets/body_details_school/section_call.dart';
import 'package:schools_list/widgets/body_details_school/section_details.dart';
import 'package:schools_list/widgets/body_details_school/section_location.dart';

class BodyDetailsSchool extends StatelessWidget {
  const BodyDetailsSchool({
    super.key,
    required this.widget,
    required CameraPosition initialPosition,
    required this.myMarker,
    required Completer<GoogleMapController> controller,
  })  : _initialPosition = initialPosition,
        _controller = controller;

  final DetailsSchool widget;
  final CameraPosition _initialPosition;
  final List<Marker> myMarker;
  final Completer<GoogleMapController> _controller;

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
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: width * 0.03, vertical: height * 0.03),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                    color: const Color(0xFF1A237E),
                    height: height * 0.07,
                    width: double.infinity,
                    child: Center(
                      child: Row(
                        children: [
                          IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: Icon(
                              Icons.arrow_back,
                              color: Colors.white,
                              size: height * 0.04,
                            ),
                          ),
                          const Spacer(
                            flex: 1,
                          ),
                          Text(
                            "School Details",
                            style: TextStyle(
                              fontSize: height * 0.025,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          const Spacer(
                            flex: 1,
                          ),
                        ],
                      ),
                    )),
                SizedBox(
                  height: height * 0.02,
                ),
                SectionLocation(
                  initialPosition: _initialPosition,
                  myMarker: myMarker,
                  controller: _controller,
                  street: widget.schoolModel.street,
                ),
                SizedBox(
                  height: height * 0.02,
                ),
                SectionDetails(
                  name: widget.schoolModel.name,
                  level: widget.schoolModel.level,
                  type: widget.schoolModel.type,
                  maxAvailableGrade: widget.schoolModel.maxAvailableGrade,
                  minAvailableGrade: widget.schoolModel.minAvailableGrade,
                  language: widget.schoolModel.language,
                ),
                SizedBox(
                  height: height * 0.02,
                ),
                SizedBox(
                  height: height * 0.02,
                ),
                CallSection(
                  phoneNumber: widget.schoolModel.phoneNumber,
                  website: widget.schoolModel.website,
                ),
                SizedBox(
                  height: height * 0.02,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
