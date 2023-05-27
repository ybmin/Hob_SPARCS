import 'dart:async';
import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:hob_sparcs/home.dart';
import 'src/group.dart';
import 'src/user.dart';

class GroupDetail extends StatefulWidget {
  final GroupMeet? groupMeet;
  final String? id;
  final UserName? userName;
  const GroupDetail(this.groupMeet, this.id, this.userName, {super.key});

  @override
  State<GroupDetail> createState() => _GroupDetail();
}

class _GroupDetail extends State<GroupDetail> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();
  final _statusController = TextEditingController();
  final user = FirebaseAuth.instance.currentUser;

  Future<List<JoinedUser>> getData() async {
    List<JoinedUser> userData = [];
    CollectionReference<Map<String, dynamic>> collectionReference =
        FirebaseFirestore.instance
            .collection("group")
            .doc(widget.id)
            .collection("user");
    QuerySnapshot<Map<String, dynamic>> querySnapshot =
        await collectionReference.get();
    for (var doc in querySnapshot.docs) {
      final data = doc.data();
      userData.add(JoinedUser(data['id'], data['status']));
    }
    return userData;
  }

  void dispose() {
    _statusController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cameraInitial = CameraPosition(
        target: LatLng(widget.groupMeet!.lat!, widget.groupMeet!.lon!),
        zoom: 15);
    List<JoinedUser> userData = [];
    userData.add(JoinedUser(widget.groupMeet!.creater!, "⭐방장⭐"));
    getData().then((List<JoinedUser> result) {
      setState(() {
        userData.addAll(result);
      });
    });
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text("소모임 상세 보기"),
        bottomOpacity: 0.0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new_sharp),
          onPressed: () {
            Navigator.pushAndRemoveUntil(
                context,
                PageRouteBuilder(
                    pageBuilder: (context, animation, secondaryAnimation) {
                  return Home(widget.userName);
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
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 40,
              ),
              //활동 제목
              Text(
                widget.groupMeet!.title!,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Container(
                  padding: EdgeInsets.symmetric(horizontal: 30),
                  alignment: Alignment.topRight,
                  child: Text("방장: " + widget.groupMeet!.creater!)),
              const SizedBox(
                height: 15,
              ),
              const Divider(color: Colors.grey),
              const SizedBox(
                height: 15,
              ),
              Text(
                widget.groupMeet!.dates!.year.toString() +
                    "년 " +
                    widget.groupMeet!.dates!.month.toString() +
                    "월 " +
                    widget.groupMeet!.dates!.day.toString() +
                    "일 ",
                softWrap: true,
              ),
              const SizedBox(
                height: 15,
              ),
              const Divider(color: Colors.grey),
              Text(widget.groupMeet!.content!),
              const SizedBox(
                height: 10,
              ),
              Text(
                "#" + widget.groupMeet!.tags!,
                softWrap: true,
              ),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.width * 2 / 3,
                width: MediaQuery.of(context).size.width * 2 / 3,
                child: GoogleMap(
                  markers: {
                    Marker(
                      markerId: MarkerId("집합 장소"),
                      position: LatLng(
                          widget.groupMeet!.lat!, widget.groupMeet!.lon!),
                    ),
                  },
                  initialCameraPosition: cameraInitial,
                  onMapCreated: (GoogleMapController controller) {
                    _controller.complete(controller);
                  },
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const Divider(color: Colors.grey),

              //현재 join중인 사람들 목록
              Text(userData.length.toString() +
                  "/" +
                  widget.groupMeet!.maxGroup!.toString()),
              Container(
                height: 100,
                margin: EdgeInsets.all(5.0),
                padding: EdgeInsets.symmetric(vertical: 8.0),
                child: ListView.builder(
                    itemCount: userData.length,
                    itemBuilder: ((context, index) {
                      return Card(
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(userData[index].id!),
                              Text(userData[index].status!)
                            ]),
                      );
                    })),
              ),
              const SizedBox(
                height: 15,
              ),
              Container(
                alignment: Alignment.center,
                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 5),
                child: TextField(
                  controller: _statusController,
                  decoration: InputDecoration(hintText: "코멘트 추가(늦참, 준비물 등등)"),
                ),
              ),
              TextButton(
                  onPressed: () {
                    if (userData.length < widget.groupMeet!.maxGroup!) {
                      for (var name in userData) {
                        if (name.id == widget.userName!.nickName) {
                          //이미 존재
                        } else {
                          //인원진에 포함
                        }
                      }
                    } else {
                      //인원 초과
                    }
                    /*1. 인원 제한 확인
                    2. firebase-group-ID-user에 이미 존재하는 id인지 확인하고 문서 작성*/
                  },
                  child: (userData.length < widget.groupMeet!.maxGroup!)
                      ? Text("참여하기")
                      : Text("모집 마감된 소모임입니다."))
            ],
          ),
        ),
      ),
    );
  }
}
