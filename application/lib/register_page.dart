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
              height: 20,
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
                obscureText: true,
                decoration:
                    InputDecoration(border: InputBorder.none, hintText: "비밀번호"),
                controller: _pwdController,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Text("이름", style: Theme.of(context).textTheme.titleMedium),
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
                    InputDecoration(border: InputBorder.none, hintText: "홍길동"),
                controller: _realNameController,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Text("닉네임", style: Theme.of(context).textTheme.titleMedium),
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
                    InputDecoration(border: InputBorder.none, hintText: "넙죽이"),
                controller: _nicknameController,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.white),
              ),
              padding: EdgeInsets.symmetric(horizontal: 25),
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
                  child: Text(
                    "Register",
                    style: Theme.of(context).textTheme.titleLarge,
                  )),
            ),
          ]),
        ),
      ),
    );
  }
}
