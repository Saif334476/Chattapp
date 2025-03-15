import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:whatsapp_clone/view/auth/login.dart';
import 'package:whatsapp_clone/reusable_widgets/profile_pic_widget.dart';
import 'package:whatsapp_clone/Controllers/contact_list_controller.dart';
import 'package:whatsapp_clone/view/nav_bar/settings_view/password_reset_view.dart';
import 'package:shimmer/shimmer.dart';
import '../../../theme/theme_controller.dart';
import 'controller.dart';

class SettingsView extends StatelessWidget {
  final ThemeController themeController = Get.find();
  final SettingsController settingsController = Get.put(SettingsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.theme.scaffoldBackgroundColor,
      body: Column(
        children: [
          SizedBox(height: MediaQuery.of(context).size.height * 0.06),
          _buildProfileSection(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Row(
              children: [
                Expanded(child: Divider(color: context.theme.dividerColor)),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10),
                  child: Text("MB Chat",
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: context.theme.primaryColor)),
                ),
                Expanded(child: Divider(color: context.theme.dividerColor)),
              ],
            ),
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              children: [
                _buildThemeToggle(),
                SizedBox(height: 12),
                _buildSettingsTile(
                  icon: Icons.key,
                  title: "Account",
                  subtitle: "Reset password etc.",
                  onTap: () => Get.to(() => const PasswordResetView()),
                ),
                _buildSettingsTile(
                  icon: Icons.lock_outline,
                  title: "Privacy",
                  subtitle: "Block contacts, disappearing messages",
                ),
                _buildSettingsTile(
                  icon: Icons.chat_outlined,
                  title: "Chat",
                  subtitle: "Theme, wallpaper, chat history",
                ),
                _buildSettingsTile(
                  icon: Icons.notifications,
                  title: "Notifications",
                  subtitle: "Message, group & call tones",
                ),
                _buildSettingsTile(
                  icon: Icons.help,
                  title: "Help",
                  subtitle: "Contact Us, Privacy Policy",
                ),
                _buildSettingsTile(
                  icon: Icons.logout_outlined,
                  title: "Logout",
                  subtitle: "Sign out of your account",
                  onTap: () {
                    try {
                      ContactListController controller = Get.find<ContactListController>();
                      controller.handleLogout();
                      Get.offAll(() => const LoginView());
                    } catch (e) {
                      print('Error signing out: $e');
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileSection() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        gradient: themeController.isDarkMode.value
            ? null
            : LinearGradient(
          colors: [Colors.greenAccent.shade700, Colors.greenAccent.shade400],
        ),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.1), blurRadius: 10, offset: const Offset(0, 5)),
        ],
      ),
      child: Obx(() {
        return settingsController.isLoading.value
            ? Column(
          children: [
            _buildShimmerCircle(),
            const SizedBox(height: 20),
            _buildShimmerText(width: 120, height: 20),
            const SizedBox(height: 10),
            _buildShimmerText(width: 180, height: 20),
          ],
        )
            : Column(
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                ProfilePicWidget(
                  uploadedProfileUrl: settingsController.profilePicUrl.value,
                  onImagePicked: (File file) {
                    settingsController.uploadProfilePic(file);
                  },
                ),
              ],
            ),
            const SizedBox(height: 10),
            Text(
              settingsController.userName.value,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Get.theme.textTheme.bodyLarge?.color),
            ),
            Text(
              settingsController.statusMessage.value,
              style: TextStyle(color: Get.theme.textTheme.bodySmall?.color),
            ),
          ],
        );
      }),
    );
  }

  Widget _buildSettingsTile({required IconData icon, required String title, required String subtitle, VoidCallback? onTap}) {
    return Column(
      children: [
        InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(10),
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Get.theme.cardColor,
            ),
            child: Row(
              children: [
                Icon(icon, color: Get.theme.primaryColor, size: 28),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(title, style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16, color: Get.theme.textTheme.bodyLarge?.color)),
                      Text(subtitle, style: TextStyle(color: Get.theme.textTheme.bodySmall?.color, fontSize: 14)),
                    ],
                  ),
                ),
                const Icon(Icons.arrow_forward_ios, size: 18, color: Colors.grey),
              ],
            ),
          ),
        ),
        const SizedBox(height: 8),
      ],
    );
  }

  Widget _buildThemeToggle() {
    return ListTile(
      leading: Icon(Icons.brightness_4, color: Get.theme.primaryColor),
      title: const Text("Dark Mode"),
      trailing: Obx(() => Switch(
        value: themeController.isDarkMode.value,
        onChanged: (value) => themeController.toggleTheme(),
      )),
    );
  }

  Widget _buildShimmerCircle() => Shimmer.fromColors(
    baseColor: Colors.grey[300]!,
    highlightColor: Colors.grey[100]!,
    child: Container(width: 100, height: 100, decoration: const BoxDecoration(shape: BoxShape.circle, color: Colors.white)),
  );

  Widget _buildShimmerText({required double width, required double height}) => Shimmer.fromColors(
    baseColor: Colors.grey[300]!,
    highlightColor: Colors.grey[100]!,
    child: Container(width: width, height: height, decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(5))),
  );
}
