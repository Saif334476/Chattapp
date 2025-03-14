import "package:flutter/material.dart";

TextFormField textFormField(
    String text, Widget widgetLeading, bool obscuredText,
    {required TextInputType keyboard,
    required TextEditingController controller,
    required String? Function(String?) validator,
    Widget? suffixIcon,
    Function(String)? onChanged,
    int? maxLines}) {
  return TextFormField(
    enableSuggestions: true,
    style: TextStyle(color: Colors.white),
    minLines: 1,
    maxLines: maxLines,
    onChanged: onChanged,
    obscureText: obscuredText,
    keyboardType: keyboard,
    decoration: InputDecoration(
    focusColor: Colors.blueGrey,
//      fillColor: Colors.white,
      errorStyle: const TextStyle(color: Colors.red),
      errorBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.red),
        borderRadius: BorderRadius.circular(15),
      ),
      border: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.blueGrey),
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

textButton({
  required Widget text,
  required VoidCallback onPressed,
}) {
  return Container(
      width: double.infinity,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),gradient: LinearGradient(
        colors: [Colors.black, Colors.blueGrey],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),),
      child: TextButton(
        onPressed: onPressed,
        child: text,
      ));
}
