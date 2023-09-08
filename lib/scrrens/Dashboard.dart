import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'SideBar.dart';


class Dashboard extends StatefulWidget {

  @override
  State<Dashboard> createState() => _MyDashboard();
}

class _MyDashboard extends State<Dashboard> {
  var box = Hive.box("database1");
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavBar(),
      appBar: AppBar(
        title: const Text('Dashboard'),
      ),
      body: Center(
        child: Text(
          'Dashboard',
          textAlign: TextAlign.center,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 20),
        )
      ),
    );
  }
}
