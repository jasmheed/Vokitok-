import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vokitoki/core/constants/constants.dart';

class ImagePickerSheet extends StatelessWidget {
  final Function(File)? onImagePicked;

  const ImagePickerSheet({Key? key, this.onImagePicked}) : super(key: key);

  Future<void> pickImage(BuildContext context, ImageSource source) async {
    final pickedFile = await ImagePicker().pickImage(source: source);

    if (pickedFile != null) {
      final imageFile = File(pickedFile.path);

      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('image', imageFile.path);

      // Call the image callback (for UI updates)
      onImagePicked?.call(imageFile);

      // Close the sheet after image is picked
      Navigator.pop(context);
    } else {
      // Close the sheet if no image was picked
      Navigator.pop(context);
    }
  }

  Future<String?> getImagePath() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('image');
  }

  Future<void> removeImagePath(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove('');
    prefs.clear();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoActionSheet(
      actions: [
        CupertinoActionSheetAction(
          onPressed: () {
            pickImage(context, ImageSource.gallery);
          },
          child: Text(
            "Photo Gallery",
            style: TextStyle(
              color: ButtonColor.first, // Button color from your theme
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
        CupertinoActionSheetAction(
          onPressed: () {
            pickImage(context, ImageSource.camera);
          },
          child: Text(
            "Camera",
            style: TextStyle(
              color: ButtonColor.first, // Button color from your theme
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ],
      cancelButton: CupertinoActionSheetAction(
        onPressed: () {
          Navigator.pop(context); // Close the picker
        },
        child: Text(
          "Cancel",
          style: TextStyle(
            color: ButtonColor.alert, // Cancel button color
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}
