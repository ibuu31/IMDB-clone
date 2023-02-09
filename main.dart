import 'package:flutter/material.dart';
import 'package:imdb_clone/signup_page.dart';
import 'package:imdb_clone/home.dart';
import 'package:imdb_clone/validLogin.dart';
import 'package:fluttertoast/fluttertoast.dart';

void main() {
  runApp(const MaterialApp(title: "IMDB", home: MyApp()));
  routes:
  <String, WidgetBuilder>{
    '/b': (BuildContext context) => const SignUp(),
  };
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const SignUp();
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  GlobalKey<FormState> formKey = new GlobalKey();
  final emailController = TextEditingController();
  final passController = TextEditingController();
  bool passToggle = true;
  String emailPattern = "[a-zA-Z0-9._-]+@[a-z]+\\.+[a-z]+";
  bool _isChecked = false;
  String sEmail = "";
  late String sPassword;
  int value = 0;
  validationUtils objValidations = validationUtils();
  String EmailFromDB = "ibrahim@gmail.com";
  String PwdFromDB = "123456";
  bool _passwordVisible = false;

  @override
  void initState() {
    _passwordVisible = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(),
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.amber,
          centerTitle: true,
          title: const Text('IMDB'),
        ),
        body: Center(
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const Image(
                      image: NetworkImage(
                          'https://m.media-amazon.com/images/G/01/imdb/authportal/images/www_imdb_logo._CB667618033_.png'),
                    ),
                    //For Login
                    TextFormField(
                      controller: emailController,
                      decoration: const InputDecoration(
                        icon: Icon(Icons.email),
                        labelText: 'Email',
                      ),
                      onSaved: (emailValue) {
                        sEmail = emailValue!;
                      },
                      validator: (email) {
                        if (email!.isEmpty) {
                          return "Email Id Required";
                        } else if (!RegExp(emailPattern).hasMatch(email)) {
                          return "Email format is not valid!";
                        }
                      },
                    ),
                    //For Register
                    TextFormField(
                      controller: passController,
                      obscureText:
                          !_passwordVisible, //This will obscure text dynamically
                      decoration: InputDecoration(
                        icon: Icon(Icons.lock),
                        suffixIcon: /*Icon(
                          Icons.remove_red_eye,
                        ),*/
                            IconButton(
                          icon: Icon(
                            // Based on passwordVisible state choose the icon
                            _passwordVisible
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: Theme.of(context).primaryColorDark,
                          ),
                          onPressed: () {
                            print("eye pressed");
                            setState(() {
                              _passwordVisible = !_passwordVisible;
                            });
                          },
                        ),
                        labelText: 'Password',
                      ),
                      validator: (password) {
                        if (password!.isEmpty) {
                          return "Password Required";
                        } else if (password.length < 6) {
                          return "Minimum 6 Char Required";
                        } else if (password != PwdFromDB) {
                          return "Password is invalid";
                        }
                      },
                      onSaved: (passwordValue) {
                        sPassword = passwordValue!;
                      },
                    ),
                    CheckboxListTile(
                      value: _isChecked,
                      selected: _isChecked,
                      onChanged: (v) {
                        setState(
                          () {
                            print(v);
                            _isChecked = v!;
                          },
                        );
                      },
                      title: const Text(
                        'Terms and conditions apply',
                      ),
                      controlAffinity: ListTileControlAffinity.leading,
                      // subtitle: !_isChecked
                      //     ? const Padding(
                      //         padding: EdgeInsets.fromLTRB(12.0, 0, 0, 0),
                      //         child: Text(
                      //           'Required field',
                      //           style: TextStyle(
                      //               color: Color(0xFFe53935), fontSize: 12),
                      //         ),
                      //       )
                      //     : null,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          formKey.currentState!.save();

                          bool isMyDataValid = objValidations.isDataValid(
                              sEmail, sPassword, _isChecked);

                          bool isValidAuthentication = sEmail == EmailFromDB &&
                              sPassword == PwdFromDB &&
                              (_isChecked == true);

                          if (isMyDataValid) {
                            if (isValidAuthentication) {
                              // print("Login Successfully \n Email Id Is : " +sEmail +"\n Password Is : " +sPassword);

                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => HomePage()));
                              //HomePage(sEmail, sPassword)
                            } else if (!_isChecked == false) {
                              Fluttertoast.showToast(
                                  msg: "This is Center Short Toast",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.CENTER,
                                  timeInSecForIosWeb: 1,
                                  backgroundColor: Colors.red,
                                  textColor: Colors.white,
                                  fontSize: 16.0);
                              print('Term check is required');
                            } else {
                              //auth error
                              print("Email Id & Password Invalid");
                            }
                          } else {
                            //validation error
                            print("Data is Invalid");
                          }
                        }
                      },
                      child: const Text('Login'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const SignUp()),
                        );
                      },
                      child: const Text('Register'),
                    ),
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
  String pwdPattern = "^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}\$";

  bool isDataValid(String email, String pwd, bool isChecked) {
    bool isValid = true;
    if (email.isEmpty) {
      print("email empty!");
      isValid = false;
    } else if (!RegExp(emailPattern).hasMatch(email)) {
      print("email not valid!");
      isValid = false;
    } else if (pwd.length < 6) {
      print("pwd not valid!");
      isValid = false;
    } else if (!isChecked) {
      print("terms not checked!");
      isValid = false;
    }
    return isValid;
  }
}
