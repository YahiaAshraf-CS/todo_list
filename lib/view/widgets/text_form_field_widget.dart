import 'package:flutter/material.dart';
class TextFormFieldWiget extends StatelessWidget {
  const new({
    super.key,
    required this.labelText,
    required this.hintText,
    this.controller,
    this.validator,
    this.maxLines = 1,
  });
  final String labelText;
  final String hintText;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final int? maxLines;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      cursorColor: Colors.black,
      controller: controller,
      validator: validator,
      maxLines: maxLines,
      cursorErrorColor: Colors.red,

      decoration: InputDecoration(
        labelText: labelText,
        hintText: hintText,

        labelStyle: TextStyle(
          color: Colors.black,
          fontSize: 15,
          fontWeight: .w600,

          fontFamily: "Poppins",
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            color: const Color.fromARGB(255, 80, 160, 227),
            width: 2,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            color: const Color.fromARGB(255, 11, 93, 160),
            width: 2,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.red, width: 2),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.red, width: 2),
        ),
      ),
    );
  }
}
