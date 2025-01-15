import 'package:whatsapp_clone/Controllers/contact_list_controller.dart';
import 'package:get/get.dart';
import 'package:whatsapp_clone/Controllers/chat_controller.dart';

class InitialBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(ContactListController());
  }
}

