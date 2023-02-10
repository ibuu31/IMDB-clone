import 'package:flutter/material.dart';

import 'home.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  bool _isChecked = false;
  GlobalKey<FormState> formKey = new GlobalKey();
  String name = "";
  String last_name = "";
  String eMail = "";
  String passwd = "";
  bool _passwordVisible = false;

  validationUtils objValidations = validationUtils();

  @override
  void initState() {
    _passwordVisible = false;
    super.initState();
  }

  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.amber,
          centerTitle: true,
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
                                fName = name;
                              },
                            ),
                          ),
                        ),
                        Flexible(
                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: TextFormField(
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
                                lName = last_name;
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.email),
                          labelText: 'Email',
                          border: OutlineInputBorder(),
                        ),
                        validator: (email) {
                          if (email!.isEmpty) {
                            return "Email Id Required";
                          }
                        },
                        onSaved: (email) {
                          email = eMail;
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
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
                          pass = passwd;
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
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            formKey.currentState!.save();
                            //
                            bool isMyDataValid = objValidations.isDataValid(
                                name, last_name, eMail, passwd, _isChecked);
                            bool isValidAuthentication = name.isNotEmpty &&
                                last_name.isNotEmpty &&
                                eMail.isNotEmpty &&
                                passwd.isNotEmpty &&
                                _isChecked == true;

                            if (isMyDataValid) {
                              if (isValidAuthentication) {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => HomePage()));
                                //HomePage(sEmail, sPassword)
                              } else {
                                //auth error
                                print("Email Id & Password Invalid");
                              }
                            }
                          }
                        },
                        child: const Text('Register')),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class validationUtils {
  String emailPattern = "[a-zA-Z0-9._-]+@[a-z]+\\.+[a-z]+";

  bool isDataValid(String fname, String lastname, String email, String passwd,
      bool isChecked) {
    bool isValid = true;
    if (fname.isEmpty) {
      print("firstname empty!");
      isValid = false;
    } else if (lastname.isEmpty) {
      print("Lastname empty!");
      isValid = false;
    }
    if (email.isEmpty) {
      print("email empty!");
      isValid = false;
    } else if (!RegExp(emailPattern).hasMatch(email)) {
      print("email not valid!");
      isValid = false;
    } else if (passwd.length < 6) {
      print("pwd not valid!");
      isValid = false;
    } else if (!isChecked) {
      print("terms not checked!");
      isValid = false;
    }
    return isValid;
  }
}
