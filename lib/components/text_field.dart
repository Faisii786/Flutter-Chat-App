import 'package:flutter/material.dart';

class CustomtextField extends StatelessWidget {
  final String title;
  final TextEditingController? controller;
  final Icon? prefixicon;
  final Icon? suffixicon;
  final bool? passhidden;
  const CustomtextField(
      {super.key,
      required this.title,
      this.controller,
      this.prefixicon,
      this.passhidden,
      this.suffixicon});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(5),
      child: TextFormField(
        obscureText: false,
        controller: controller,
        decoration: InputDecoration(
            floatingLabelBehavior: FloatingLabelBehavior.never,
            floatingLabelStyle: const TextStyle(color: Colors.black),
            labelText: title,
            border: const OutlineInputBorder(),
            prefixIcon: prefixicon,
            suffixIcon: suffixicon),
      ),
    );
  }
}
