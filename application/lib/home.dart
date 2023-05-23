import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'search.dart';
import 'group_detail.dart';
import 'group_create.dart';
import 'user_info.dart';
import 'filter_page.dart';
import 'src/group.dart';

//소그룹 리스트 항목 제공
class GroupList extends StatelessWidget {
  const GroupList(GroupMeet gp, {super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {},
      title: Card(
          margin: const EdgeInsets.all(10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text("Date"),
              SizedBox(
                width: 15,
              ),
              Column(
                children: [
                  Text("title"),
                  Text("Tags"),
                ],
              )
            ],
          )),
    );
  }
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _Home();
}

class _Home extends State<Home> {
  final firestore = FirebaseFirestore.instance;
  int _index = 0;

  @override
  Widget build(BuildContext context) {
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
                      GroupCreate()));
            } else if (value == 2) {
              Navigator.of(context).push(PageRouteBuilder(
                  pageBuilder: (context, animation, secondaryAnimation) =>
                      UserInfom()));
            }
          }),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text("Hob SPARCS"),
            Row(
              children: [
                IconButton(
                    onPressed: () {
                      Navigator.of(context).push(PageRouteBuilder(
                          pageBuilder:
                              ((context, animation, secondaryAnimation) =>
                                  searchPage())));
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
                                  filterPage())));
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
            child: ListView.builder(
                itemBuilder: (BuildContext context, int index) {
              final firestore = FirebaseFirestore.instance;
              getData() async {
                final col = firestore
                    .collection("group")
                    .doc("0F4JQDIVXXhc4BM5PLJO")
                    .withConverter(
                      fromFirestore: GroupMeet.fromFirestore,
                      toFirestore: (GroupMeet groupMeet, _) =>
                          groupMeet.toFireStore(),
                    );
                final gp = await col.get();
                final groupData = gp.data();
                return GroupList(GroupMeet(
                    title: "title",
                    content: "content",
                    dates: [DateTime.now()],
                    maxGroup: index,
                    lat: 10,
                    lon: 10,
                    tags: "tags"));
                //GroupList(GroupMeet(gp.[index]["title"],gp.[index]["content"], gp.[index]["dates"],gp.[index]["maxGroup"],gp.[index]["location"][0],gp.[index]["location"][1],gp.[index]["tags"]));
              }
            }),
          )
        ],
      ),
    );
  }
}
