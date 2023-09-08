
import 'package:front2/routes/routes.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:hive/hive.dart';

Logout(){
  var box = Hive.box("database1");
  box.clear();
  Get.toNamed(login);

}