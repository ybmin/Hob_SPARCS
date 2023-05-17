import 'package:flutter/material.dart';

class GroupDetail extends StatelessWidget {
  const GroupDetail({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //찜하기 버튼
      floatingActionButton: IconButton(
        onPressed: () {},
        icon: const Icon(Icons.add),
        style: ButtonStyle(),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      body: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //활동 제목
          Text("title"),
          Column(
            children: [
              //위치
              SizedBox(
                child: Text("Map"),
                height: 10,
                width: 10,
              ),
              Row(
                // 상세 정보
                children: [
                  Text("tags"),
                  Text("time available"),
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}
