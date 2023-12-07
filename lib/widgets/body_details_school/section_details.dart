import 'package:flutter/material.dart';

class SectionDetails extends StatelessWidget {
  const SectionDetails({
    super.key,
    required this.name,
    required this.level,
    required this.type,
    required this.maxAvailableGrade,
    required this.minAvailableGrade,
    required this.language,
  });
  final String name;
  final String level;
  final String type;
  final int maxAvailableGrade;
  final int minAvailableGrade;
  final String language;
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    MediaQuery.of(context).orientation == Orientation.portrait
        ? height = MediaQuery.of(context).size.height
        : height = MediaQuery.of(context).size.width;

    return Column(
      children: [
        Text(
          "School Details",
          style: TextStyle(
            fontSize: height * 0.04,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(
          height: height * 0.03,
        ),
        Text(
          "Name: $name\n"
          "Level: $level\n"
          "Type: $type\n"
          "Max Available Grade: $maxAvailableGrade\n"
          "Min Available Grade: $minAvailableGrade\n"
          "Language: $language\n",
          style: TextStyle(
            fontSize: height * 0.02,
            fontWeight: FontWeight.bold,
            color: Colors.grey[700],
          ),
        ),
      ],
    );
  }
}
