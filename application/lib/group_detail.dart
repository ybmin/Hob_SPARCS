import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'src/group.dart';

class GroupDetail extends StatefulWidget {
  final GroupMeet? groupMeet;
  const GroupDetail(this.groupMeet, {super.key});

  @override
  State<GroupDetail> createState() => _GroupDetail();
}

class _GroupDetail extends State<GroupDetail> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();
  static final cameraInitial = CameraPosition(
      target: LatLng(widget.groupMeet.lat, widget.groupMeet.lon), zoom: 15);
  String _status;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      //찜하기 버튼
      floatingActionButton: IconButton(
        onPressed: () {},
        icon: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          //활동 제목
          Text(
            widget.groupMeet.title,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 15,
          ),
          Text(widget.groupMeet.content),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              //위치
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
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                // 상세 정보
                children: [
                  Text(widget.groupMeet.dates.toString()),
                  Text(widget.groupMeet.tags),
                ],
              ),
            ],
          ),
          //현재 join중인 사람들 목록
          const SizedBox(
            height: 15,
          ),
          TextField(
            onChanged: (status) => _status = status,
          ),
          TextButton(
              onPressed: () {
                /*1. 인원 제한 확인
                2. firebase-group-ID-user에 이미 존재하는 id인지 확인하고 문서 작성*/
              },
              child: Text("참여하기"))
        ],
      ),
    );
  }
}
