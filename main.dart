import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:imdb_clone/signup_page.dart';
import 'package:imdb_clone/home.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'authController.dart';
import 'login.dart';

final authController = AuthController();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    title: "IMDB",
    home: FutureBuilder(
        future: authController.tryAutoLogin(),
        builder: (contect, authResult) {
          if (authResult.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.red)),
            );
          } else {
            if (authResult.data == true) {
              return HomePage();
            }
            return LoginPage();
          }
        }),
    theme: ThemeData(
      primarySwatch: Colors.amber,
      splashColor: Colors.amber,
      colorScheme: const ColorScheme.light(primary: Colors.amber),
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.amber,
      ),
    ),
  ));
}
