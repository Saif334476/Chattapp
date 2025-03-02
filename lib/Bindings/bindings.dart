import 'package:whatsapp_clone/Controllers/contact_list_controller.dart';
import 'package:get/get.dart';
import 'package:whatsapp_clone/Controllers/group.dart';

import '../theme/theme_controller.dart';


class InitialBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(ThemeController());
    Get.put(ContactListController());
    Get.put(GroupListController());
  }
}

