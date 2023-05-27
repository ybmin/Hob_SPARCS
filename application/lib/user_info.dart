import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hob_sparcs/app.dart';
import 'group_create.dart';
import 'home.dart';

class UserInfom extends StatefulWidget {
  const UserInfom({super.key});

  @override
  State<UserInfom> createState() => _UserInfom();
}

class _UserInfom extends State<UserInfom> {
  final user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    int _index = 2;
    return Scaffold(
        resizeToAvoidBottomInset: false,
        bottomNavigationBar: BottomNavigationBar(
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.list), label: "Home"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.group_add), label: "Create Group"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.person), label: "User Info")
            ],
            currentIndex: _index,
            selectedItemColor: Colors.blue,
            onTap: (value) {
              _index = value;
              if (value == 0) {
                Navigator.of(context).push(PageRouteBuilder(
                    pageBuilder: (context, animation, secondaryAnimation) =>
                        Home()));
              } else if (value == 1) {
                Navigator.of(context).push(PageRouteBuilder(
                    pageBuilder: (context, animation, secondaryAnimation) =>
                        GroupCreate()));
              }
            }),
        body: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const CircleAvatar(child: Icon(Icons.person)),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [Text("Name"), Text(user!.email.toString())],
                ),
              ],
            ),
            Container(
              child: GestureDetector(
                onTap: () {
                  FirebaseAuth.instance.signOut();
                  Navigator.pushAndRemoveUntil(
                      context,
                      PageRouteBuilder(pageBuilder:
                          (context, animation, secondaryAnimation) {
                        return App();
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
                child: Text("Log Out"),
              ),
            )
          ],
        ));
  }
}
