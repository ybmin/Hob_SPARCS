import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';

import 'package:hob_sparcs/home.dart';
import 'user_info.dart';
import 'src/group.dart';

class GroupCreate extends StatefulWidget {
  const GroupCreate({super.key});

  @override
  State<GroupCreate> createState() => _GroupCreate();
}

class _GroupCreate extends State<GroupCreate> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();
  static const cameraInitial = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );
  final firestore = FirebaseFirestore.instance;
  int _index = 1;
  String _title = "";
  String _content = "";
  List<DateTime?> _dates = [DateTime.now()];
  int _maxGroup = 1;
  String _tags = "";

  @override
  Widget build(BuildContext context) {
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
            } else if (value == 2) {
              Navigator.of(context).push(PageRouteBuilder(
                  pageBuilder: (context, animation, secondaryAnimation) =>
                      UserInfom()));
            }
          }),
      body: SingleChildScrollView(
        child: Column(children: [
          const Text("소모임 만들기", style: TextStyle(fontSize: 20)),
          const SizedBox(
            height: 15,
          ),
          //방  제목
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const Text("소모임 제목"),
              SizedBox(
                height: 30,
                width: 250,
                child: TextField(
                  key: null,
                  enabled: true,
                  onChanged: (title) => _title = title,
                ),
              ),
            ],
          ),
          //상세설명
          Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
            const Text("모임 소개"),
            SizedBox(
              height: 100,
              width: 250,
              child: TextField(
                expands: true,
                maxLines: null,
                minLines: null,
                key: null,
                enabled: true,
                onChanged: (content) => _content = content,
              ),
            ),
          ]),
          //카테고리
          //날짜
          CalendarDatePicker2(
            config: CalendarDatePicker2Config(
              calendarType: CalendarDatePicker2Type.single,
            ),
            value: _dates,
            onValueChanged: (dates) {
              _dates = dates;
            },
          ),
          //위치
          const Text("위치"),
          SizedBox(
            height: 300,
            width: 300,
            child: GoogleMap(
              initialCameraPosition: cameraInitial,
              onMapCreated: (GoogleMapController controller) {
                _controller.complete(controller);
              },
            ),
          ),
          //태그
          Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
            const Text("태그"),
            SizedBox(
              height: 30,
              width: 250,
              child: TextField(
                onChanged: (tags) => _tags = tags,
              ),
            ),
          ]),
          //등록
          TextButton(
            onPressed: () {
              GroupMeet newGroup = GroupMeet(
                  title: _title,
                  content: _content,
                  dates: _dates[0],
                  maxGroup: _maxGroup,
                  lat: 0,
                  lon: 0,
                  tags: _tags,
                  creater: 131);
              firestore.collection('group').add(newGroup.toFireStore()).then(
                  (documentSnapshot) =>
                      print("Added Data with ID: ${documentSnapshot.id}"));
              showDialog(
                  context: context,
                  builder: (context) {
                    return const Dialog(child: Text("Create!!!"));
                  });
            },
            child: const Text("소모임 생성"),
          ),
        ]),
      ),
    );
  }
}
