// ignore_for_file: avoid_print

import 'package:auth/admin.dart';
import 'package:auth/screen/Barcode.dart';
import 'package:auth/screen/addproduct.dart';
import 'package:auth/screen/log.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _initialization,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            print('Something went wrong');
          }
          if (snapshot.connectionState == ConnectionState.done) {
            return GetMaterialApp(
              theme: ThemeData(
                  useMaterial3: true,
                  appBarTheme: const AppBarTheme(
                      centerTitle: true,
                      backgroundColor: Color.fromARGB(255, 212, 20, 52),
                      titleTextStyle: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w600))),
              debugShowCheckedModeBanner: false,
              home: const Login(),
              routes: {
                Barcode.routName: (ctx) => const Barcode(),
                AdminPanel.routeName: (context) => const AdminPanel(),
                Addproduct.routName: (ctx) => const Addproduct(),

                //admin123
              },
            );
          }
          return const CircularProgressIndicator();
        });
  }
}
