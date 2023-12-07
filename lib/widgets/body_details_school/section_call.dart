import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class CallSection extends StatelessWidget {
  const CallSection({
    super.key,
    required this.phoneNumber,
    required this.website,
  });
  final String phoneNumber;
  final String website;

  @override
  Widget build(BuildContext context) {
    final Uri telUri = Uri(scheme: 'tel', path: phoneNumber);
    final Uri webUri = Uri.parse(website);
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
          "School Contact",
          style: TextStyle(
            fontSize: height * 0.04,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(
          height: height * 0.03,
        ),
        GestureDetector(
          onTap: () async {
            await launchUrl(telUri);
          },
          child: Container(
            height: height * 0.07,
            width: double.infinity,
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 237, 184, 9),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              children: [
                const Spacer(
                  flex: 2,
                ),
                Image.asset(
                  'assets/images/call.png',
                  width: width * 0.07,
                  height: height * 0.07,
                  color: Colors.white,
                ),
                const Spacer(
                  flex: 2,
                ),
                Text(
                  "school phone number",
                  style: TextStyle(
                    fontSize: height * 0.029,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const Spacer(
                  flex: 3,
                ),
              ],
            ),
          ),
        ),
        SizedBox(
          height: height * 0.02,
        ),
        GestureDetector(
          onTap: () async {
            await launchUrl(webUri);
          },
          child: Container(
            height: height * 0.07,
            width: double.infinity,
            decoration: BoxDecoration(
              color: const Color(0xFF1A237E),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              children: [
                const Spacer(
                  flex: 2,
                ),
                Image.asset(
                  'assets/images/global.png',
                  width: width * 0.07,
                  height: height * 0.07,
                  color: Colors.white,
                ),
                const Spacer(
                  flex: 2,
                ),
                Text(
                  "school Website",
                  style: TextStyle(
                    fontSize: height * 0.029,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const Spacer(
                  flex: 3,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
