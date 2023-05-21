class GroupMeet {
  String title = "";
  String content = "";
  List<DateTime?> dates = [DateTime.now()];
  int maxGroup = 1;
  String location = "";
  String tags = "";
  //필터링 대상용 추가 필요

  GroupMeet(String title, String content, List<DateTime?> dates, int maxGroup,
      String location, String tags);
}
