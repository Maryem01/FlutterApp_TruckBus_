import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_app/auth/login.dart';
import 'package:flutter_app/auth/signup.dart';
import 'package:flutter_app/mapwidget/constnats/strings.dart';
import 'package:flutter_app/mapwidget/presentation/screens/map_screen.dart';
import 'package:flutter_app/role/home.dart';
import 'package:flutter_app/route/app_views.dart';
import 'package:flutter_app/view/dashboard/dashboard_screen.dart';
import 'package:flutter_app/views/add.dart';
import 'package:flutter_app/bus/addbus.dart';
import 'package:flutter_app/bus/viewbus.dart';
import 'package:flutter_app/route/app_page.dart';
import 'package:flutter_app/route/app_route.dart';

import 'package:flutter_app/auth/signup_admin.dart';
import 'package:flutter_app/parcours/addparcours.dart';
import 'package:flutter_app/parcours/view-parcours.dart';
import 'package:flutter_app/station/addstation.dart';
import 'package:flutter_app/station/view-station.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_app/admin/addadmin.dart';
import 'package:flutter_app/admin/view-admin.dart';
import 'package:flutter_app/auth/home_admin.dart';

import 'package:flutter_app/auth/Homepage.dart';
import 'package:flutter_app/auth/logiin.dart';
import 'package:flutter_app/auth/login_admin.dart';
import 'package:flutter_app/auth/search_bus.dart';
import 'package:flutter_app/auth/signup_admin.dart';
import 'package:get/get.dart';
import 'mapwidget/constnats/strings.dart';
import 'mapwidget/app_router.dart';

   late String initialRoute;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(   options:FirebaseOptions(
      apiKey: "AIzaSyAtrv9RvhCFSzO9QA3VbCsg0SSuN8yy_EM",
      appId: "1:478912769142:android:3b8d047fbbd19072c94357",
      messagingSenderId: "478912769142",
      projectId: "flutterapp-6a28d",
    ),);

  FirebaseAuth.instance.authStateChanges().listen((user) async {
    if (user == null) {
      initialRoute = loginScreen;
    } else {
      // Retrieve user's role from Firestore
      String userRole = await getUserRole(user.uid);

      // Set initialRoute based on user's role
      if (userRole == "Admin") {
        initialRoute = otpScreen;
      } else {
        initialRoute = bus;
      }
    }
    runApp(
      MyApp(
        appRouter: AppRouter(),
        initialRoute: initialRoute,
      ),
    );
  });
}

Future<String> getUserRole(String userId) async {
  String role = "user"; // Default role
  try {
    // Query Firestore to get user's role
    DocumentSnapshot userDoc = await FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .get();

    if (userDoc.exists) {
      // Explicitly cast userDoc.data() to Map<String, dynamic>
      Map<String, dynamic> userData = userDoc.data() as Map<String, dynamic>;

      // Check if 'role' field exists in the document
     if (userData != null && userData.containsKey('rool') && userData.containsKey('email')) {
        role = userData['rool'];
      }

      
    }
  } catch (e) {
    print("Error fetching user role: $e");
  }
  return role;
}


class MyApp extends StatelessWidget {
  final AppRouter appRouter;
  final String initialRoute;

  const MyApp({
    Key? key,
    required this.appRouter,
    required this.initialRoute,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      onGenerateRoute: appRouter.generateRoute,
      initialRoute: initialRoute,
    );
  }
}
