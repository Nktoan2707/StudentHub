import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  static const String pageId = "/SplashScreen";

  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: (
        Center(
          child: 
          Image.asset(
                      'assets/images/slash.jpg',
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width,
                    ),
        )
      ),
    );
  }
}
