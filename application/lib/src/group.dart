import 'package:cloud_firestore/cloud_firestore.dart';

class GroupMeet {
  final String? title;
  final String? content;
  final DateTime? dates;
  final int? maxGroup;
  //위도, 경도
  final double? lat;
  final double? lon;
  final String? tags;
  final int? creater;
  //필터링 대상용 추가 (경우에 따라 필요)

  GroupMeet(
      {this.title,
      this.content,
      this.dates,
      this.maxGroup,
      this.lat,
      this.lon,
      this.tags,
      this.creater});

  // firestore data converter
  factory GroupMeet.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return GroupMeet(
      title: data?["title"],
      content: data?["content"],
      dates: DateTime.fromMillisecondsSinceEpoch(
          data?["dates"].millisecondsSinceEpoch),
      maxGroup: data?["maxGroup"],
      lat: data?["lat"],
      lon: data?["lon"],
      tags: data?["tags"],
      creater: data?['creater'],
    );
  }

  Map<String, dynamic> toFireStore() {
    return {
      if (title != null) "title": title,
      if (content != null) "content": content,
      if (dates != null)
        "dates":
            Timestamp.fromMillisecondsSinceEpoch(dates!.millisecondsSinceEpoch),
      if (maxGroup != null) "maxGroup": maxGroup,
      if (lat != null) "lat": lat,
      if (lon != null) "lon": lon,
      if (tags != null) "tags": tags,
      if (creater != null) "creater": creater,
    };
  }
}
