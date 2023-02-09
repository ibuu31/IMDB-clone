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

  @override
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
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.lock),
                        suffixIcon: Icon(Icons.remove_red_eye),
                        labelText: 'Password',
                        border: OutlineInputBorder(),
                      ),
                      validator: (pass) {
                        if (pass!.isEmpty) {
                          return "Password Is Required";
                        }
                      },
                      obscureText: true,
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
                        // formKey.currentState!.save();
                        //
                        // bool isValidAuthentication = fName;

                        // if (isValidAuthentication) {
                        // print("Login Successfully \n Email Id Is : " +sEmail +"\n Password Is : " +sPassword);

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
                    // }
                    ,
                    child: const Text('Register'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
