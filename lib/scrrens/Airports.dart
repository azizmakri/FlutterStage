import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'SideBar.dart';


class Airports extends StatefulWidget {

  @override
  State<Airports> createState() => _MyAirports();
}

class _MyAirports extends State<Airports> {
  var box = Hive.box("database1");
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavBar(),
      appBar: AppBar(
        title: const Text('Airports'),
      ),
      body: Center(
          child: Text(
            'Airports',
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 20),
          )
      ),
    );
  }
}
