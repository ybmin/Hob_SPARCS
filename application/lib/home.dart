import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutterfire_ui/firestore.dart';
import 'package:flutter/services.dart';
import 'package:hob_sparcs/src/user.dart';

import 'search.dart';
import 'group_detail.dart';
import 'group_create.dart';
import 'user_info.dart';
import 'filter_page.dart';
import 'src/group.dart';

//소그룹 리스트 항목 제공
class GroupList extends StatelessWidget {
  GroupMeet gp;
  final String? id;
  final UserName? userName;

  GroupList(this.gp, this.id, this.userName, {super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        Navigator.of(context).push(PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) =>
                GroupDetail(gp, id, userName)));
      },
      title: Card(
          margin: const EdgeInsets.all(10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                gp.dates!.month.toString() + '/' + gp.dates!.day.toString(),
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
              ),
              const SizedBox(
                width: 15,
              ),
              Column(
                children: [
                  Text(
                    gp.title!,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  Text(gp.tags!),
                ],
              )
            ],
          )),
    );
  }
}

class Home extends StatefulWidget {
  final UserName? userName;
  const Home(this.userName, {super.key});

  @override
  State<Home> createState() => _Home();
}

class _Home extends State<Home> {
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge,
        overlays: [SystemUiOverlay.top]);
    final groupQuery = FirebaseFirestore.instance
        .collection('group')
        .orderBy('dates')
        .withConverter(
          fromFirestore: GroupMeet.fromFirestore,
          toFirestore: (GroupMeet group, option) => group.toFireStore(),
        );
    return Scaffold(
      resizeToAvoidBottomInset: false,
      // 홈, 방 생성, 회원 정보 창 네비게이션바
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
            if (value == 1) {
              Navigator.of(context).push(PageRouteBuilder(
                  pageBuilder: (context, animation, secondaryAnimation) =>
                      GroupCreate(widget.userName)));
            } else if (value == 2) {
              Navigator.of(context).push(PageRouteBuilder(
                  pageBuilder: (context, animation, secondaryAnimation) =>
                      UserInfom(widget.userName)));
            }
          }),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            const Text(
              "Hob SPARCS",
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
            Row(
              children: [
                IconButton(
                    onPressed: () {
                      Navigator.of(context).push(PageRouteBuilder(
                          pageBuilder:
                              ((context, animation, secondaryAnimation) =>
                                  const searchPage())));
                    },
                    icon: const Icon(
                      Icons.search,
                      color: Colors.blue,
                    )),
                IconButton(
                    onPressed: () {
                      Navigator.of(context).push(PageRouteBuilder(
                          pageBuilder:
                              ((context, animation, secondaryAnimation) =>
                                  const filterPage())));
                    }, //필터링 연결(filter_page.dart)
                    icon: const Icon(
                      Icons.filter_list,
                      color: Colors.blue,
                    )),
              ],
            )
          ]),
          // 현재 필터링 정보
          Row(
            children: [
              Text("filter info"),
            ],
          ),
          // 소그룹 목록
          Expanded(
            child: FirestoreListView<GroupMeet>(
              query: groupQuery,
              itemBuilder: (context, snapshot) {
                GroupMeet groupData = snapshot.data();

                return GroupList(groupData, snapshot.id, widget.userName);
              },
            ),
          ),
        ],
      ),
    );
  }
}
