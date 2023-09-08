import 'package:flutter/material.dart';
import 'package:front2/scrrens/LoginPage.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:get/get_core/src/get_main.dart';

import '../controllers/logout.dart';
import '../routes/routes.dart';



class NavBar extends StatelessWidget {
  var box = Hive.box("database1");

  @override
  Widget build(BuildContext context) {
    if(!box.isEmpty){
    if(box.get('role')[0].toString()=="ADMIN"){
    return Drawer(
      child: ListView(
        children: [
          UserAccountsDrawerHeader(
            accountName: Text(box.get('user').toString()),
            accountEmail: Text(box.get('mail').toString()),
            currentAccountPicture: CircleAvatar(
              child: ClipOval(
                child: Image.network(
                  'https://oflutter.com/wp-content/uploads/2021/02/girl-profile.png',
                  fit: BoxFit.cover,
                  width: 90,
                  height: 90,
                ),
              ),
            ),
            decoration: BoxDecoration(
              color: Colors.blue,
              image: DecorationImage(
                  fit: BoxFit.fill,
                  image: NetworkImage('https://oflutter.com/wp-content/uploads/2021/02/profile-bg3.jpg')
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.dashboard),
            title: Text('Dashboard'),
            onTap: () =>Get.toNamed(dashboard),
          ),
          ListTile(
            leading: Icon(Icons.person),
            title: Text('Services'),
            onTap: () => Get.toNamed(services),
          ),
          ListTile(
            leading: Icon(Icons.local_airport),
            title: Text('Airports'),
            onTap: () => Get.toNamed(airports),
          ),
          ListTile(
            leading: Icon(Icons.favorite),
            title: Text('HealthCheck'),
            onTap: () => Get.toNamed(healthcheck),
          ),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text('Logout'),
            onTap: () => Logout(),
          ),
        ],
      ),
    );
    }
    else{
      return Drawer(
        child: ListView(
          children: [
            UserAccountsDrawerHeader(
              accountName: Text(box.get('user').toString()),
              accountEmail: Text(box.get('mail').toString()),
              currentAccountPicture: CircleAvatar(
                child: ClipOval(
                child: Image.network(
                'https://oflutter.com/wp-content/uploads/2021/02/girl-profile.png',
                fit: BoxFit.cover,
                width: 90,
                height: 90,
                ),
                ),
                ),
                decoration: BoxDecoration(
                color: Colors.blue,
                image: DecorationImage(
                fit: BoxFit.fill,
                image: NetworkImage(
                'https://oflutter.com/wp-content/uploads/2021/02/profile-bg3.jpg')),
                ),
                ),
                ListTile(
                leading: Icon(Icons.dashboard),
                title: Text('Dashboard'),
                onTap: () =>Get.toNamed(dashboard),
                ),
                ListTile(
                leading: Icon(Icons.person),
                title: Text('Services'),
                onTap: () => Get.toNamed(services),
                ),
            ListTile(
              leading: Icon(Icons.exit_to_app),
              title: Text('Logout'),
              onTap: () => Logout(),
            ),
          ],
        ),
      );
    }
    }
    else{
      return LoginPage();
    }
  }
}