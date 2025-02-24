import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:whatsapp_clone/reusable_widgets/reusable_widgets.dart';

import '../../../reusable_widgets/custom_text_field.dart';

class PasswordResetView extends StatefulWidget {
  const PasswordResetView({super.key});

  @override
  State<PasswordResetView> createState() => _PasswordResetViewState();
}

class _PasswordResetViewState extends State<PasswordResetView> {
  final TextEditingController _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          "Password Reset",
          style: TextStyle(fontWeight: FontWeight.w900, color: Colors.white),
        ),
        backgroundColor: const Color(0xff4ECB5C),
        systemOverlayStyle: SystemUiOverlayStyle.light,
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 40, right: 20, left: 20),
        child: Column(
          children: [
            Image.asset("assets/newlock.webp"),
            const Text("Enter your email to send you a password reset link",style: TextStyle(fontWeight: FontWeight.w600),),
            Padding(
              padding: const EdgeInsets.only(top: 25.0),
              child: textFormField("Enter your e-mail",Icon( Icons.email_outlined), false,

                  keyboard: TextInputType.text,
                  controller: _emailController, validator: (value) {
                if (value!.isEmpty) {
                  return "Enter your email";
                }
                return null;
              }),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 30.0),
              child: CupertinoButton(
                color:const Color(0xff4ECB5C) ,
                  onPressed: ()async{
                    try {
                     await  FirebaseAuth.instance.sendPasswordResetEmail(
                        email: _emailController.text.trim(),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Password reset link sent')),
                      );
                      Navigator.pop(context);
                    } on FirebaseException catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Error: $e')),
                      );
                    }
                  },
                  child: const Text(
                    "Send Link",
                    style: TextStyle(
                        fontWeight: FontWeight.w900, color:Colors.white ),
                  )),
            )
          ],
        ),
      ),
    );
  }
}
