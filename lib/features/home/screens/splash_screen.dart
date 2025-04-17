import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:vokitoki/core/constants/constants.dart';
import 'package:vokitoki/main.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  double _opacity = 0.0; // Initial opacity set to 0 (invisible)

  @override
  void initState() {
    super.initState();
    fadeInLogo(); // Trigger fade-in effect on splash screen load
  }

  // Function to gradually change opacity to 1 (fully visible)
  Future<void> fadeInLogo() async {
    await Future.delayed(
      const Duration(seconds: 1),
    ); // Wait for a second before fading in
    setState(() {
      _opacity = 1.0; // Fade in by changing opacity to 1
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: height,
        width: width,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [ColorConst.gradientStart, ColorConst.gradientEnd],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: SizedBox(
            width: width * 0.3,
            height: width * 0.3,
            child: Stack(
              alignment: Alignment.center,
              children: [
                const SpinKitRing(
                  color: ButtonColor.first,
                  lineWidth: 2,
                  size: 140,
                  duration: Duration(seconds: 6),
                ),
                Transform(
                  alignment: Alignment.center,
                  transform: Matrix4.rotationY(pi),
                  child: const SpinKitRing(
                    color: ButtonColor.third,
                    lineWidth: 2,
                    size: 100,
                    duration: Duration(seconds: 3),
                  ),
                ),
                AnimatedOpacity(
                  opacity: _opacity, // Set opacity based on _opacity value
                  duration: const Duration(seconds: 2), // Fade-in duration
                  child: CircleAvatar(
                    radius: width * 0.1,
                    backgroundImage: AssetImage(Constants.logoImage),
                    backgroundColor: Colors.transparent,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
