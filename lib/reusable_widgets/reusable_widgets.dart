import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// TextFormField textFormField(
//     String text, Widget widgetLeading, bool obscuredText,
//     {required TextInputType keyboard,
//     required TextEditingController controller,
//     required String? Function(String?) validator,
//     Widget? suffixIcon,
//     Function(String)? onChanged,
//     int? maxLines}) {
//   return TextFormField(
//     enableSuggestions: true,
//    // style: TextStyle(color: Colors.black),
//     minLines: 1,
//     maxLines: maxLines,
//     onChanged: onChanged,
//     obscureText: obscuredText,
//     keyboardType: keyboard,
//     decoration: InputDecoration(
//
//       labelStyle: TextStyle(color: Colors.white70),
//       filled: true,
//       fillColor: Colors.white.withOpacity(0.2),
// //      fillColor: Colors.white,
// //       errorStyle: const TextStyle(color: Colors.red),
// //       errorBorder: OutlineInputBorder(
// //         borderSide: const BorderSide(color: Colors.red),
// //         borderRadius: BorderRadius.circular(15),
// //       ),
//       border: OutlineInputBorder(
//         // borderSide: const BorderSide(color: Color(0xff00112B)),
//         borderRadius: BorderRadius.circular(15),
//        // borderSide: BorderSide.none,
//       ),
//       labelText: text,
//       suffixIcon: suffixIcon,
//       prefixIcon: widgetLeading,
//     ),
//     validator: validator,
//     controller: controller,
//   );
// }

textButton({
  required Widget text,
  required VoidCallback onPressed,
  required BuildContext context,
}) {
  return Container(
      width: double.infinity,

      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Theme.of(context).primaryColor,
      ),
      child: TextButton(
        onPressed: onPressed,
        child: text,
      ));
}

ElevatedButton extButton({
  required Widget text,
  required VoidCallback onPressed,
}) {
  return ElevatedButton(
    onPressed: onPressed,
    style: ElevatedButton.styleFrom(
      elevation: 10,
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    ),
    child: text,
  );
}

Container iconButton({required VoidCallback onPressed, required Widget icon}) {
  return Container(
      //  decoration: BoxDecoration(borderRadius: BorderRadius.circular(100),    color: Color(0xff00112B),),

      child: IconButton(
    onPressed: onPressed,
    icon: icon,
    // splashColor: Colors.black,
    splashRadius: 5,
  ));
}
