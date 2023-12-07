import 'package:flutter/material.dart';
import 'package:schools_list/config/route/scale_route.dart';
import 'package:schools_list/views/home_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.push(context, ScaleRoute(page: const HomePage()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 70,
              height: 70,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/logo.png'),
                ),
              ),
            ),
            RichText(
              text: const TextSpan(children: [
                TextSpan(
                    text: 'Schools',
                    style: TextStyle(
                        color: Color(0xFF34D399),
                        fontFamily: 'geometric',
                        fontSize: 60)),
                TextSpan(
                    text: 'List',
                    style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'geometric',
                        fontSize: 25)),
              ]),
            ),
          ],
        ),
      ),
    );
  }
}
