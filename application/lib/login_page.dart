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
      body: Center(
        child: SingleChildScrollView(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Text("이메일", style: Theme.of(context).textTheme.titleMedium),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.white),
                color: Colors.black12,
              ),
              margin: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
              padding: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
              child: TextField(
                decoration:
                    InputDecoration(border: InputBorder.none, hintText: "이메일"),
                controller: _idController,
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            Text("비밀번호", style: Theme.of(context).textTheme.titleMedium),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.white),
                color: Colors.black12,
              ),
              margin: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
              padding: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
              child: TextField(
                decoration:
                    InputDecoration(border: InputBorder.none, hintText: "비밀번호"),
                obscureText: true,
                controller: _pwdController,
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            Container(
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.white),
              ),
              padding: EdgeInsets.symmetric(horizontal: 25),
              child: GestureDetector(
                  onTap: signIn,
                  child: Text(
                    "로그인",
                    style: Theme.of(context).textTheme.titleLarge,
                  )),
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
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("처음 사용하신다면? :"),
                      Text("회원가입",
                          style: TextStyle(fontStyle: FontStyle.italic)),
                    ],
                  )),
            ),
          ]),
        ),
      ),
    );
  }
}
