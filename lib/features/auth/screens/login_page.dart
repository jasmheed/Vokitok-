import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:vokitoki/core/common/button.dart';
import 'package:vokitoki/core/common/loader.dart';
import 'package:vokitoki/core/common/textfeild.dart';
import 'package:vokitoki/core/constants/constants.dart';
import 'package:vokitoki/core/enums/validation_type.dart';
import 'package:vokitoki/features/auth/screens/sign_up_page.dart';
import 'package:vokitoki/features/auth/services/auth_service.dart';
import 'package:vokitoki/features/home/screens/home_screen.dart';
import 'package:vokitoki/main.dart';
// Assuming this is the path to the signup page

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  bool isPasswordHidden = true;

  final AuthService authService = AuthService();

  Future<void> loginUser() async {
    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    // Show the loader while the login operation is in progress
    showDialog(
      context: context,
      barrierDismissible: false, // Prevent dismissing the loader
      builder: (context) => const Loader(),
    );

    // Attempt to login
    final result = await AuthService().loginUser(
      email: email,
      password: password,
    );

    // Dismiss the loader
    Navigator.of(context).pop();

    if (result == null) {
      // If login is successful, navigate to the HomeScreen
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomeScreen()),
      );
    } else {
      // If login failed, show an error alert
      showCupertinoAlert(result);
    }
  }

  void showCupertinoAlert(String message) {
    showDialog(
      context: context,
      builder:
          (context) => CupertinoAlertDialog(
            title: Text(
              "Alert",
              style: TextStyle(
                color: ButtonColor.alert,
                fontWeight: FontWeight.bold,
              ),
            ),
            content: Text(
              "Invalid User Credential Please Try again.",
              style: TextStyle(color: ColorConst.textDarkGreen),
            ),
            actions: [
              CupertinoDialogAction(
                isDefaultAction: true,
                child: Text("OK", style: TextStyle(color: ButtonColor.first)),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [ColorConst.gradientStart, ColorConst.gradientEnd],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,

        centerTitle: true,
        title: Text(
          'Login',
          style: TextStyle(
            color: ButtonColor.first,
            fontSize: width * 0.05,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
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
        child: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(
              horizontal: width * 0.08,
              vertical: width * 0.12,
            ),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  SizedBox(height: height * 0.04),
                  // Logo or other top UI elements
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
                    "Welcome back please Login",
                    style: TextStyle(
                      fontSize: width * 0.04,
                      fontWeight: FontWeight.bold,
                      color: ButtonColor.first,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: height * 0.03),
                  // Email text field
                  CustomTextField(
                    controller: emailController,
                    hint: "Email",
                    keyboardType: TextInputType.emailAddress,
                    validationType: TextFieldValidationType.email,
                  ),

                  // Password text field
                  CustomPasswordField(
                    controller: passwordController,
                    hint: "Password",
                    isHidden: isPasswordHidden,
                    onToggle:
                        () => setState(
                          () => isPasswordHidden = !isPasswordHidden,
                        ),
                    validationType: TextFieldValidationType.password,
                  ),
                  SizedBox(height: height * 0.04),
                  // Login Button
                  FillButton(
                    text: "Login",
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        loginUser();
                      }
                    },
                  ),
                  SizedBox(height: height * 0.04),
                  // Signup link
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Don’t have an account?',
                        style: TextStyle(color: ButtonColor.second),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const SignUpPage(),
                            ),
                          );
                        },
                        child: Text(
                          'Sign Up',
                          style: TextStyle(
                            color: ColorConst.textDarkGreen,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
