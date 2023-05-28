import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:hob_sparcs/app.dart';
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
              Text(gp.dates!.month.toString() + '/' + gp.dates!.day.toString(),
                  style: Theme.of(context).textTheme.titleMedium),
              const SizedBox(
                width: 15,
              ),
              Column(
                children: [
                  Text(
                    gp.title!,
                    softWrap: true,
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  Text(
                    "#" + gp.tags!,
                    style: Theme.of(context).textTheme.bodyLarge,
                    softWrap: true,
                  ),
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
  bool _finished = false;
  List<GroupMeet> groupList = [];
  List<String> groupIdList = [];
  List<GroupMeet> finalGroupList = [];
  List<String> finalGroupIdList = [];
  List<String> tagFilter = [];

  List<String> tagSummary() {
    List<String> allTags = [];
    for (var it in groupList) {
      allTags.addAll(it.tags!.split(r'[ ,.]'));
    }
    //중복 제거
    return allTags.toSet().toList();
  }

  Future getGroupData() async {
    //그룹 데이터 가져오기
    CollectionReference<Map<String, dynamic>> collectionReference =
        FirebaseFirestore.instance.collection("group");
    QuerySnapshot<Map<String, dynamic>> querySnapshot =
        await collectionReference.get();
    groupList.clear();
    groupIdList.clear();
    for (var doc in querySnapshot.docs) {
      final data = doc.data();
      groupList.add(GroupMeet(
        title: data["title"],
        content: data["content"],
        dates: DateTime.fromMillisecondsSinceEpoch(
            data["dates"].millisecondsSinceEpoch),
        maxGroup: data["maxGroup"],
        lat: double.parse(data["lat"].toString()),
        lon: double.parse(data["lon"].toString()),
        tags: data["tags"],
        creater: data['creater'],
      ));
      groupIdList.add(doc.id);
    }
    finalGroupList.clear();
    finalGroupIdList.clear();
    if (tagFilter.isEmpty) {
      finalGroupList.addAll(groupList);
      finalGroupIdList.addAll(groupIdList);
    } else {
      searchGroupData();
    }
  }

  void searchGroupData() {
    finalGroupList.clear();
    finalGroupIdList.clear();
    for (int index = 0; index < groupList.length; index++) {
      for (var it in tagFilter) {
        if ((groupList[index].tags!.contains(it))) {
          finalGroupList.add(groupList[index]);
          finalGroupIdList.add(groupIdList[index]);
        }
      }
    }
    finalGroupList.toSet().toList();
    finalGroupIdList.toSet().toList();
  }

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
          const SizedBox(
            height: 30,
          ),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text("Hob SPARCS", style: Theme.of(context).textTheme.displaySmall),
            Row(
              children: [
                IconButton(
                    onPressed: () {
                      Future(
                        () {
                          getGroupData();
                        },
                      );
                      Navigator.of(context).push(PageRouteBuilder(
                          pageBuilder: ((context, animation,
                                  secondaryAnimation) =>
                              SearchPage(groupList, groupIdList, userName))));
                    },
                    icon: Icon(
                      Icons.search,
                      color: Theme.of(context).primaryColor,
                      size: 20,
                      weight: 20,
                    )),
                IconButton(
                    onPressed: () {
                      tagFilter.clear();
                      Navigator.of(context).push(PageRouteBuilder(
                          pageBuilder: (context, animation,
                                  secondaryAnimation) =>
                              FilterPage(tagSummary(),
                                  callback: (value, finished) => setState(() {
                                        tagFilter = value;
                                        _finished = finished;
                                      }))));
                    }, //필터링 연결(filter_page.dart)
                    icon: Icon(
                      Icons.filter_list,
                      color: Theme.of(context).primaryColor,
                      size: 20,
                      weight: 20,
                    )),
              ],
            )
          ]),

          // 현재 필터링 정보
          Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Text("filter info:" + tagFilter.toString(),
                style: Theme.of(context).textTheme.bodyLarge),
          ),

          // 소그룹 목록
          Expanded(
            child: FutureBuilder(
              future: getGroupData(),
              builder: (context, snapshot) {
                return ListView.builder(
                    itemCount: finalGroupList.length,
                    itemBuilder: (context, index) {
                      return GroupList(finalGroupList[index],
                          finalGroupIdList[index], widget.userName);
                    });
              },
            ),
          ),
        ],
      ),
    );
  }
}
