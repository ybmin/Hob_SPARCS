import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hob_sparcs/register_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPage();
}

class _LoginPage extends State<LoginPage> {
  final _idController = TextEditingController();
  final _pwdController = TextEditingController();

  Future signIn() async {
    await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _idController.text.trim(), password: _pwdController.text.trim());
  }

  @override
  void dispose() {
    _idController.dispose();
    _pwdController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
          child: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Text("id"),
          TextField(
            controller: _idController,
          ),
          Text("pwd"),
          TextField(
            controller: _pwdController,
          ),
          Container(
            child: GestureDetector(onTap: signIn, child: Text("Sign In")),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            child: GestureDetector(
                onTap: () {
                  Navigator.pushAndRemoveUntil(
                      context,
                      PageRouteBuilder(pageBuilder:
                          (context, animation, secondaryAnimation) {
                        return RegisterPage();
                      }, transitionsBuilder: (BuildContext context,
                          Animation<double> animation,
                          Animation<double> secondaryAnimation,
                          Widget child) {
                        return new SlideTransition(
                          position: new Tween<Offset>(
                            begin: const Offset(1.0, 0.0),
                            end: Offset.zero,
                          ).animate(animation),
                          child: child,
                        );
                      }),
                      (route) => false);
                },
                child: Text("Register")),
          ),
        ]),
      )),
    );
  }
}
