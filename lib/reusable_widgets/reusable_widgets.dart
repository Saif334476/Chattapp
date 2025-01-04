import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
TextFormField textFormField(
    String text,
    Widget widgetLeading,
    bool obscuredText, {
      required TextInputType keyboard,
      required TextEditingController controller,
      required String? Function(String?) validator,
      Widget? suffixIcon,
      Function(String)? onChanged,
      int? maxLines
    }) {
  return TextFormField(
    minLines: 1,
    maxLines: maxLines,
    onChanged: onChanged,
    obscureText: obscuredText,
    keyboardType: keyboard,
    decoration: InputDecoration(
      errorStyle: const TextStyle(color: Colors.red),
      errorBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.red),
        borderRadius: BorderRadius.circular(15),
      ),
      border: OutlineInputBorder(
        borderSide: const BorderSide(color:Color(0xff00112B)),
        borderRadius: BorderRadius.circular(15),
      ),
      labelText: text,
      suffixIcon: suffixIcon,
      prefixIcon: widgetLeading,
    ),
    validator: validator,
    controller: controller,
  );
}
