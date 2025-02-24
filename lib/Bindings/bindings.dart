import 'package:whatsapp_clone/Controllers/contact_list_controller.dart';
import 'package:get/get.dart';
import 'package:whatsapp_clone/Controllers/group.dart';


class InitialBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(ContactListController());
    Get.put(GroupListController());
  }
}

