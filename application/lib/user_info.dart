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
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const CircleAvatar(
                  child: Image(
                    image: NetworkImage(
                      "https://img.freepik.com/free-vector/id-card-concept-illustration_114360-1463.jpg",
                    ),
                    height: 300,
                    fit: BoxFit.fitHeight,
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [Text("Name"), Text("Id")],
                )
              ],
            ),
          ],
        ));
  }
}
