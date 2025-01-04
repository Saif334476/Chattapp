import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:whatsapp_clone/view/registration/registration.dart';
import '../home/home.dart';
import '../home/settings_view/password_reset_view.dart';


class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(color: Colors.white60),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.only(top: 80.0, right: 20, left: 20),
              child: Column(
                children: [
                  SizedBox(
                      height: 150,
                      width: 150,
                      child: Image.asset("assets/whatsapp.webp"
                      )),
                  const Padding(
                    padding: EdgeInsets.only(top: 50.0),
                    child: Text(
                      "LOG IN or REGISTER",
                      style:
                          TextStyle(fontSize: 28, fontWeight: FontWeight.w900),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: TextFormField(
                      controller: _emailController,
                      decoration: InputDecoration(
                        label: const Text("Enter Your Email"),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        errorStyle: const TextStyle(color: Colors.red),
                        errorBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.red),
                        ),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Enter Your E-mail";
                        } else if (!RegExp(
                                r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
                            .hasMatch(value!)) {
                          return 'Please enter a valid email address';
                        }
                        return null;
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 15.0),
                    child: TextFormField(
                      controller: _passwordController,
                      decoration: InputDecoration(
                        label: const Text("Enter Your Password"),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        errorStyle: const TextStyle(color: Colors.red),
                        errorBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.red),
                        ),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Enter your Password";
                        }
                        return null;
                      },
                    ),
                  ),
                  Row(
                    children: [
                      const Text("Forgotten Password,"),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const PasswordResetView()));
                        },
                        child: const Text(
                          "Reset your Password!",
                          style: TextStyle(color: Colors.blue),
                        ),
                      )
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 30.0),
                    child: CupertinoButton(
                        color: const Color(0xff4ECB5C),
                        child: const Text(
                          "LOG IN",
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.w900),
                        ),
                        onPressed: ()  {
                          if (_formKey.currentState!.validate()) {

                               FirebaseAuth.instance
                                  .signInWithEmailAndPassword(
                                email: _emailController.text,
                                password: _passwordController.text,
                              ).then((userCredential) {
                                 Navigator.pushReplacement(
                                     context,
                                     MaterialPageRoute(
                                         builder: (context) => const NHomePage()));
                               }).catchError((error) {
                                 showDialog(
                                     context: context,
                                     builder: (BuildContext context) =>
                                         AlertDialog(
                                           title: Column(
                                             children: [
                                               Text(
                                                 error.toString(),style: const TextStyle(fontSize: 14),
                                               ),
                                               CupertinoButton(
                                                   color: const Color(0xff4ECB5C),
                                                   child: const Text(
                                                     "OK",
                                                     style: TextStyle(
                                                         fontWeight:
                                                         FontWeight.w900,
                                                         color: Colors.white,fontSize: 16),
                                                   ),
                                                   onPressed: () {Navigator.pop(context);})
                                             ],
                                           ),
                                           backgroundColor: Colors.white,
                                         ));
                               });
                            }

                          }
                        ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: CupertinoButton(
                        color: const Color(0xff4ECB5C),
                        child: const Text(
                          "REGISTER",
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.w900),
                        ),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const Registration()));
                        }),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
