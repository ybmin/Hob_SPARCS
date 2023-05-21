import 'package:flutter/material.dart';
import 'group_create.dart';
import 'home.dart';

class UserInfom extends StatefulWidget {
  const UserInfom({super.key});

  @override
  State<UserInfom> createState() => _UserInfom();
}

class _UserInfom extends State<UserInfom> {
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
            Image(image: null),
            Row(
              children: [Text("Name"), Text("Id")],
            )
          ],
        ));
  }
}
