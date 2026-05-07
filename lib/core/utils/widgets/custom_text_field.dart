import 'package:flutter/material.dart';

typedef MyValidator = String? Function(String?);

class CustomTextFormField extends StatefulWidget {
  final TextInputType keyboardType;
  final String? hintText;
  // Note: obscureText must be mutable for the password toggle to work
  bool obscureText;
  final bool isPassword;
  final TextEditingController controller;
  final MyValidator validator;

  CustomTextFormField({
    required this.controller,
    required this.validator,
    this.hintText = 'Enter text here',
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    this.isPassword = false,
    super.key,
  });

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      validator: widget.validator,
      style: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w400,
        color: Colors.black,
        overflow: TextOverflow.ellipsis,
      ),
      obscureText: widget.obscureText,

      decoration: InputDecoration(
        hintText: widget.hintText,
        hintStyle: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w400,
          color: Colors.grey,
          overflow: TextOverflow.ellipsis,
        ),
        suffixIcon: widget.isPassword
            ? IconButton(
                icon: Icon(
                  widget.obscureText ? Icons.visibility_off : Icons.visibility,
                  color: const Color(0xff454A4F),
                  size: 24,
                ),
              onPressed: () {
                  // Toggling the obscureText value requires setState to redraw
                  setState(() {
                    widget.obscureText = !widget.obscureText;
                  });
                },
              )
            : null,

        contentPadding: const EdgeInsets.all(15),
        enabledBorder: _outlineInputBorder(
          color: const Color(0xffBABABA),
          radius: 10,
          width: 1,
        ),
        focusedBorder: _outlineInputBorder(
          color: const Color(0xff5F33E1),
          radius: 10,
          width: 1,
        ),
        errorBorder: _outlineInputBorder(
          color: Colors.red,
          radius: 10,
          width: 1,
        ),
        focusedErrorBorder: _outlineInputBorder(
          color: Colors.red,
          radius: 10,
          width: 1,
        ),
      ),
      keyboardType: widget.keyboardType,
    );
  }

  OutlineInputBorder _outlineInputBorder({
    required double radius,
    required Color color,
    required double width,
  }) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(radius),
      borderSide: BorderSide(color: color, width: width),
    );
  }
}