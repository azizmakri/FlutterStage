import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:front2/scrrens/HealthCheck.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import '../controllers/endpoint.dart';
import '../controllers/service.dart';
import 'SideBar.dart';


class OneService extends StatefulWidget {

  @override
  State<OneService> createState() => _MyOneService();
}

class _MyOneService extends State<OneService> {
  dynamic serviceID = Get.arguments;
  var box = Hive.box("database1");
  TextEditingController urlController = TextEditingController();
  TextEditingController nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavBar(),
      appBar: AppBar(
          title: Text("Service Details"),
      ),
      body: Stack(
          children: [
            Align(
              alignment: Alignment(0,-0.8),
              child: ElevatedButton(
              style: ButtonStyle(
                fixedSize: MaterialStateProperty.all(const Size(150, 50)),
              ),
              child: const Text('Add Endpoint'),
              onPressed: () {
                  showDialog(
                  context: context,
                  builder: (BuildContext context) {
                  return AlertDialog(
                  scrollable: true,
                  title: Text('Add Endpoint'),
                  content: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Form(
                    child: Column(
                      children: <Widget>[
                        TextFormField(
                          controller: nameController,
                          decoration: InputDecoration(
                            labelText: 'Name',
                          ),
                        ),
                        TextFormField(
                          controller: urlController,
                          decoration: InputDecoration(
                            labelText: 'URL',
                          ),
                        ),
                      ],
                    ),
                  ),
                  ),
                    actions: [
                      RaisedButton(
                          child: Text("Submit"),
                          onPressed: () {
                            AddEndpoint(nameController.text.toString(),urlController.text.toString(),serviceBox.get("serviceID"));
                            displayOneService(serviceBox.get("serviceID"));
                            Future.delayed(const Duration(milliseconds: 50), () {
                              Navigator.pop(context);
                              setState(() {
                              });
                            });

                          })
                    ],
                  );
                  });
              }),
            ),
            Align(
              alignment: Alignment.center,
              child: DataTable(
              columns: [
                DataColumn(label: Text("Endpoint Name")),
                DataColumn(label: Text("Endpoint ID")),
                DataColumn(label: Text("Endpoint URL")),
                DataColumn(label: Text("Action")),
              ],
              rows: serviceBox.get("OneService").map<DataRow>((element) => DataRow(cells: [
                DataCell(Text(element['name'])),
                DataCell(Text(element['_id'])),
                DataCell(Text(element['url'])),
                DataCell(ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary:Colors.red
                  ),
                  child: const Text('Delete'),
                  onPressed: () {
                    deleteEndpoint(element['_id']);
                    Future.delayed(const Duration(milliseconds: 50), () {
                      displayOneService(serviceBox.get("serviceID"));
                      setState(() {});
                    });
                  },
                )),
              ])).toList()
          ),
            ),
          ]
      ),
    );
  }
}
