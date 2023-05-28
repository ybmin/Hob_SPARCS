import 'package:flutter/material.dart';

import 'home.dart';
import 'src/group.dart';
import 'src/user.dart';

class SearchPage extends StatefulWidget {
  final UserName? userName;
  final List<GroupMeet> groupList;
  final List<String> groupIdList;
  const SearchPage(this.groupList, this.groupIdList, this.userName,
      {super.key});

  @override
  State<SearchPage> createState() => _SearchPage();
}

class _SearchPage extends State<SearchPage> {
  final _keywordController = TextEditingController();

  List<GroupMeet> finalGroupList = [];
  List<String> finalGroupIdList = [];

  Future searchGroupData(String keywords) async {
    finalGroupList.clear();
    finalGroupIdList.clear();
    for (int index = 0; index < widget.groupList.length; index++) {
      if ((widget.groupList[index].title!.contains(keywords)) ||
          (widget.groupList[index].content!.contains(keywords))) {
        finalGroupList.add(widget.groupList[index]);
        finalGroupIdList.add(widget.groupIdList[index]);
      }
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _keywordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(children: [
          const SizedBox(height: 20),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Container(
              height: 50,
              width: 300,
              child: TextField(
                controller: _keywordController,
                onEditingComplete: () {
                  setState(() {
                    searchGroupData(_keywordController.text.trim());
                  });
                },
                decoration: InputDecoration(hintText: "소모임 검색"),
              ),
            ),
            IconButton(
              icon: Icon(Icons.search_rounded),
              onPressed: () {
                setState(() {
                  searchGroupData(_keywordController.text.trim());
                });
              },
            ),
          ]),
          Container(
            height: 500,
            width: 400,
            child: FutureBuilder(
              future: searchGroupData(_keywordController.text.trim()),
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
        ]),
      ),
    );
  }
}
