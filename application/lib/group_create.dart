import 'package:flutter/material.dart';
import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kpostal/kpostal.dart';

import 'app.dart';
import 'package:hob_sparcs/home.dart';
import 'user_info.dart';
import 'src/group.dart';
import 'src/user.dart';

class GroupCreate extends StatefulWidget {
  final UserName? userName;
  const GroupCreate(this.userName, {super.key});

  @override
  State<GroupCreate> createState() => _GroupCreate();
}

class _GroupCreate extends State<GroupCreate> {
  int _index = 1;
  final _titleController = TextEditingController();
  final _contentController = TextEditingController();
  final _maxGroupController = TextEditingController(text: "1");
  final _tagsController = TextEditingController();
  final _placeController = TextEditingController();
  String postCode = '-';
  String roadAddress = ' ';
  String jibunAddress = '-';
  String latitude = '-';
  String longitude = '-';
  String kakaoLatitude = '-';
  String kakaoLongitude = '-';
  List<DateTime?> _dates = [DateTime.now()];

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    _tagsController.dispose();
    _placeController.dispose();
    super.dispose();
  }

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
                      Home(widget.userName)));
            } else if (value == 2) {
              Navigator.of(context).push(PageRouteBuilder(
                  pageBuilder: (context, animation, secondaryAnimation) =>
                      UserInfom(widget.userName)));
            }
          }),
      body: Center(
        child: SingleChildScrollView(
          child: Column(children: [
            const SizedBox(
              height: 40,
            ),
            Text(
              "소모임 만들기",
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(
              height: 15,
            ),
            //방  제목
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  "소모임 제목",
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.white),
                    color: Colors.black12,
                  ),
                  margin: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                  padding: EdgeInsets.symmetric(horizontal: 25, vertical: 32),
                  height: 30,
                  width: 250,
                  child: TextField(
                    decoration: InputDecoration(border: InputBorder.none),
                    controller: _titleController,
                  ),
                ),
              ],
            ),
            //상세설명
            Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
              Text(
                "모임 소개",
                style: Theme.of(context).textTheme.titleMedium,
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.white),
                  color: Colors.black12,
                ),
                margin: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                padding: EdgeInsets.symmetric(horizontal: 25, vertical: 32),
                height: 30,
                width: 250,
                child: TextField(
                  decoration: InputDecoration(border: InputBorder.none),
                  controller: _contentController,
                ),
              ),
            ]),
            //위치
            TextButton(
              child: Text("장소 지정하기: " + roadAddress,
                  style: GoogleFonts.ibmPlexSansKr(
                      color: Theme.of(context).indicatorColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 20)),
              onPressed: () async {
                await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => KpostalView(
                      useLocalServer: false,
                      kakaoKey: '9ee22b6ba29b8f3fe3289f29fb92f62b',
                      callback: (Kpostal result) {
                        setState(() {
                          this.postCode = result.postCode;
                          this.roadAddress = result.address;
                          this.jibunAddress = result.jibunAddress;
                          this.latitude = result.latitude.toString();
                          this.longitude = result.longitude.toString();
                          this.kakaoLatitude = result.kakaoLatitude.toString();
                          this.kakaoLongitude =
                              result.kakaoLongitude.toString();
                        });
                      },
                    ),
                  ),
                );
              },
            ),
            //날짜
            CalendarDatePicker2(
              config: CalendarDatePicker2Config(
                calendarType: CalendarDatePicker2Type.single,
              ),
              value: _dates,
              onValueChanged: (dates) => setState(() {
                _dates = dates;
              }),
            ),
            //최대 인원
            Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
              Text(
                "최대 인원",
                style: Theme.of(context).textTheme.titleMedium,
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.white),
                  color: Colors.black12,
                ),
                margin: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                padding: EdgeInsets.symmetric(horizontal: 25, vertical: 32),
                height: 30,
                width: 250,
                child: TextField(
                  decoration: InputDecoration(border: InputBorder.none),
                  controller: _maxGroupController,
                  keyboardType: TextInputType.number,
                ),
              ),
            ]),
            //태그
            Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
              Text(
                "태그",
                style: Theme.of(context).textTheme.titleMedium,
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.white),
                  color: Colors.black12,
                ),
                margin: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                padding: EdgeInsets.symmetric(horizontal: 25, vertical: 32),
                height: 30,
                width: 250,
                child: TextField(
                  decoration: InputDecoration(border: InputBorder.none),
                  controller: _tagsController,
                ),
              ),
            ]),
            const SizedBox(
              height: 20,
            ),
            //등록
            Container(
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.white),
              ),
              padding: EdgeInsets.symmetric(horizontal: 25),
              child: TextButton(
                onPressed: () {
                  GroupMeet newGroup = GroupMeet(
                      title: _titleController.text.trim(),
                      content: _contentController.text.trim(),
                      dates: _dates[0],
                      maxGroup: int.parse(_maxGroupController.text.trim()),
                      lat: double.parse(latitude),
                      lon: double.parse(longitude),
                      tags: _tagsController.text.trim(),
                      creater: widget.userName!.nickName);
                  FirebaseFirestore.instance
                      .collection('group')
                      .add(newGroup.toFireStore())
                      .then((documentSnapshot) =>
                          print("Added Data with ID: ${documentSnapshot.id}"));
                  Navigator.of(context).push(PageRouteBuilder(
                      pageBuilder: (context, animation, secondaryAnimation) =>
                          Home(widget.userName)));
                },
                child: Text(
                  "소모임 생성",
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
