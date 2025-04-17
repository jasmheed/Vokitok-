import 'package:flutter/material.dart';
import 'package:vokitoki/core/constants/constants.dart';
import 'package:vokitoki/core/enums/validation_type.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final TextInputType keyboardType;
  final String? Function(String?)? validator;
  final TextFieldValidationType validationType;
  final String? confirmPassword;

  const CustomTextField({
    Key? key,
    required this.controller,
    required this.hint,
    this.keyboardType = TextInputType.text,
    this.validator,
    this.validationType = TextFieldValidationType.none,
    this.confirmPassword,
  }) : super(key: key);
  String? _defaultValidator(String? value) {
    final lowercaseEmailRegex = RegExp(
      r"^[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,4}$",
    );

    if (value == null || value.isEmpty) return "Enter $hint";

    if (validationType == TextFieldValidationType.email) {
      if (!lowercaseEmailRegex.hasMatch(value)) {
        return "Enter a valid lowercase email";
      }
    }

    if (validationType == TextFieldValidationType.confirmPassword) {
      if (value != confirmPassword) return "Passwords do not match";
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        cursorColor: ColorConst.cursorDarkGreen,
        style: const TextStyle(color: ColorConst.textDarkGreen),
        decoration: InputDecoration(
          filled: true,
          fillColor: ButtonColor.skip,
          hintText: hint,
          hintStyle: const TextStyle(color: ColorConst.textDarkGreen),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
        ),
        validator: validator ?? _defaultValidator,
      ),
    );
  }
}

class CustomPasswordField extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final bool isHidden;
  final VoidCallback onToggle;
  final TextFieldValidationType validationType;
  final String? confirmPassword;

  const CustomPasswordField({
    Key? key,
    required this.controller,
    required this.hint,
    required this.isHidden,
    required this.onToggle,
    this.validationType = TextFieldValidationType.none,
    this.confirmPassword,
  }) : super(key: key);

  String? _defaultValidator(String? value) {
    final passwordRegex = RegExp(
      r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$',
    );

    if (value == null || value.isEmpty) return "Enter $hint";

    if (validationType == TextFieldValidationType.password) {
      if (!passwordRegex.hasMatch(value)) {
        return 'Password must contain uppercase, lowercase, number, special char, and 8+ chars';
      }
    }

    if (validationType == TextFieldValidationType.confirmPassword) {
      if (value != confirmPassword) return "Passwords do not match";
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: TextFormField(
        controller: controller,
        obscureText: isHidden,
        cursorColor: ColorConst.cursorDarkGreen,
        style: const TextStyle(color: ColorConst.textDarkGreen),
        decoration: InputDecoration(
          filled: true,
          fillColor: ButtonColor.skip,
          hintText: hint,
          hintStyle: const TextStyle(color: ColorConst.textDarkGreen),
          suffixIcon: IconButton(
            icon: Icon(isHidden ? Icons.visibility_off : Icons.visibility),
            onPressed: onToggle,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
        ),
        validator: _defaultValidator,
      ),
    );
  }
}
