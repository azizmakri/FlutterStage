import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import '../routes/routes.dart';


loginUser(String username,String password,BuildContext context) async {
  var box1 = Hive.box("database1");

  try{
    Response response = await http.post(Uri.parse('http://localhost:8080/api/auth/signin'),
      headers: {
        "Access-Control-Allow-Origin": "*", // Required for CORS support to work
        "Access-Control-Allow-Headers": "Origin,Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token,locale",
        "Access-Control-Allow-Methods": "POST, OPTIONS"
      },
      body: {
        'username': username,
        'password':password
      },
    );
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body.toString());
      print('Login successfully');
      var myToken= data['accessToken'];
      //box1.clear();
      box1.put('token', myToken);
      box1.put('role',data['roles']);
      box1.put('mail',data['email']);
      box1.put('user',data['username']);

      print(data);
      Get.toNamed(Home);
    }else{
      print("erreur");
    }
  }catch(e){
    return (e.toString());
  }
}