import 'dart:convert';

import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';


fetchServices() async {
  var serviceBox = Hive.box("healthCheck");
  var ser;
  var serviceList=[];
  try{
    Response response = await http.get(Uri.parse('http://localhost:8080/api/test/allservices'),
      headers: {
        "Access-Control-Allow-Origin": "*", // Required for CORS support to work
        "Access-Control-Allow-Headers": "Origin,Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token,locale",
        "Access-Control-Allow-Methods": "GET, OPTIONS"
      },
    );
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
        for (ser in data) {
          if(ser['enable']==true){
            serviceList.add(ser['name'].toString());
        }
      }
      await serviceBox.put('services', List<String>.from(serviceList));
      var s = List<String>.from(serviceBox.get("services"));

      print(s);

    }else{
      print("erreur");
    }
  }catch(e){
    return (e.toString());
  }
}



displayServices() async {
  var serviceBox = Hive.box("healthCheck");

  try{
    Response response = await http.get(Uri.parse('http://localhost:8080/api/test/allservices'),
      headers: {
        "Access-Control-Allow-Origin": "*", // Required for CORS support to work
        "Access-Control-Allow-Headers": "Origin,Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token,locale",
        "Access-Control-Allow-Methods": "GET, OPTIONS"
      },
    );
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      //print(data);
      serviceBox.put('Allservices', List.from(data));
      List<void> allS = List.from(serviceBox.get("Allservices"));

      print(allS);
      
    }else{
      print("erreur");
    }
  }catch(e){
    return (e.toString());
  }
}

displayOneService(String serviceId) async {
  var serviceBox = Hive.box("healthCheck");

  try{
    Response response = await http.get(Uri.parse('http://localhost:8080/api/endpoints/service/$serviceId'),
      headers: {
        "Access-Control-Allow-Origin": "*", // Required for CORS support to work
        "Access-Control-Allow-Headers": "Origin,Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token,locale",
        "Access-Control-Allow-Methods": "GET, OPTIONS"
      },
    );
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body.toString());
      //print(data);
      var s= data;
      serviceBox.put('OneService', List.from(s));
      List<void> allS = List.from(serviceBox.get("OneService"));
      serviceBox.put('serviceID', serviceId);

      print(allS);

    }else{
      print("erreur");
    }
  }catch(e){
    return (e.toString());
  }
}

AddService(String serviceName) async {
  try{
    Response response = await http.post(Uri.parse('http://localhost:8080/api/test/createservice'),
      headers: {
        "Access-Control-Allow-Origin": "*", // Required for CORS support to work
        "Access-Control-Allow-Headers": "Origin,Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token,locale",
        "Access-Control-Allow-Methods": "POST, OPTIONS"
      },
      body: {
        'name': serviceName,
      },
    );
    if (response.statusCode == 400) {
      print("Content can not be empty!");
    }
    else if(response.statusCode == 500) {
      print("Error while adding");
    }
    else
      print("success");
  }catch(e){
    return (e.toString());
  }
}

EditService(bool status,String SerivceID) async {
  print(SerivceID);

    Response response = await http.put(Uri.parse('http://localhost:8080/api/test/update/'+SerivceID),
      headers: {
        "Access-Control-Allow-Origin": "*", // Required for CORS support to work
        "Access-Control-Allow-Headers": "Origin,Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token,locale",
        "Access-Control-Allow-Methods": "PUT, OPTIONS"
      },
      body: {
        'enable': status.toString(),
      },
    );
  if (response.statusCode == 400) {
    print("Data to update can not be empty");
  }
  else if(response.statusCode == 404) {
    print("Cannot update Service with id=$SerivceID. Maybe Service was not found!");
  }
  else if(response.statusCode == 500) {
    print("Error updating Service with id="+SerivceID);
  }
  else
    print("success");
}
