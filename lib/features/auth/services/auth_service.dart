import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vokitoki/core/constants/constants.dart';
import 'package:vokitoki/features/auth/screens/onboard.dart';
import 'package:vokitoki/models/usermodel.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  // Sign Up User
  Future<String?> signUpUser({
    required String name,
    required String email,
    required String password,
    required String confirm,
    File? profileImage,
  }) async {
    try {
      final credential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      String imgUrl = '';
      if (profileImage != null) {
        final ref = _storage
            .ref()
            .child('profileImages')
            .child('${credential.user!.uid}.jpg');

        await ref.putFile(profileImage);
        imgUrl = await ref.getDownloadURL();
      }

      final userModel = UserModel(
        id: credential.user?.uid ?? '',
        name: name,
        email: email,
        password: password,
        confirm: confirm,
        image: imgUrl,
      );

      await _firestore
          .collection('users')
          .doc(userModel.id)
          .set(userModel.toMap());

      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(
        'username',
        name,
      ); // Save username in SharedPreferences

      return null; // Return null if everything went well
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        return 'User already exists. Please login.';
      }
      return e.message;
    } catch (e) {
      return e.toString();
    }
  }

  Future<String?> getUsername() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('username');
  }

  Future<void> signOut(BuildContext context) async {
    try {
      await FirebaseAuth.instance.signOut();

      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.remove('username');
      prefs.clear();

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Onboard()),
      );
    } catch (e) {
      showCupertinoDialog(
        context: context,
        builder: (BuildContext context) {
          return CupertinoAlertDialog(
            title: Text('Error'),
            content: Text(
              'An error occurred during sign-out. Please try again later.',
            ),
            actions: [
              CupertinoDialogAction(
                child: Text('OK', style: TextStyle(color: ButtonColor.alert)),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }

  Future<String?> loginUser({
    required String email,
    required String password,
  }) async {
    try {
      // Sign in using Firebase Auth
      final credential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Get user data from Firestore
      final userDoc =
          await _firestore.collection('users').doc(credential.user?.uid).get();

      if (userDoc.exists) {
        final data = userDoc.data();
        final name = data?['name'];
        final imageUrl = data?['image']; // Get the stored image URL

        // Save username and image URL to SharedPreferences
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('username', name ?? '');

        await prefs.setString('image', imageUrl ?? '');
        // Save image URL

        return null; // success
      } else {
        return 'User data not found in database.';
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return 'No user found for that email.';
      } else if (e.code == 'wrong-password') {
        return 'Incorrect password. Please try again.';
      }
      return e.message;
    } catch (e) {
      return e.toString();
    }
  }

  Future<String?> storedImage() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('image');
  }
}
