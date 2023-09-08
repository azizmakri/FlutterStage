
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'SideBar.dart';


class HomePage extends StatefulWidget {

  @override
  State<HomePage> createState() => _MyHomePage();
}

class _MyHomePage extends State<HomePage> {
  var box = Hive.box("database1");
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavBar(),
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: Center(
        child:Text(
          "hello, "+box.get('role')[0].toString(),
          textAlign: TextAlign.center,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 50,color: Colors.blue),
        )
      ),
    );
  }
}
