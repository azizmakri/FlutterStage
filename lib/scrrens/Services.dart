import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:front2/controllers/service.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import '../routes/routes.dart';
import 'HealthCheck.dart';
import 'SideBar.dart';


class Services extends StatefulWidget {

  @override
  State<Services> createState() => _MyServices();
}

class _MyServices extends State<Services> {
  var serviceBox = Hive.box("healthCheck");
  var healthbox = Hive.box("healthCheck");


  bool status = false;
  var box = Hive.box("database1");
  TextEditingController serviceNameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavBar(),
      appBar: AppBar(
        title: const Text('Services'),
      ),
      body: Stack(
        children: [
          Align(
            alignment: Alignment(-0.4,-0.5),
            child: ElevatedButton(
                style: ButtonStyle(
                  fixedSize: MaterialStateProperty.all(const Size(130, 30)),
                ),
                child: const Text('Add Service'),
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          scrollable: true,
                          title: Text('Add Service'),
                          content: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Form(
                              child: Column(
                                children: <Widget>[
                                  TextFormField(
                                    controller: serviceNameController,
                                    decoration: InputDecoration(
                                      labelText: 'Name',
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
                                  AddService(serviceNameController.text.toString());
                                  displayServices();
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
                  DataColumn(label: Text("Service Name")),
                  DataColumn(label: Text("Service ID")),
                  DataColumn(label: Text("Action")),
                  DataColumn(label: Text("status")),
                ],
                rows: serviceBox.get("Allservices").map<DataRow>((element) => DataRow(cells: [
                  DataCell(Text(element['name'])),
                  DataCell(Text(element['_id'])),

                  DataCell(ElevatedButton(
                    onPressed: () {
                      if(element['enable']){
                        setState(() => element['enable']=false);
                      }
                      else{
                        setState(() =>
                        element['enable']=true);
                      }
                      EditService(element['enable'],element['_id']);
                      print(element['enable']);
                      fetchServices();
                    },
                    child: Text(element['enable'] ? 'Enable' : 'Disable'),
                    style: ElevatedButton.styleFrom(
                      primary: element['enable']? Colors.green : Colors.red,
                    ),
                  )),
                  DataCell(ElevatedButton(
                    child: const Text('Edit'),
                    onPressed: () {
                      displayOneService(element['_id']);
                      Future.delayed(const Duration(seconds: 1), () {
                        setState(() {
                          Get.toNamed(oneService,arguments:element['_id']);
                        });
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
