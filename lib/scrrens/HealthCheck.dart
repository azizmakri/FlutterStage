import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import '../controllers/endpoint.dart';
import 'SideBar.dart';




var serviceBox = Hive.box("healthCheck");
var healthbox = Hive.box("statuscheck");
class HealthCheck extends StatefulWidget {

  @override
  State<HealthCheck> createState() => _MyHeathCheck();
}

class _MyHeathCheck extends State<HealthCheck> {



  String? endpointValue;
  String? valueEdp;
  String? message ;
  String? status;
  String? serviceValue;
  List<String> endpointValues=[];
  late List<String> serviceValues;
  //List<String> serviceValues=[];

  Future<void>test (serviceValues)  async {

    setState(()  {
      serviceValues=   serviceBox.get("services");
    });

 }
  @override
  void initState() {
    serviceValues=   serviceBox.get("services");
    test(serviceValues);
    super.initState();

  }
  Widget build(BuildContext context) {



    return Scaffold(
      drawer: NavBar(),
      appBar: AppBar(
        title: const Text('MyHeathCheck'),
      ),
      body: Container(
          child: Center(
          child: Stack(
          children:<Widget>[
            Container(
              padding: EdgeInsets.only(top: 10,left: 150,bottom: 500),
                child: DropdownButton<String> (
                  value: serviceValue,
                  hint: Text("Services"),
                  style: const TextStyle(color: Colors.deepPurple),
                   underline: Container(
                     height: 2,
                     color: Colors.deepPurpleAccent,
                  ),

                  onChanged: (String? newValue) async {
                    List<String> p=[];
                    setState(() {
                      serviceValue = newValue!;

                    });
                    p= await  fetchEndPoints(serviceValue!);
                    setState(()  {
                      endpointValues.clear();
                      endpointValues=p.toList();
                    });


                  },
                  items: serviceValues
                      .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                     value: value,
                     child: Text(value),
                   );
                }).toList(),
                ),
            ),
            Container(
              padding: EdgeInsets.only(top: 80,right: 500,left:150),
                child: DropdownButton<String>(
                  value: endpointValue,
                  hint: Text("Endpoints"),
                  style: const TextStyle(color: Colors.deepPurple),
                  underline: Container(
                    height: 2,
                    color: Colors.deepPurpleAccent,
                  ),
                  onChanged: (String? newValue) {
                    setState(()  {
                      endpointValue = newValue!;
                    });

                  },
                  items: endpointValues
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onTap: () {
                  },
                ),
        ),
            Container(
                padding: const EdgeInsets.fromLTRB(300, 60, 0, 20),
                child: ElevatedButton(
                  child: const Text('OK'),
                  onPressed: () {

                    setState(() {
                      HealthCheckF(endpointValue!);
                      Future.delayed(const Duration(seconds: 15), () {
                        status=healthbox.get("status");
                        message=healthbox.get("message");
                        valueEdp=endpointValue;
                      setState(() {
                        healthbox.clear();

                      });

                    });


                    });
                    },
                )
            ),
          Container(
            padding: EdgeInsets.only(top: 140,left: 150),
            
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.only(left: 100,top: 100),
                  child: RichText(
                    text: TextSpan(
                        style: TextStyle(fontWeight: FontWeight.bold),
                        text: 'Endpoint Name'),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(left: 100,top: 100),
                  child: RichText(
                    text: TextSpan(
                        style: TextStyle(fontWeight: FontWeight.bold),
                        text: 'Status'),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(left: 100,top: 100),
                  child: RichText(
                    text: TextSpan(
                        style: TextStyle(fontWeight: FontWeight.bold),
                        text: 'Message'),
                  ),
                )

              ],
            )
          ),
            Container(
                padding: EdgeInsets.only(top: 190,left: 150),

                child: Row(
                  children: [
                    Container(
                      padding: EdgeInsets.only(left: 100,top: 100),
                      child: RichText(
                        text: TextSpan(
                            text: valueEdp),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 100,top: 100),
                      child: RichText(
                        text: TextSpan(
                            text: status),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 100,top: 100),
                      child: RichText(
                        text: TextSpan(
                            text: message),
                      ),
                    )

                  ],
                )
            ),
    ],
      ),)

    ),

    );
  }
}
