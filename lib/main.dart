import 'package:flutter/material.dart';
import 'package:front2/controllers/service.dart';
import 'package:front2/routes/routes.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get/get.dart';



import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'controllers/endpoint.dart';


void main() async{
  await Hive.initFlutter();
  //init hive
  await Hive.openBox('database1');
  await Hive.openBox('healthCheck');
  await Hive.openBox('statuscheck');
  fetchServices();
  displayServices();

  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Login Page',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: login,
      getPages:routes,
    );
  }}






