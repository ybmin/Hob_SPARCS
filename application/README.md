# Hob_SPARCS
미완/보완 내용 정리


- src/group.dart
GroupMeet 클래스 관리
Firebase로부터 읽어들인 소모임 정보들을 관리하기 위해 생성

- src/user.dart
UserName 클래스 관리
Firebase로부터 읽어들인 회원 정보들을 관리하기 위해 생성


- main.dart
- app.dart
초기화 및 Firebase 이메일과 비밀번호 방식으로 로그인 여부 확인에 따라 LoginPage나 Home으로 이동한다.
로그인이 되어있을 경우 Firebase의 users 컬랙션에서 회원정보를 찾아 userName으로 저장하여 관리한다.

    - login_page.dart
    로그인 화면.
    Firebase의 이메일과 비밀번호를 통한 로그인을 사용함.
    - register_page.dart
    회원가입 화면.
    이메일 비번, 이름, 닉네임을 받아서 Firebase의 user컬랙션에 저장하고 회원 가입을 진행함.



    - home.dart
    메인화면.
    하단 네비게이션 바를 통해 Home, GroupCreate, UserInfo 사이에서 이동 가능하다.
    Firebase의 group컬랙션을 읽어들여 리스트뷰로 띄워준다. 해당 카드를 클릭시에 GroupDetail로 해당 소모임 정보와 함께 이전된다.
    
        - search.dart
        Home의 검색 아이콘을 클릭시 이동하는 검색 화면.
        소모임의 제목과 내용에 대해 검색을 지원해, 해당 정보가 존재하는 소모임을 리스트로 보여준다.

        - filter_page.dart
        Home의 정렬 아이콘을 클릭시 이동하는 필터링 화면.
        Firebase상에 존재한 모든 문서의 태그를 종합하여, 체크박스 형태의 선택지로 제시하고 필터링을 통해 Home에서의 리스트뷰를 갱신한다.



    - group_create.dart
    소모임 생성 화면.
    GroupMeet의 항목을 모두 기입할 수 있도록 입력란이 구성되어있다. 장소의 경우 카카오 웹뷰를 가져와 지오코딩해 좌표를 구함. 날짜의 경우 캘린더를 통해 구성함.

    - user_info.dart
    회원 정보 화면.
    회원 정보와 로그아웃 버튼을 제시한다. 회원이 생성한 소모임과 참가한 소모임을 각각 리스트뷰로 표시한다. Home과 마찬가지로 소모임 카드를 클릭시 GroupDetail로 이전된다.





- group_detail.dart
소모임 상세 정보 화면.
GroupMeet 상의 정보를 표시해 준다. Google Map을 가져와 장소를 표현함. 또한 최대 인원 수와 현재 참여중인 인원을 Firebase에서 읽어와 리스트로 표시해준다. 
짧은 코멘트와 함께 소모임에 참여할 수 있다.(최대 인원을 넘거나, 중복되지 않는 한)