import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:vokitoki/features/home/screens/home_screen.dart';
import 'package:vokitoki/features/auth/screens/onboard.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    // If user is logged in, go to home screen
    if (user != null) {
      return const HomeScreen();
    }

    // If not logged in, go to onboard/login screen
    return const Onboard();
  }
}
