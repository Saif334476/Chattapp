import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
//import 'package:image_picker/image_picker.dart';
import 'package:whatsapp_clone/view/login/login.dart';
import '../../reusable_widgets/profile_pic_widget.dart';
import '../../reusable_widgets/reusable_widgets.dart';

class Registration extends StatefulWidget {
  const Registration({super.key});

  @override
  State<Registration> createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final ImagePicker _picker = ImagePicker();
  File? profilePicFile;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff00112B),
        automaticallyImplyLeading: false,
        title: const Text(
          "Registration",
          style: TextStyle(fontWeight: FontWeight.w900, color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        child: Stack(children: [
          // Padding(
          //   padding:  EdgeInsets.only(top:MediaQuery.of(context).size.height*0.25),
          //   child: Image.asset(
          //     "assets/whatsapp.webp",
          //     color: const Color.fromRGBO(255, 255, 255,
          //         0.45),
          //     colorBlendMode: BlendMode.modulate,
          //   ),
          // ),
          Padding(
            padding:  EdgeInsets.only(top:MediaQuery.of(context).size.height*0.05, left: 20, right: 20),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  ProfilePicWidget(
                    onImagePicked: (imageUrl) {
                      setState(() {
                        profilePicFile=imageUrl;
                      });
                    },uploadedProfileUrl: "",
                  ),
                  Padding(
                    padding:  EdgeInsets.only(top:MediaQuery.of(context).size.height*0.02, ),
                    child: textFormField(
                        "Enter your name", const Icon(Icons.person), false,
                        keyboard: TextInputType.text,
                        controller: _nameController, validator: (value) {
                      if (value!.isEmpty) {
                        return 'Enter your name';
                      }
                      return null;
                    }),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  textFormField("Enter your E-mail", Icon(Icons.email), false,
                      keyboard: TextInputType.text,
                      controller: _emailController, validator: (value) {
                    if (value!.isEmpty) {
                      return 'Enter your e-mail';
                    }
                    return null;
                  }),
                  const SizedBox(
                    height: 10,
                  ),
                  textFormField("Create Password", Icon(Icons.password), false,
                      keyboard: TextInputType.text,
                      controller: _passwordController, validator: (value) {
                    if (value!.isEmpty) {
                      return 'Create Password';
                    }
                    return null;
                  }),
                  const SizedBox(
                    height: 10,
                  ),
                  textFormField(
                    "Confirm Password",
                    const Icon(Icons.password),
                    false,
                    keyboard: TextInputType.text,
                    controller: _confirmPasswordController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Confirm Password';
                      } else if (value != _passwordController.text) {
                        return 'Passwords do not match';
                      } else {
                        return null;
                      }
                    },
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  textButton(
                      text:Text( "CREATE ACCOUNT",style: TextStyle(fontWeight: FontWeight.w900,color: Colors.white),),
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          final credentials = await FirebaseAuth.instance
                              .createUserWithEmailAndPassword(
                            email: _emailController.text,
                            password: _confirmPasswordController.text,
                          );
                          await FirebaseFirestore.instance
                              .collection('Whatsapp Clone')
                              .doc("Data")
                              .collection("Users")
                              .doc(credentials.user?.uid)
                              .set({
                            'name': _nameController.text,
                            'isComplete': false,
                            'email': _emailController.text,
                          }, SetOptions(merge: true));

                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text('Success'),
                                content:
                                    const Text('Account successfully created!'),
                                actions: [
                                  TextButton(
                                    child: const Text('OK'),
                                    onPressed: () {
                                      Navigator.of(context).pushReplacement(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const LoginView()));
                                    },
                                  ),
                                ],
                              );
                            },
                          );
                        }
                      })
                ],
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
