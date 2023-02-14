import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'database_service.dart';
import 'home.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  bool _isChecked = false;
  GlobalKey<FormState> formKey = new GlobalKey();
  final firstnameController = TextEditingController();
  final lastnameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  String name = "";
  String last_name = "";
  String eMail = "";
  String passwd = "";
  bool _passwordVisible = false;
  String emailPattern = "[a-zA-Z0-9._-]+@[a-z]+\\.+[a-z]+";
  validationUtilsSignUp objValidationsSignUp = validationUtilsSignUp();
  final _auth = FirebaseAuth.instance;

  @override
  void initState() {
    _passwordVisible = false;
    emailController.text = "ibrahim@gmail.com";
    firstnameController.text = "ibuu";
    lastnameController.text = "bode";
    passwordController.text = "123456";
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SignUp Page'),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            child: Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Image(
                    image: NetworkImage(
                        'https://m.media-amazon.com/images/G/01/imdb/authportal/images/www_imdb_logo._CB667618033_.png'),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Flexible(
                        child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: TextFormField(
                            controller: firstnameController,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'First Name',
                              contentPadding: EdgeInsets.all(10),
                            ),
                            validator: (fName) {
                              if (fName!.isEmpty) {
                                return "Name is Required";
                              }
                            },
                            onSaved: (fName) {
                              name = fName!;
                            },
                          ),
                        ),
                      ),
                      Flexible(
                        child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: TextFormField(
                            controller: lastnameController,
                            decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Last Name',
                                contentPadding: EdgeInsets.all(10)),
                            validator: (lName) {
                              if (lName!.isEmpty) {
                                return "LastName is Required";
                              }
                            },
                            onSaved: (lName) {
                              last_name = lName!;
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: emailController,
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.email),
                        labelText: 'Email',
                        border: OutlineInputBorder(),
                      ),
                      validator: (email) {
                        if (email!.isEmpty) {
                          return "Email Id Required";
                        } else if (!RegExp(emailPattern).hasMatch(email)) {}
                      },
                      onSaved: (email) {
                        eMail = email!;
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: passwordController,
                      obscureText: !_passwordVisible,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.lock),
                        suffixIcon: IconButton(
                          icon: Icon(
                            // Based on passwordVisible state choose the icon
                            _passwordVisible
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: Theme.of(context).primaryColorDark,
                          ),
                          onPressed: () {
                            print("eye pressed");
                            setState(
                              () {
                                _passwordVisible = !_passwordVisible;
                              },
                            );
                          },
                        ),
                        labelText: 'Password',
                        border: OutlineInputBorder(),
                      ),
                      validator: (pass) {
                        if (pass!.isEmpty) {
                          return "Password Is Required";
                        }
                      },
                      onSaved: (pass) {
                        passwd = pass!;
                      },
                    ),
                  ),
                  CheckboxListTile(
                    value: _isChecked,
                    selected: _isChecked,
                    onChanged: (v) {
                      setState(() {
                        print(v);
                        _isChecked = v!;
                      });
                    },
                    title: const Text(
                      'Terms and conditions apply',
                    ),
                    controlAffinity: ListTileControlAffinity.leading,
                  ),
                  ElevatedButton(
                      onPressed: () async {
                        final message = await AuthService().registration(
                          email: emailController.text,
                          password: passwordController.text,
                        );
                        if (message!.contains('Success')) {
                          final result = await DatabaseService().addUser(
                            firstname: firstnameController.text,
                            lastname: lastnameController.text,
                            email: emailController.text,
                            password: passwordController.text,
                          );
                          if (result!.contains('success')) {
                            print('success');
                          }
                        }
                      },
                      // if (formKey.currentState!.validate()) {
                      //   formKey.currentState!.save();
                      //   //
                      //   bool isMyDataValidSignUp =
                      //       objValidationsSignUp.isDataValidSignUp(
                      //           name, last_name, eMail, passwd, _isChecked);
                      //   bool termsChecked =
                      //       objValidationsSignUp.termsChecked(_isChecked);
                      //
                      //   if (isMyDataValidSignUp) {
                      //     if (termsChecked == true) {
                      //       Navigator.pushReplacement(
                      //           context,
                      //           MaterialPageRoute(
                      //               builder: (context) => HomePage()));
                      //     } else {
                      //       Fluttertoast.showToast(
                      //           msg: "Terms and condition is not checked",
                      //           toastLength: Toast.LENGTH_SHORT,
                      //           gravity: ToastGravity.BOTTOM,
                      //           timeInSecForIosWeb: 1,
                      //           textColor: Colors.white,
                      //           fontSize: 16.0);
                      //     }
                      //   } else {
                      //     //validation error
                      //     Fluttertoast.showToast(
                      //         msg: "Data invalid",
                      //         toastLength: Toast.LENGTH_SHORT,
                      //         gravity: ToastGravity.BOTTOM,
                      //         timeInSecForIosWeb: 1,
                      //         textColor: Colors.white,
                      //         fontSize: 16.0);
                      //   }
                      // }

                      child: const Text('Register')),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class validationUtilsSignUp {
  String emailPattern = "[a-zA-Z0-9._-]+@[a-z]+\\.+[a-z]+";

  bool isDataValidSignUp(String firstname, String lastname, String email,
      String passwd, bool isChecked) {
    bool isValid = true;
    if (firstname.isEmpty) {
      print("firstname empty!");
      isValid = false;
    } else if (lastname.isEmpty) {
      print("Lastname empty!");
      isValid = false;
    } else if (email.isEmpty) {
      print("email empty!");
      isValid = false;
    } else if (!RegExp(emailPattern).hasMatch(email)) {
      print("email not valid!");
      isValid = false;
    } else if (passwd.length < 6) {
      print("pwd not valid!");
      isValid = false;
    }
    return isValid;
  }

  bool termsChecked(bool isChecked) {
    if (isChecked == false) return false;
    return true;
  }
}
