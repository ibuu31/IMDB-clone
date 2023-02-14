import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:imdb_clone/signup_page.dart';
import 'package:imdb_clone/home.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    title: "IMDB",
    home: LoginPage(),
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

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  GlobalKey<FormState> formKey = new GlobalKey();

  bool passToggle = true;
  String emailPattern = "[a-zA-Z0-9._-]+@[a-z]+\\.+[a-z]+";
  bool _isChecked = false;
  String sEmail = " ";
  String sPassword = " ";
  int value = 0;
  validationUtils objValidations = validationUtils();
  String EmailFromDB = "ibrahim@gmail.com";
  String PwdFromDB = "123456";
  bool _passwordVisible = false;
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  //initialized firebase.
  Future<User?> loginUsingEmailPassword(
      {required String email, required String password}) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;
    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      user = userCredential.user;
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => HomePage()));
      // print("user response: ${userCredential.user}");
      // login success
    } on FirebaseAuthException catch (e) {
      Fluttertoast.showToast(
          msg: "error:${e.message}",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          textColor: Colors.white,
          fontSize: 16.0);
      // print("error:${e.message}");
      // login failed

      if (e.code == "user not found") {
        print("No user found");
      }
    }
    return user;
  }

  @override
  void initState() {
    _passwordVisible = false;
    emailController.text = "ibrahim@gmail.com";
    passController.text = "123456";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('IMDB'),
          backgroundColor: Colors.amber,
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
                            _isChecked = v!;
                            print("$_isChecked");
                          },
                        );
                      },
                      title: const Text(
                        'Terms and conditions apply',
                      ),
                      controlAffinity: ListTileControlAffinity.leading,
                    ),
                    ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.amber),
                      ),
                      onPressed: () async {
                        User? user = await loginUsingEmailPassword(
                          email: emailController.text,
                          password: passController.text,
                        );
                        print("main" + user.toString());
                        print(sEmail);
/*                        if (formKey.currentState!.validate()) {
                          formKey.currentState!.save();

                          bool isMyDataValid = objValidations.isDataValid(
                              sEmail, sPassword, _isChecked);

                          bool isValidAuthentication = sEmail == EmailFromDB &&
                              sPassword == PwdFromDB &&
                              (_isChecked == true);

                          if (isMyDataValid) {
                            if (isValidAuthentication) {
                              // print("Login Successfully \n Email Id Is : " +sEmail +"\n Password Is : " +sPassword);

                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => HomePage()));
                              //HomePage(sEmail, sPassword)
                            } else if (_isChecked == false) {
                              print('Term check is required');
                            } else {
                              //auth error
                              print("Email Id & Password Invalid");
                            }
                          } else {
                            //validation error
                            Fluttertoast.showToast(
                                msg: "Terms and condition is not checked",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                                timeInSecForIosWeb: 1,
                                textColor: Colors.white,
                                fontSize: 16.0);
                          }
                        }*/
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
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.amber),
                      ),
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
