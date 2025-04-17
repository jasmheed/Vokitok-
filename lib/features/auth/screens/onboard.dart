import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:vokitoki/core/common/button.dart';
import 'package:vokitoki/features/auth/screens/login_page.dart';
import 'package:vokitoki/features/auth/screens/sign_up_page.dart';
import 'package:vokitoki/main.dart';
import 'package:vokitoki/core/constants/constants.dart';

class Onboard extends StatefulWidget {
  const Onboard({super.key});

  @override
  State<Onboard> createState() => _OnboardState();
}

class _OnboardState extends State<Onboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Light gradient background
          Positioned.fill(
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [ColorConst.gradientStart, ColorConst.gradientEnd],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
            ),
          ),

          // Foreground content
          Center(
            child: SizedBox(
              width: width,
              height: height * 0.7,
              child: SafeArea(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: width * 0.1),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SizedBox(
                        width: width * 0.3,
                        height: width * 0.3,
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            // Rotating ring animation
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
                            // Logo in the center
                            CircleAvatar(
                              radius: width * 0.1,
                              backgroundImage: AssetImage(Constants.logoImage),
                              backgroundColor: Colors.transparent,
                            ),
                          ],
                        ),
                      ),

                      SizedBox(height: height * 0.03),
                      Text(
                        "Welcome to Vokitok!",
                        style: TextStyle(
                          fontSize: width * 0.08,
                          fontWeight: FontWeight.bold,
                          color: ButtonColor.first,
                        ),
                        textAlign: TextAlign.center,
                      ),

                      Text(
                        "One App to replace all.India’s own Social Hyperlocal Marketplac for Products and Services.",
                        style: TextStyle(
                          fontSize: width * 0.04,

                          color: ButtonColor.second,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      Column(
                        children: [
                          SizedBox(height: height * 0.05),
                          FillButton(
                            text: "Sign Up",
                            onPressed: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => SignUpPage(),
                                ),
                              );
                            },
                          ),
                          SizedBox(height: height * 0.02),
                          NotFillB(
                            text: 'Login',
                            onPressed: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => LoginPage(),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
