import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:whatsapp_clone/view/auth/Registration/registration_controller.dart';
import '../../../reusable_widgets/custom_button.dart';
import '../../../reusable_widgets/custom_text_field.dart';
import '../../../reusable_widgets/profile_pic_widget.dart';


class Registration extends StatelessWidget {
  Registration({super.key});
  final RegistrationController controller = Get.put(RegistrationController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(color: const Color(0xFF81C784).withOpacity(0.1)),
          ),
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Form(
                key: controller.formKey,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: MediaQuery.of(context).size.height * 0.07),
                      const Text(
                        "Create Account",
                        style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Color(0xFF388E3C)),
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        "Sign up to get started",
                        style: TextStyle(fontSize: 16, color: Color(0xFF388E3C)),
                      ),
                      const SizedBox(height: 30),
                      ProfilePicWidget(
                        onImagePicked: (imageUrl) {
                          controller.setProfilePic(imageUrl);
                        },
                        uploadedProfileUrl: "",
                      ),
                      const SizedBox(height: 20),
                      textFormField(
                        "Enter your name",
                        const Icon(Icons.person, color: Color(0xFF388E3C)),
                        false,
                        keyboard: TextInputType.emailAddress,
                        controller: controller.nameController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Enter your name";
                          }
                          return null;
                        },
                        maxLines: 1,
                      ),
                      const SizedBox(height: 15),
                      textFormField(
                        "Enter your E-mail",
                        const Icon(Icons.email_rounded, color: Color(0xFF388E3C)),
                        false,
                        keyboard: TextInputType.emailAddress,
                        controller: controller.emailController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Enter your email";
                          } else if (!RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$').hasMatch(value)) {
                            return 'Please enter a valid email';
                          }
                          return null;
                        },
                        maxLines: 1,
                      ),
                      const SizedBox(height: 15),
                      textFormField(
                        "Enter about message",
                        const Icon(Icons.account_box_outlined, color: Color(0xFF388E3C)),
                        false,
                        keyboard: TextInputType.text,
                        controller: controller.aboutMessageController,
                        validator: (value) => value!.isEmpty ? "Enter about message" : null,
                        maxLines: 1,
                      ),
                      const SizedBox(height: 15),
                      Obx(() => textFormField(
                        "Create Password",
                        const Icon(Icons.lock, color: Color(0xFF388E3C)),
                        controller.createObscured.value,
                        suffixIcon: IconButton(
                          icon: Icon(
                            controller.createObscured.value ? Icons.visibility_off : Icons.visibility,
                            color: const Color(0xFF388E3C),
                          ),
                          onPressed: controller.toggleCreatePasswordVisibility,
                        ),
                        keyboard: TextInputType.text,
                        controller: controller.passwordController,
                        validator: (value) => value!.isEmpty ? "Create Password" : null,
                        maxLines: 1,
                      )),
                      const SizedBox(height: 15),
                      Obx(() => textFormField(
                        "Confirm Password",
                        const Icon(Icons.lock, color: Color(0xFF388E3C)),
                        controller.confirmObscured.value,
                        suffixIcon: IconButton(
                          icon: Icon(
                            controller.confirmObscured.value ? Icons.visibility_off : Icons.visibility,
                            color: const Color(0xFF388E3C),
                          ),
                          onPressed: controller.toggleConfirmPasswordVisibility,
                        ),
                        keyboard: TextInputType.text,
                        controller: controller.confirmPasswordController,
                        validator: (value) {
                          if (value!.isEmpty) return "Confirm Password";
                          if (value != controller.passwordController.text) return "Passwords do not match";
                          return null;
                        },
                        maxLines: 1,
                      )),
                      const SizedBox(height: 30),
                      Obx(() => controller.isLoading.value
                          ? const Center(child: CircularProgressIndicator())
                          : CustomButton(
                        onPressed: controller.registerUser,
                        text: "CREATE ACCOUNT",
                      )),
                      const SizedBox(height: 10),
                      Center(
                        child: TextButton(
                          onPressed: () {
                            Get.back();
                          },
                          child: const Text(
                            "Already have an account? Login",
                            style: TextStyle(color: Color(0xFF388E3C)),
                          ),
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
