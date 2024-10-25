// lib/widgets/common/custom_text_field.dart
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String labelText;
  final bool obscureText;
  final Function(String)? onChanged;
  final String? Function(String?)? validator;

  const CustomTextField({
    super.key,
    required this.labelText,
    this.obscureText = false,
    this.onChanged,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(labelText: labelText),
      obscureText: obscureText,
      onChanged: onChanged,
      validator: validator,
    );
  }
}
