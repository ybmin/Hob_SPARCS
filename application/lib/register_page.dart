import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hob_sparcs/app.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPage();
}

class _RegisterPage extends State<RegisterPage> {
  final _idController = TextEditingController();
  final _pwdController = TextEditingController();
  final _realNameController = TextEditingController();
  final _nicknameController = TextEditingController();

  Future register(String email, String pwd) async {
    await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: pwd);
  }

  Future addUser(
      String email, String pwd, String realName, String nickname) async {
    await FirebaseFirestore.instance
        .collection("users")
        .add({'email': email, 'realName': realName, 'nickname': nickname});
  }

  @override
  void dispose() {
    _idController.dispose();
    _pwdController.dispose();
    _realNameController.dispose();
    _nicknameController.dispose();
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
          Text("real name"),
          TextField(
            controller: _realNameController,
          ),
          Text("nickname"),
          TextField(
            controller: _nicknameController,
          ),
          Container(
            child: GestureDetector(
                onTap: () {
                  register(
                    _idController.text.trim(),
                    _pwdController.text.trim(),
                  );
                  addUser(
                      _idController.text.trim(),
                      _pwdController.text.trim(),
                      _realNameController.text.trim(),
                      _nicknameController.text.trim());
                  Navigator.pushAndRemoveUntil(
                      context,
                      PageRouteBuilder(pageBuilder:
                          (context, animation, secondaryAnimation) {
                        return App(); // 추후에 사용자 개인설정 필요시에 페이지 추가
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
