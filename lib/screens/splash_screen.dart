import 'package:flutter/material.dart';
import '../screens/login_page.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 0), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => LoginPage()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  '../assets/aviation_logo.png',  // Replace with your aviation company logo
                  height: 120,
                ),
                SizedBox(height: 20),
                Text(
                  "Airport & Aviation Services Sri Lankaaaa",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue.shade900,
                    fontFamily: 'Roboto',
                  ),
                ),
                SizedBox(height: 20),
                SpinKitFadingCircle(
                  color: Colors.blue.shade700,
                  size: 50.0,
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 30,
            left: 0,
            right: 0,
            child: Center(
              child: Text(
                "Powering the Future of Aviation",
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.blue.shade600,
                  fontWeight: FontWeight.w500,
                  fontFamily: 'Roboto',
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
