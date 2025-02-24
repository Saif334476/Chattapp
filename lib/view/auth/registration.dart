import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:whatsapp_clone/reusable_widgets/reusable_widgets.dart';
import 'package:whatsapp_clone/view/auth/login.dart';
import '../../reusable_widgets/custom_button.dart';
import '../../reusable_widgets/custom_text_field.dart';
import '../../reusable_widgets/profile_pic_widget.dart';

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
  bool _confirmObscured = true;
  bool _createObscured = true;
  bool _isLoading = false;
  File? profilePicFile;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xFF1B5E20), // Forest Green
                  Color(0xFF4CAF50), // Leaf Green
                  Color(0xFF81C784),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.07,
                    ),
                    Text(
                      "Create Account",
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      "Sign up to get started",
                      style: TextStyle(fontSize: 16, color: Colors.white70),
                    ),
                    SizedBox(height: 30),
                    ProfilePicWidget(
                      onImagePicked: (imageUrl) {
                        setState(() {
                          profilePicFile = imageUrl;
                        });
                      },
                      uploadedProfileUrl: "",
                    ),
                    SizedBox(height: 20),
                    textFormField(
                      "Enter your name",
                      Icon(Icons.person, color: Colors.white),
                      false,
                      keyboard: TextInputType.emailAddress,
                      controller: _nameController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Enter your email";
                        } else if (!RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$')
                            .hasMatch(value)) {
                          return 'Please enter a valid email';
                        }
                        return null;
                      },
                      maxLines: 1,
                    ),

                    SizedBox(height: 15),
                    textFormField(
                      "Enter your E-mail",
                      Icon(Icons.email_rounded, color: Colors.white),
                      false,
                      keyboard: TextInputType.emailAddress,
                      controller: _emailController,
                      validator: (value) =>
                          value!.isEmpty ? "Enter your e-mail" : null,
                      maxLines: 1,
                    ),
                    SizedBox(height: 15),
                    textFormField(
                      "Create Password",
                      Icon(Icons.lock, color: Colors.white),
                      _createObscured,
                      suffixIcon: IconButton(
                        icon: Icon(
                          _createObscured
                              ? Icons.visibility_off
                              : Icons.visibility,
                          color: Colors.white70,
                        ),
                        onPressed: () {
                          setState(() {
                            _createObscured = !_createObscured;
                          });
                        },
                      ),
                      keyboard: TextInputType.text,
                      controller: _passwordController,
                      validator: (value) =>
                          value!.isEmpty ? "Create Password" : null,
                      maxLines: 1,
                    ),
                    // TextFormField(
                    //   controller: _passwordController,
                    //   obscureText: _createObscured,
                    //   decoration:
                    //       _inputDecoration("Create Password", Icons.lock),
                    //   style: TextStyle(color: Colors.white),
                    //   validator: (value) =>
                    //       value!.isEmpty ? "Create Password" : null,
                    // ),
                    SizedBox(height: 15),
                    textFormField(
                      maxLines: 1,
                      "Create Password",
                      Icon(Icons.lock, color: Colors.white),
                      _confirmObscured,
                      suffixIcon: IconButton(
                        icon: Icon(
                          _confirmObscured
                              ? Icons.visibility_off
                              : Icons.visibility,
                          color: Colors.white70,
                        ),
                        onPressed: () {
                          setState(() {
                            _confirmObscured = !_confirmObscured;
                          });
                        },
                      ),
                      keyboard: TextInputType.text,
                      controller: _passwordController,
                      validator: (value) {
                        if (value!.isEmpty) return "Confirm Password";
                        if (value != _passwordController.text)
                          return "Passwords do not match";
                        return null;
                      },
                    ),
                    // TextFormField(
                    //   controller: _confirmPasswordController,
                    //   obscureText: _confirmObscured,
                    //   decoration:
                    //       _inputDecoration("Confirm Password", Icons.lock),
                    //   style: TextStyle(color: Colors.white),
                    //   validator: (value) {
                    //     if (value!.isEmpty) return "Confirm Password";
                    //     if (value != _passwordController.text)
                    //       return "Passwords do not match";
                    //     return null;
                    //   },
                    // ),
                    SizedBox(height: 30),
                    CustomButton(
                      // style: ElevatedButton.styleFrom(
                      //   backgroundColor: Colors.white,
                      //   foregroundColor: Colors.green,
                      //   padding: EdgeInsets.symmetric(vertical: 14),
                      //   shape: RoundedRectangleBorder(
                      //     borderRadius: BorderRadius.circular(12),
                      //   ),
                      // ),
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          setState(() => _isLoading = true);
                          try {
                            final credentials = await FirebaseAuth.instance
                                .createUserWithEmailAndPassword(
                              email: _emailController.text,
                              password: _confirmPasswordController.text,
                            );

                            await FirebaseFirestore.instance
                                .collection('Users')
                                .doc(credentials.user?.uid)
                                .set({
                              'name': _nameController.text,
                              'email': _emailController.text,
                            }, SetOptions(merge: true));

                            setState(() => _isLoading = false);

                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const LoginView()),
                            );
                          } catch (error) {
                            setState(() => _isLoading = false);
                            ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text(error.toString())));
                          }
                        }
                      },
                      text: "CREATE ACCOUNT",
                    ),
                    SizedBox(height: 10),
                    Center(
                      child: TextButton(
                        onPressed: () {
                          Get.back();
                        },
                        child: Text("Already have an account? Login",
                            style: TextStyle(color: Colors.white70)),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
