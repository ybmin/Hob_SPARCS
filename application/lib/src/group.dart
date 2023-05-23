import 'package:cloud_firestore/cloud_firestore.dart';

class GroupMeet {
  final String? title;
  final String? content;
  final List<DateTime?>? dates;
  final int? maxGroup;
  //위도, 경도
  final double? lat;
  final double? lon;
  final String? tags;
  //필터링 대상용 추가 (경우에 따라 필요)

  GroupMeet(
      {this.title,
      this.content,
      this.dates,
      this.maxGroup,
      this.lat,
      this.lon,
      this.tags});

  // firestore data converter
  factory GroupMeet.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return GroupMeet(
      title: data?["title"],
      content: data?["content"],
      dates: data?["dates"],
      maxGroup: data?["maxGroup"],
      lat: data?["lat"],
      lon: data?["lon"],
      tags: data?["tags"],
    );
  }

  Map<String, dynamic> toFireStore() {
    return {
      if (title != null) "title": title,
      if (content != null) "title": content,
      if (dates != null) "title": dates,
      if (maxGroup != null) "title": maxGroup,
      if (lat != null) "title": lat,
      if (lon != null) "title": lon,
      if (tags != null) "title": tags,
    };
  }
}
