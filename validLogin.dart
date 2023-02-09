import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'home.dart';

class ValidLogin extends StatefulWidget {
  const ValidLogin({Key? key}) : super(key: key);

  @override
  State<ValidLogin> createState() => _ValidLoginState();
}

class _ValidLoginState extends State<ValidLogin> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = new TextEditingController();
  var name;
  ValidationUtils util = ValidationUtils();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Validation'),
        ),
        body: Container(
          child: Column(
            key: _formKey,
            children: <Widget>[
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(
                  label: Text('name'),
                ),
                onSaved: (val) => name = val,
                validator: (val) =>
                    name.lenth <= 5 ? "Enter correct name" : null,
              ),
              ElevatedButton(
                onPressed: () {
                  Fluttertoast.showToast(
                      msg: "This is Center Short Toast",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.CENTER,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Colors.red,
                      textColor: Colors.white,
                      fontSize: 16.0);
                },
                child: const Text('Click'),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class ValidationUtils {
  bool isValid(String name) {
    print('data: $name');
    if (name == 'Raj') {
      print('result: true');
      return true;
    }
    print('result: false');
    return false;
  }
}
