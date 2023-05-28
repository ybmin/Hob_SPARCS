import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hob_sparcs/app.dart';
import 'package:hob_sparcs/src/group.dart';
import 'group_create.dart';
import 'src/user.dart';
import 'home.dart';

class UserInfom extends StatefulWidget {
  final UserName? userName;
  const UserInfom(this.userName, {super.key});

  @override
  State<UserInfom> createState() => _UserInfom();
}

class _UserInfom extends State<UserInfom> {
  final user = FirebaseAuth.instance.currentUser;
  List<GroupMeet> createdGroupList = [];
  List<String> createdGroupIdList = [];
  List<GroupMeet> joinedGroupList = [];
  List<String> joinedGroupIdList = [];

  Future getCreatedGroupData() async {
    CollectionReference<Map<String, dynamic>> collectionReference =
        FirebaseFirestore.instance.collection("group");
    QuerySnapshot<Map<String, dynamic>> querySnapshot =
        await collectionReference.get();
    createdGroupList.clear();
    createdGroupIdList.clear();
    for (var doc in querySnapshot.docs) {
      final data = doc.data();
      if (data['creater'] == userName.nickName) {
        createdGroupList.add(GroupMeet(
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
        createdGroupIdList.add(doc.id);
      }
    }
    return;
  }

  Future getJoinGroupData() async {
    CollectionReference<Map<String, dynamic>> collectionReference =
        FirebaseFirestore.instance.collection("group");
    QuerySnapshot<Map<String, dynamic>> querySnapshot =
        await collectionReference.get();
    joinedGroupList.clear();
    joinedGroupIdList.clear();
    for (var doc in querySnapshot.docs) {
      final data = doc.data();
      CollectionReference<Map<String, dynamic>> iCollectionReference =
          FirebaseFirestore.instance
              .collection("group")
              .doc(doc.id)
              .collection("user");
      QuerySnapshot<Map<String, dynamic>> iQuerySnapshot =
          await iCollectionReference.get();
      for (var userDoc in iQuerySnapshot.docs) {
        final userData = userDoc.data();
        if (userData["id"] == userName.nickName) {
          joinedGroupList.add(GroupMeet(
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
          joinedGroupIdList.add(doc.id);
        }
      }
    }
    return;
  }

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
                        Home(widget.userName)));
              } else if (value == 1) {
                Navigator.of(context).push(PageRouteBuilder(
                    pageBuilder: (context, animation, secondaryAnimation) =>
                        GroupCreate(widget.userName)));
              }
            }),
        body: Container(
          alignment: Alignment.center,
          child: Column(
            children: [
              const SizedBox(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const CircleAvatar(child: Icon(Icons.person)),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(widget.userName!.realName! +
                          " (" +
                          widget.userName!.nickName! +
                          ")"),
                      Text(user!.email.toString())
                    ],
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
                //참여중인 모임
              ),
              const SizedBox(height: 10),
              const Divider(
                color: Colors.grey,
              ),
              const SizedBox(height: 10),
              //내가 생성한 모임
              Text("생성한 모임"),
              Container(
                height: 300,
                child: FutureBuilder(
                  future: getCreatedGroupData(),
                  builder: (context, snapshot) {
                    return ListView.builder(
                        itemCount: createdGroupList.length,
                        itemBuilder: (context, index) {
                          return GroupList(createdGroupList[index],
                              createdGroupIdList[index], widget.userName);
                        });
                  },
                ),
              ),
              const SizedBox(height: 10),
              const Divider(
                color: Colors.grey,
              ),
              const SizedBox(height: 10),
              //내가 생성한 모임
              Text("참가한 모임"),
              Container(
                height: 300,
                child: FutureBuilder(
                  future: getJoinGroupData(),
                  builder: (context, snapshot) {
                    return ListView.builder(
                        itemCount: joinedGroupList.length,
                        itemBuilder: (context, index) {
                          return GroupList(joinedGroupList[index],
                              joinedGroupIdList[index], widget.userName);
                        });
                  },
                ),
              ),
            ],
          ),
        ));
  }
}
