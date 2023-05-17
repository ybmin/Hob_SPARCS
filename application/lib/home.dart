import 'package:flutter/material.dart';
import 'package:flutterfire_ui/firestore.dart';
import 'firebase_options.dart';

import 'search.dart';
import 'group_detail.dart';
import 'group_create.dart';
import 'user_info.dart';

//소그룹 리스트 항목 제공
class GroupList extends StatelessWidget {
  const GroupList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {},
      title: Card(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("Date"),
          Row(
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

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 홈, 방 생성, 회원 정보 창 네비게이션바
      bottomNavigationBar: BottomNavigationBar(
        items: [],
        onTap: (value) {},
      ),
      body: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Column(children: [
            Text("Hob SPARCS"),
            IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.search,
                  color: Colors.white,
                ))
          ]),
          // 현재 필터링 정보
          Column(
            children: [
              Text("filter info"),
            ],
          ),
          // 소그룹 목록
          ListView(),
        ],
      ),
    );
  }
}
