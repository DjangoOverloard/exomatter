import 'package:flutter/material.dart';

class ExTextField extends StatelessWidget {
  final String hint;
  final IconData icon;
  final BorderRadius borderRadius;
  final TextEditingController controller;
  final bool obscureText;
  final TextInputType keyboardType;

  const ExTextField({
    Key key,
    this.hint,
    this.icon,
    this.borderRadius,
    this.controller,
    this.obscureText,
    this.keyboardType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: borderRadius ?? BorderRadius.circular(4.0),
      ),
      child: TextField(
        controller: controller,
        keyboardType: keyboardType,
        obscureText: obscureText ?? false,
        decoration: InputDecoration(
          hintText: hint,
          border: InputBorder.none,
          contentPadding: EdgeInsets.all(16.0),
          prefixIcon: Icon(
            icon,
            color: Colors.teal,
          ),
        ),
      ),
    );
  }
}
