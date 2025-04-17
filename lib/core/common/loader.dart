import 'package:flutter/material.dart';
import 'package:vokitoki/core/constants/constants.dart';

class Loader extends StatelessWidget {
  const Loader({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(
          ColorConst.textDarkGreen,
        ), // Use ButtonColor.first for the loader color
      ),
    );
  }
}
