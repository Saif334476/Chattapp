import 'package:flutter/material.dart';

TextFormField textFormField(
    String text, Widget widgetLeading, bool obscuredText,
    {required TextInputType keyboard,
      required TextEditingController controller,
      required String? Function(String?) validator,
      Widget? suffixIcon,
      Function(String)? onChanged,
      int? maxLines,}) {
  return TextFormField(
    enableSuggestions: true,
    // style: TextStyle(color: Colors.black),
    minLines: 1,

    onChanged: onChanged,
    obscureText: obscuredText,
    keyboardType: keyboard,
    decoration: InputDecoration(

      labelStyle: TextStyle(color: Color(0xFF388E3C).withOpacity(0.8)),
      filled: true,
      fillColor: Colors.white.withOpacity(0.7),
//      fillColor: Colors.white,
//       errorStyle: const TextStyle(color: Colors.red),
//       errorBorder: OutlineInputBorder(
//         borderSide: const BorderSide(color: Colors.red),
//         borderRadius: BorderRadius.circular(15),
//       ),
      border: OutlineInputBorder(
        // borderSide: const BorderSide(color: Color(0xff00112B)),
        borderRadius: BorderRadius.circular(5),
        // borderSide: BorderSide.none,
      ),
      labelText: text,
      suffixIcon: suffixIcon,
      prefixIcon: widgetLeading,
    ),
    validator: validator,
    controller: controller,
  );
}