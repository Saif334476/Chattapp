import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:whatsapp_clone/view/auth/registration.dart';
import '../home/home.dart';
import '../home/settings_view/password_reset_view.dart';
import '../../reusable_widgets/reusable_widgets.dart';
import 'package:whatsapp_clone/Controllers/contact_list_controller.dart';
import 'package:get/get.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  Future<void> handleLogin(String? userEmail, String? uid) async {
    ContactListController controller = Get.find<ContactListController>();
    controller.userEmail = userEmail!;
    controller.uid = uid!;
    await controller.getContact(uid!);
    await controller.getChats(userEmail!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(children: [
      ClipPath(
        clipper: CustomClipperDesign(),
        child: Container(
          height: 300,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xff1A2941), Color(0xff00112B)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),
      SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
              padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.15,
                  right: 20,
                  left: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "Chatapp",
                    style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.w900,
                      color: Colors.white,
                      fontFamily: "Courier",
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * 0.15),
                    child: TextFormField(
                      controller: _emailController,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.email),
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
                        prefixIcon: Icon(Icons.password),
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
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.035,
                  ),
                 textButton(
                          text:  _isLoading
                              ? 
                          Row(mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                            Text("Logging In... ", style: const TextStyle(fontWeight: FontWeight.w900,color: Colors.white,fontSize: 12),),
                            const SizedBox(
                              height: 25,
                              width: 25,
                              child: CupertinoActivityIndicator(
                                color: Colors.white,
                              ))])
                              :Text( "LOGIN", style: const TextStyle(fontWeight: FontWeight.w900,color: Colors.white,fontSize: 17),),
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              setState(() {
                                _isLoading=true;
                              });
                              FirebaseAuth.instance
                                  .signInWithEmailAndPassword(
                                email: _emailController.text,
                                password: _passwordController.text,
                              )
                                  .then((userCredential) {
                                handleLogin(
                                    FirebaseAuth.instance.currentUser?.email,
                                    FirebaseAuth.instance.currentUser?.uid);
                                   setState(() {
                                     _isLoading=false;
                                   });
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const NHomePage()));
                              }).catchError((error) {
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) =>
                                        AlertDialog(
                                          title: Column(
                                            children: [
                                              Text(
                                                error.toString(),
                                                style: const TextStyle(
                                                    fontSize: 14),
                                              ),
                                              CupertinoButton(
                                                  color:
                                                      const Color(0xff00112B),
                                                  child: const Text(
                                                    "OK",
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w900,
                                                        color: Colors.white,
                                                        fontSize: 16),
                                                  ),
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  })
                                            ],
                                          ),
                                          backgroundColor: Colors.white,
                                        ));
                              });
                            }
                          }),
                  SizedBox(
                    height: 5,
                  ),
                  textButton(
                      text:Text( "REGISTER", style: const TextStyle(fontWeight: FontWeight.w900,color: Colors.white,fontSize: 17),),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Registration()));
                      }),
                ],
              )),
        ),
      ),
    ]));
  }
}

class CustomClipperDesign extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height * 0.75);
    path.quadraticBezierTo(
        size.width * 0.5, size.height, size.width, size.height * 0.75);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
