import 'package:flutter/material.dart';

class PasstextField extends StatefulWidget {
  final String title;
  final TextEditingController? controller;
  final Icon? prefixicon;
  final bool passhidden;
  const PasstextField({
    super.key,
    required this.title,
    this.controller,
    this.prefixicon,
    this.passhidden = true,
  });

  @override
  State<PasstextField> createState() => _PasstextFieldState();
}

class _PasstextFieldState extends State<PasstextField> {
  late bool _passHidden;

  @override
  void initState() {
    super.initState();
    _passHidden = widget.passhidden;
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(5),
      child: TextFormField(
        obscureText: _passHidden,
        controller: widget.controller,
        decoration: InputDecoration(
          floatingLabelBehavior: FloatingLabelBehavior.never,
          floatingLabelStyle: const TextStyle(color: Colors.black),
          labelText: widget.title,
          border: const OutlineInputBorder(),
          prefixIcon: widget.prefixicon,
          suffixIcon: InkWell(
            onTap: () {
              setState(() {
                _passHidden = !_passHidden;
              });
            },
            child: Icon(
              _passHidden ? Icons.visibility : Icons.visibility_off,
            ),
          ),
        ),
      ),
    );
  }
}
