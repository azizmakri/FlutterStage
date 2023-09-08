import 'dart:convert';

import 'package:front2/scrrens/HealthCheck.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';


 fetchEndPoints(String serviceName) async {
  var endpointBox = Hive.box("healthCheck");
  List<String> edpv=[];
  var endP ;
  try{
    Response response = await http.get(Uri.parse('http://localhost:8080/api/test/allendpoints'),
      headers: {
        "Access-Control-Allow-Origin": "*", // Required for CORS support to work
        "Access-Control-Allow-Headers": "Origin,Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token,locale",
        "Access-Control-Allow-Methods": "GET, OPTIONS",
      },
    );
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body.toString());
      //for (endP in data) {
       // endpointList.add(endP['name'].toString());
      //}
      //print(s.toString());
      //print(endpointList);
      endpointBox.put('endpoints', data);
      var s = endpointBox.get('endpoints');
      for (endP in s) {
        if(endP['service']['name']==serviceName){
        edpv.add(endP['name'].toString());
        }
      }
      print(edpv);
      print("******************************");


      return edpv;


    }else{
      return [];
    }
  }catch(e){
    return [];
  }
}



HealthCheckF(String endpointName) async {
  var healthbox = Hive.box("statuscheck");

  try{
    Response response = await http.post(Uri.parse('http://localhost:8080/api/test/HealthStatusCheck/$endpointName'),
      headers: {
        "Access-Control-Allow-Origin": "*",
        "Access-Control-Allow-Headers": "Origin,Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token,locale",
        "Access-Control-Allow-Methods": "GET, OPTIONS",
      },
      body: {},
    );
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body.toString());


      print(data);
      healthbox.put("status",data["status"].toString());
      healthbox.put("message",data["message"]);
    }else{
      print(response.statusCode);
    }
  }catch(e){
    return (e.toString());
  }
}

deleteEndpoint(String endpointId) async {

  try{
    Response response = await http.delete(Uri.parse('http://localhost:8080/endpoints/delete/$endpointId'),
      headers: {
        "Access-Control-Allow-Origin": "*",
        "Access-Control-Allow-Headers": "Origin,Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token,locale",
        "Access-Control-Allow-Methods": "GET, OPTIONS",
      },
    );

    if (response.statusCode == 404) {
      print("Cannot delete Endpoint with id=$endpointId. Maybe Endpoint was not found!");
    }
    else if(response.statusCode == 500) {
      print("Could not delete Endpoint with id=" +endpointId);
    }
    else
      print("success");


  }catch(e){
    return (e.toString());
  }
}


AddEndpoint(String edpName,String edpURL,String service) async {
  try{
    Response response = await http.post(Uri.parse('http://localhost:8080/api/test/new_endpoint'),
      headers: {
        "Access-Control-Allow-Origin": "*", // Required for CORS support to work
        "Access-Control-Allow-Headers": "Origin,Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token,locale",
        "Access-Control-Allow-Methods": "POST, OPTIONS"
      },
      body: {
        'name': edpName,
        'url':edpURL,
        'service':service
      },
    );

  }catch(e){
    return (e.toString());
  }
}