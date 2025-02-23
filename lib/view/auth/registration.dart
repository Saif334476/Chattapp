import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:image_picker/image_picker.dart';
import 'package:whatsapp_clone/view/auth/login.dart';
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
  final TextEditingController _confirmPasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  File? profilePicFile;

  InputDecoration _inputDecoration(String label, IconData icon) {
    return InputDecoration(
      labelText: label,
      prefixIcon: Icon(icon, color: Colors.white),
      filled: true,
      fillColor: Colors.white.withOpacity(0.2),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
      labelStyle: TextStyle(color: Colors.white70),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF4CAF50), Color(0xFF81C784)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
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
                      TextFormField(
                        controller: _nameController,
                        decoration: _inputDecoration("Enter your name", Icons.person),
                        style: TextStyle(color: Colors.white),
                        validator: (value) => value!.isEmpty ? "Enter your name" : null,
                      ),
                      SizedBox(height: 15),
                      TextFormField(
                        controller: _emailController,
                        decoration: _inputDecoration("Enter your E-mail", Icons.email),
                        style: TextStyle(color: Colors.white),
                        validator: (value) =>
                        value!.isEmpty ? "Enter your e-mail" : null,
                      ),
                      SizedBox(height: 15),
                      TextFormField(
                        controller: _passwordController,
                        obscureText: true,
                        decoration: _inputDecoration("Create Password", Icons.lock),
                        style: TextStyle(color: Colors.white),
                        validator: (value) => value!.isEmpty ? "Create Password" : null,
                      ),
                      SizedBox(height: 15),
                      TextFormField(
                        controller: _confirmPasswordController,
                        obscureText: true,
                        decoration: _inputDecoration("Confirm Password", Icons.lock),
                        style: TextStyle(color: Colors.white),
                        validator: (value) {
                          if (value!.isEmpty) return "Confirm Password";
                          if (value != _passwordController.text) return "Passwords do not match";
                          return null;
                        },
                      ),
                      SizedBox(height: 30),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: Colors.green,
                          padding: EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        onPressed: _isLoading
                            ? null
                            : () async {
                          if (_formKey.currentState!.validate()) {
                            setState(() => _isLoading = true);
                            try {
                              final credentials = await FirebaseAuth.instance.createUserWithEmailAndPassword(
                                email: _emailController.text,
                                password: _confirmPasswordController.text,
                              );

                              await FirebaseFirestore.instance.collection('Users').doc(credentials.user?.uid).set({
                                'name': _nameController.text,
                                'email': _emailController.text,
                              }, SetOptions(merge: true));

                              setState(() => _isLoading = false);

                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(builder: (context) => const LoginView()),
                              );
                            } catch (error) {
                              setState(() => _isLoading = false);
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(error.toString())));
                            }
                          }
                        },
                        child: _isLoading
                            ? CircularProgressIndicator(color: Colors.green)
                            : Text("CREATE ACCOUNT", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                      ),
                      SizedBox(height: 10),
                      Center(
                        child: TextButton(
                          onPressed: () {
                        Get.back();
                          },
                          child: Text("Already have an account? Login", style: TextStyle(color: Colors.white70)),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
