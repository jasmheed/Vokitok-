import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'package:vokitoki/core/common/image_picker.dart';
import 'package:vokitoki/core/constants/constants.dart';
import 'package:vokitoki/features/auth/services/auth_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String username = '';
  String? imagePath;

  @override
  void initState() {
    super.initState();
    loadUsername();
    loadImagePath();
    storedImage();
  }

  Future<void> signOut() async {
    setState(() {
      AuthService().signOut(context);
      ImagePickerSheet().removeImagePath(context);
    });
  }

  Future<void> loadUsername() async {
    String? fetchedUsername = await AuthService().getUsername();
    setState(() {
      username = fetchedUsername ?? 'User';
    });
  }

  Future<void> storedImage() async {
    String? saveImage = await AuthService().storedImage();
    setState(() {
      imagePath = saveImage;
    });
  }

  Future<void> loadImagePath() async {
    String? saveImage = await ImagePickerSheet().getImagePath();
    setState(() {
      imagePath = saveImage;
    });
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

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
        leading: Align(
          alignment: Alignment.center,
          child: Padding(
            padding: EdgeInsets.only(left: width * 0.03),
            child: CircleAvatar(
              radius: width * 0.08,
              backgroundColor: ButtonColor.skip,
              backgroundImage:
                  imagePath != null
                      ? (imagePath!.startsWith(
                            'http',
                          ) // Check if it's a URL (Firebase)
                          ? NetworkImage(
                            imagePath!,
                          ) // Use NetworkImage for Firebase URL
                          : FileImage(
                            File(imagePath!),
                          ) // Use FileImage for local storage
                          )
                      : null, // No image to show if imagePath is null
              child:
                  imagePath == null ||
                          imagePath!
                              .isEmpty // If no image URL or path is set
                      ? const Icon(
                        Icons
                            .person, // Fallback to a person icon if no image is selected
                        color:
                            ButtonColor
                                .first, // You can customize the color here
                      )
                      : null,
            ),
          ),
        ),

        centerTitle: true,
        title: Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'Hello, $username',
            style: TextStyle(
              color: ButtonColor.first,
              fontSize: width * 0.045,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout, color: ButtonColor.first),
            onPressed: () {
              signOut();
            },
          ),
        ],
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
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
              "Features comming soon!",
              style: TextStyle(
                fontSize: width * 0.05,
                fontWeight: FontWeight.bold,
                color: ButtonColor.first,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
