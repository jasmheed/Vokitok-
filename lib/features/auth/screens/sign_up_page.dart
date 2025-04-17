import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vokitoki/core/common/image_picker.dart';
import 'package:vokitoki/core/common/loader.dart';
import 'package:vokitoki/core/constants/constants.dart';
import 'package:vokitoki/core/enums/validation_type.dart';
import 'package:vokitoki/features/auth/screens/login_page.dart';
import 'package:vokitoki/features/auth/services/auth_service.dart';
import 'package:vokitoki/features/home/screens/home_screen.dart';
import 'package:vokitoki/core/common/button.dart';
import 'package:vokitoki/core/common/textfeild.dart';
import 'package:vokitoki/main.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  bool isPasswordHidden = true;
  bool isConfirmHidden = true;

  final AuthService authService = AuthService();
  File? selectedImage;

  Future<void> userSignUp() async {
    // Show loader dialog
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => const Loader(),
    );

    final name = nameController.text.trim();
    final email = emailController.text.trim();
    final password = passwordController.text.trim();
    final confirm = confirmController.text.trim();

    final result = await authService.signUpUser(
      name: name,
      email: email,
      password: password,
      confirm: confirm,
      profileImage: selectedImage,
    );

    Navigator.pop(context);

    if (result == null) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomeScreen()),
      );
    } else {
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
              message,
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
          'Sign Up',
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
            padding: EdgeInsets.symmetric(horizontal: width * 0.08),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  SizedBox(height: height * 0.04),
                  GestureDetector(
                    onTap: () {
                      // Show the custom Image Picker Sheet
                      showCupertinoModalPopup(
                        context: context,
                        builder: (context) {
                          return ImagePickerSheet(
                            onImagePicked: (File image) {
                              setState(() {
                                selectedImage = image; // Set the selected image
                              });
                            },
                          );
                        },
                      );
                    },
                    child: CircleAvatar(
                      radius: width * 0.2,
                      backgroundColor: ButtonColor.skip,
                      backgroundImage:
                          selectedImage != null
                              ? FileImage(selectedImage!)
                              : null,
                      child:
                          selectedImage == null
                              ? const Icon(
                                Icons.person,
                                size: 50,
                                color: ButtonColor.first,
                              )
                              : null,
                    ),
                  ),
                  SizedBox(height: height * 0.03),
                  CustomTextField(
                    controller: nameController,
                    hint: "Full Name",
                  ),
                  CustomTextField(
                    controller: emailController,
                    hint: "Email",
                    keyboardType: TextInputType.emailAddress,
                    validationType: TextFieldValidationType.email,
                  ),

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

                  CustomPasswordField(
                    controller: confirmController,
                    hint: "Confirm Password",
                    isHidden: isConfirmHidden,
                    onToggle:
                        () =>
                            setState(() => isConfirmHidden = !isConfirmHidden),
                    validationType: TextFieldValidationType.confirmPassword,
                    confirmPassword:
                        passwordController.text, // make sure this is set too
                  ),

                  SizedBox(height: height * 0.04),
                  FillButton(
                    text: "Sign Up",
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        userSignUp();
                      }
                    },
                  ),
                  SizedBox(height: height * 0.04),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Already have an account?',
                        style: TextStyle(color: ButtonColor.second),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => const LoginPage(),
                            ),
                          );
                        },
                        child: Text(
                          'Login',
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
