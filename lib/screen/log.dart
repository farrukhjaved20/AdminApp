// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';

import '../admin.dart';

class Login extends StatefulWidget {
  static const routName = '/login';
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  static Future<User?> loginusingemailpassword(
      {required String email,
      required String password,
      required BuildContext context}) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;
    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      user = userCredential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user not found') {
        print('No user found');
      }
    }
    return user;
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController emailcontroller = TextEditingController();
    TextEditingController passwordcontroller = TextEditingController();
    return Container(
      color: Color.fromARGB(
        255,
        212,
        20,
        52,
      ),
      child: Center(
        child: Column(children: <Widget>[
          Padding(
            padding: EdgeInsets.all(70),
          ),
          Image.asset(
            'assets/images/logo.jpg',
            fit: BoxFit.scaleDown,
            height: 200,
            width: 500,
          ),
          SizedBox(
            height: 10,
          ),
          SizedBox(
            height: 100,
            width: 500,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                elevation: 10,
                child: Column(
                  children: <Widget>[
                    TextFormField(
                      controller: emailcontroller,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                          labelText: 'Username',
                          labelStyle: Theme.of(context).textTheme.bodyLarge,
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 10, horizontal: -10),
                          icon: Padding(
                            padding: const EdgeInsets.all(10),
                          )),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            height: 100,
            width: 500,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                // color: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                elevation: 10,
                child: Column(
                  children: <Widget>[
                    TextFormField(
                        controller: passwordcontroller,
                        obscureText: true,
                        keyboardType: TextInputType.text,
                        //This will obscure text dynamically
                        decoration: const InputDecoration(
                          labelText: 'Password',
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 10, horizontal: -10),
                          icon: Padding(
                            padding: EdgeInsets.all(10),
                          ),
                        )),
                  ],
                ),
              ),
            ),
          ),
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                elevation: 10,
                alignment: Alignment.center,
                // textStyle: Theme.of(context).textTheme.labelLarge,
                minimumSize: Size(45, 45),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(35.0),
                ),
              ),
              onPressed: () async {
                User? user = await loginusingemailpassword(
                    email: emailcontroller.text,
                    password: passwordcontroller.text,
                    context: context);
                print(user);
                if (user != null) {
                  Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => AdminPanel()));
                }
                // Navigator.push(context,
                //     MaterialPageRoute(builder: (context) => AdminPanel()))
              },
              child: Text(
                'Sign In',
                style: TextStyle(
                    fontFamily: 'MyriadPro', fontSize: 20, color: Colors.white),
              ))
        ]),
      ),
    );
  }
}
