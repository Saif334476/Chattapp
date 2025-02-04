import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:home_automation/reusables/profile_pic_widget.dart';
import 'package:home_automation/reusables/reusables.dart';
import 'package:image_picker/image_picker.dart';

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
        backgroundColor: Colors.blueGrey,
        automaticallyImplyLeading: false,
        title: const Text(
          "Registration",
          style: TextStyle(fontWeight: FontWeight.w900, color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        child: Stack(children: [
          Padding(
            padding: EdgeInsets.only(
                top: MediaQuery.of(context).size.height * 0.02,
                left: 20,
                right: 20),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  ProfilePicWidget(
                    onImagePicked: (imageUrl) {
                      setState(() {
                        profilePicFile = imageUrl;
                      });
                    },
                    uploadedProfileUrl: "",
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.02,
                    ),
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
                      text: Text(
                        "CREATE ACCOUNT",
                        style: TextStyle(
                            fontWeight: FontWeight.w900, color: Colors.white),
                      ),
                      onPressed: () {}),
                  SizedBox(
                    height: 20,
                  ),
                  container("assets/google_icon.webp", "Continue with Google"),
                  SizedBox(height: 10,),
                  container("assets/apple_icon.webp", "Continue with Apple"),



                ],
              ),
            ),
          ),
        ]),
      ),
    );
  }

  Widget container(String icon,String text){
    return   Container(
      height: MediaQuery.sizeOf(context).height*0.08,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.blueGrey, Colors.black],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(10)
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          SizedBox(
            height: 50,
            width: 50,
            child: Image.asset(icon),
          ),
          Text(text,style: TextStyle(color: Colors.white,fontWeight: FontWeight.w900),)
        ],
      ),
    );
  }



}
