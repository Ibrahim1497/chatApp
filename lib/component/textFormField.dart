import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  CustomTextFormField({super.key,
    required this.labelText,
    this.onChanged,
    this.validator,
    required this.obscureText,
    this.suffixIcon,
    required this.prefixIcon,
  });

  final String labelText;
  void Function(String)? onChanged;
  String? Function(String?)? validator;
  bool obscureText=false;
  Widget? suffixIcon;
  Widget prefixIcon;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validator,
      onChanged: onChanged,
      keyboardType: TextInputType.emailAddress,
      obscureText: obscureText,
      decoration: InputDecoration(
        suffixIcon: suffixIcon,
        prefixIcon: prefixIcon,
        labelText: labelText,
        enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white,width: 1)
        ),
        border: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white,width: 1)
        ),
      ),
    );
  }
}
