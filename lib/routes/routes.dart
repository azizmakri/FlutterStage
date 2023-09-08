import 'package:front2/scrrens/LoginPage.dart';
import 'package:front2/scrrens/Services.dart';
import 'package:get/get.dart';
import 'package:front2/scrrens/HomePage.dart';
import '../scrrens/Dashboard.dart';
import '../scrrens/HealthCheck.dart';
import '../scrrens/HomePage.dart';
import '../scrrens/OneService.dart';
import '../scrrens/Airports.dart';


String login="/login";
String Home="/home";
String dashboard="/dashboard";
String healthcheck="/healthcheck";
String services="/services";
String oneService="/OneService";
String airports="/Airports";


String getLoginRoute()=>login;
String getHomePage()=>Home;
String getDashboardRoute()=>dashboard;
String getHealthCheckRoute()=>healthcheck;
String getServiceskRoute()=>services;
String getOneServiceRoute()=>oneService;
String getAirports()=>airports;



List<GetPage>routes=[
    GetPage(page:()=>LoginPage(),name:login),
    GetPage(page:()=>HomePage(),name:Home),
    GetPage(page:()=>Dashboard(),name:dashboard),
    GetPage(page:()=>HealthCheck(),name:healthcheck),
    GetPage(page:()=>Services(),name:services),
    GetPage(page:()=>OneService(),name:oneService),
    GetPage(page:()=>Airports(),name:airports),
  ];
//}
