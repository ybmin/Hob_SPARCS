import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:hobSparcs/home.dart';
import 'user_info.dart';
import 'src/group.dart';

class GroupCreate extends StatefulWidget {
  const GroupCreate({super.key});

  @override
  State<GroupCreate> createState() => _GroupCreate();
}

class _GroupCreate extends State<GroupCreate> {
  @override
  Widget build(BuildContext context) {
    GroupMeet newGroup = GroupMeet("", "", [DateTime.now()], 1, "", "");
    int _index = 1;
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
      body: Column(children: [
        const Text("소모임 만들기"),
        //방  제목
        SizedBox(
          height: 30,
          child: TextField(
            key: null,
            enabled: true,
            onChanged: (title) => newGroup.title = title,
          ),
        ),
        //상세설명
        SizedBox(
          height: 30,
          child: TextField(
            onChanged: (content) => newGroup.content = content,
          ),
        ),
        //카테고리
        //날짜
        CalendarDatePicker2(
          config: CalendarDatePicker2Config(
            calendarType: CalendarDatePicker2Type.multi,
          ),
          value: newGroup.dates,
          onValueChanged: (dates) => newGroup.dates = dates,
        ),
        //위치
        //태그
        SizedBox(
          height: 30,
          child: TextField(
            onChanged: (tags) => newGroup.tags = tags,
          ),
        ),
        //등록
        TextButton(
          onPressed: () {},
          child: const Text("소모임 생성"),
        ),
      ]),
    );
  }
}
