# Hob_SPARCS
미완/보완 내용 정리
**** FireBase 연결 문제로 일단 db연결 보류. ****


- main.dart

- user_info.dart
:
본인이 만든 소모임 관리


- group_detail.dart
1. 인원 제한 확인
2. firebase-group-ID-user에 이미 존재하는 id인지 확인하고 문서 작성


- search.dart
- filter_page.dart

GroupMeet가 필요한가?
그냥 Map으로 저장하는게 필터링과 같은 기능 성능 개선에 도움이 되지 않을까?
그렇다면 home.dart 내에서 실시간으로 필터링해서 listview를 리프레쉬해서 표현이 가능함.