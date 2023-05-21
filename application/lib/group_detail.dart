import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'src/group.dart';

class GroupDetail extends StatefulWidget {
  const GroupDetail({super.key});

  @override
  State<GroupDetail> createState() => _GroupDetail();
}

class _GroupDetail extends State<GroupDetail> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();
  static const cameraInitial = CameraPosition(
      target: LatLng(36.374171854421185, 127.36037368774652), zoom: 15);

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
          Text("title"),
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
                children: const [
                  Text("tags"),
                  Text("time available"),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}
