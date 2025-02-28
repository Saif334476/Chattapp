import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:whatsapp_clone/Controllers/contact_list_controller.dart';
import 'package:whatsapp_clone/view/auth/registration.dart';
import '../../reusable_widgets/custom_button.dart';
import '../../reusable_widgets/custom_text_field.dart';
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
            decoration:
                BoxDecoration(color: Color(0xFF81C784).withOpacity(0.1)),
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
                              "assets/chatn.png",
                              height: 100,
                              width: 130,
                              color: Color(0xFF81C784),
                            ),
                            SizedBox(height: 10),
                          ],
                        ),

                        // Divider with spacing
                        SizedBox(width: 16), // Adjust width for spacing
                        Container(
                          width: 2, // Width of the divider
                          height: 80, // Adjust height to align with content
                          color: Color(0xFF388E3C).withOpacity(0.5),
                        ),
                        SizedBox(width: 16), // Adjust spacing after divider
                        Expanded(
                          child: Text(
                            "Beyond Messages, We Build Connections",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                              color: Color(0xFF388E3C).withOpacity(0.9),
                            ),
                            textAlign: TextAlign.center,
                            softWrap: true,
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
                        color: Color(0xFF388E3C),
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      "Login to continue",
                      style: TextStyle(
                          fontSize: 16,
                          color: Color(0xFF388E3C).withOpacity(0.8)),
                    ),
                    SizedBox(height: 40),
                    textFormField(
                      "E-mail",
                      Icon(Icons.email_rounded, color: Color(0xFF388E3C)),
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
                      Icon(Icons.lock, color: Color(0xFF388E3C)),
                      _isObscured,
                      suffixIcon: IconButton(
                        icon: Icon(
                          _isObscured ? Icons.visibility_off : Icons.visibility,
                          color: Color(0xFF388E3C),
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
                          Get.to(PasswordResetView(),
                              transition: Transition.rightToLeft,
                              duration: Duration(milliseconds: 750));
                        },
                        child: Text("Forgot Password?",
                            style: TextStyle(color: Color(0xFF388E3C))),
                      ),
                    ),
                    SizedBox(height: 25),

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
                            Get.off(NHomePage(),
                                transition: Transition.downToUp,
                                duration: Duration(milliseconds: 700));
                          }).catchError((error) {
                            setState(() => _isLoading = false);
                            Get.snackbar(
                              "Error",
                              error.toString(),
                              snackPosition: SnackPosition.BOTTOM,
                              backgroundColor: Colors.red,
                              colorText: Colors.white,
                              margin: EdgeInsets.only(
                                  bottom: 20, left: 10, right: 10),
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
                              transition: Transition.fadeIn,
                              duration: Duration(milliseconds: 550),
                              curve: Curves.easeInOut);
                        },
                        child: Text(
                          "Don't have an account? Sign up",
                          style: TextStyle(color: Color(0xFF388E3C)),
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
