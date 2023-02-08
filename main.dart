import 'dart:convert';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:ecommerce_1/AppUrl.dart';
import 'package:ecommerce_1/category.dart';
import 'package:ecommerce_1/home.dart';
import 'package:ecommerce_1/signup.dart';
import 'package:ecommerce_1/splash.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(SplashApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  GlobalKey<FormState> formKey = new GlobalKey();
  String emailPattern = "[a-zA-Z0-9._-]+@[a-z]+\\.+[a-z]+";
  String sEmail = "";
  late String sPassword;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Login Form",
          style: TextStyle(
              color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset(
                "images/login.png",
                width: 100,
                height: 100,
              ),
              Form(
                  key: formKey,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                            hintText: "Enter Email Id",
                            labelText: "Email Id",
                          ),
                          validator: (email) {
                            if (email!.isEmpty) {
                              return "Email Id Required";
                            } else if (!RegExp(emailPattern).hasMatch(email)) {
                              return "Valid Email Id Required";
                            }
                          },
                          onSaved: (emailValue) {
                            sEmail = emailValue!;
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: TextFormField(
                          obscureText: true,
                          keyboardType: TextInputType.number,
                          validator: (password) {
                            if (password!.isEmpty) {
                              return "Password Required";
                            } else if (password.length < 6) {
                              return "Minimum 6 Char Required";
                            }
                          },
                          onSaved: (passwordValue) {
                            sPassword = passwordValue!;
                          },
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                            hintText: "Enter Password",
                            labelText: "Password",
                          ),
                        ),
                      ),
                      Container(
                        width: 205,
                        height: 50,
                        color: Colors.blueAccent,
                        child: FlatButton(
                            onPressed: () {
                              if (formKey.currentState!.validate()) {
                                formKey.currentState!.save();

                                if (sEmail == "admin@gmail.com" &&
                                    (sPassword == "admin@007" ||
                                        sPassword == "123456")) {
                                  //print("Login Successfully \n Email Id Is : " +sEmail +"\n Password Is : " +sPassword);
                                  print(
                                      "Login Successfully \n Email Id Is : $sEmail \n Password Is : $sPassword");
                                  Fluttertoast.showToast(
                                    msg: "Login Successfully",
                                    toastLength: Toast.LENGTH_SHORT,
                                    backgroundColor: Colors.black,
                                    textColor: Colors.white,
                                    gravity: ToastGravity.TOP,
                                  );
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              CategoryPage()));
                                  //HomePage(sEmail, sPassword)
                                } else {
                                  print("Email Id & Password Invalid");
                                  Fluttertoast.showToast(
                                    msg: "Email Id & Password Invalid",
                                    toastLength: Toast.LENGTH_SHORT,
                                    backgroundColor: Colors.black,
                                    textColor: Colors.white,
                                    gravity: ToastGravity.TOP,
                                  );
                                }
                              }
                            },
                            child: Text(
                              "Login",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            )),
                      ),
                      Container(
                        margin: EdgeInsets.all(10),
                        width: 205,
                        height: 50,
                        color: Colors.blueAccent,
                        child: FlatButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => SignupPage()));
                            },
                            child: Text(
                              "Create An Account",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            )),
                      ),
                    ],
                  ))
            ],
          ),
        ),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
