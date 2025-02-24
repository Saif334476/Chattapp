import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:whatsapp_clone/Controllers/contact_list_controller.dart';
import 'package:whatsapp_clone/view/auth/registration.dart';
import '../../animated.dart';
import '../../reusable_widgets/custom_button.dart';
import '../../reusable_widgets/custom_text_field.dart';
import '../../reusable_widgets/reusable_widgets.dart';
import '../nav_bar/home.dart';
import '../nav_bar/settings_view/password_reset_view.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isObscured = true;
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  Future<void> handleLogin(String? userEmail, String? uid) async {
    ContactListController controller = Get.find<ContactListController>();
    controller.userEmail = userEmail!;
    controller.uid = uid!;
    await controller.getContact(uid);
    await controller.getChats(userEmail);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          // Gradient Background
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

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min, // Centered content
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.1,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Image.asset(
                              "assets/chatn.png", // Replace with your logo
                              height: 100,
                              width: 130,
                              color: Colors.white,
                            ),
                            SizedBox(height: 10),
                            BouncingDots(),
                          ],
                        ),
                        Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                width: 2, // Width of the divider
                                height: 100, // Adjust the height as needed
                                color: Colors.white
                                    .withOpacity(0.5), // Semi-transparent white
                              ),
                            ),
                          ],
                        ),
                        Flexible(
                          child: Text(
                            "Beyond Messages, We Build Connections",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                            ),
                            textAlign: TextAlign.center,
                            softWrap: true, // Allow text wrapping
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 30),

                    // Welcome Text
                    Text(
                      "Welcome Back!",
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      "Login to continue",
                      style: TextStyle(fontSize: 16, color: Colors.white70),
                    ),
                    SizedBox(height: 40),
                    textFormField(
                      "Email Address",
                      Icon(Icons.email_rounded, color: Colors.white),
                      false,
                      keyboard: TextInputType.emailAddress,
                      controller: _emailController,
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
                      "Password",
                      Icon(Icons.lock, color: Colors.white),
                      _isObscured,
                      suffixIcon: IconButton(
                        icon: Icon(
                          _isObscured ? Icons.visibility_off : Icons.visibility,
                          color: Colors.white70,
                        ),
                        onPressed: () {
                          setState(() {
                            _isObscured = !_isObscured;
                          });
                        },
                      ),
                      keyboard: TextInputType.text,
                      controller: _passwordController,
                      validator: (value) =>
                          value!.isEmpty ? "Enter your password" : null,
                      maxLines: 1,
                    ),

                    SizedBox(height: 10),

                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const PasswordResetView(),
                            ),
                          );
                        },
                        child: Text("Forgot Password?",
                            style: TextStyle(color: Colors.white70)),
                      ),
                    ),
                    SizedBox(height: 30),

                    CustomButton(
                      text: "LOGIN",
                      isLoading: _isLoading,
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          setState(() => _isLoading = true);
                          FirebaseAuth.instance
                              .signInWithEmailAndPassword(
                            email: _emailController.text,
                            password: _passwordController.text,
                          )
                              .then((userCredential) {
                            handleLogin(
                              FirebaseAuth.instance.currentUser?.email,
                              FirebaseAuth.instance.currentUser?.uid,
                            );
                            setState(() => _isLoading = false);
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const NHomePage(),
                              ),
                            );
                          }).catchError((error) {
                            setState(() => _isLoading = false);
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text(error.toString())),
                            );
                          });
                        }
                      },
                    ),
                    SizedBox(height: 10),

                    Center(
                      child: TextButton(
                        onPressed: () {
                          Get.to(Registration(),
                              transition: Transition.rightToLeft,
                              duration: Duration(milliseconds: 300));
                        },
                        child: Text(
                          "Don't have an account? Sign up",
                          style: TextStyle(color: Colors.white70),
                        ),
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
