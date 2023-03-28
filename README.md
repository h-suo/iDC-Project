# iDC-Project

### 'iOS Developer Community' iOS 개발자들을 위함 커뮤니티앱
- MVVM 아키텍쳐 패턴을 사용하여 코드를 Model, View, ViewModel로 나누어 구현하였습니다.
- Firebase와 연결하여 서버에서 게시글을 가져오고, 올릴 수 있도록 구현하였습니다.
- FirebaseDB에 접근하는 코드는 모두 FirebaseDB 코드를 만들어 따로 관리하였고, 게시물을 가져오고 처리하는 일은 ViewModel이 처리하도록 만들었습니다. ViewController는 View와 관련된 코드만 있도록 정리하였습니다.
- 게시글의 Model을 만들어 데이터를 관리하기 편하게 하였고, FirebaseDB에서 데이터를 가져올 때 딕셔너리로 가져오는 것을 토대로 초기화할 수 있도록 코드를 작성하였습니다.
- Apple 로그인 기능으로 앱을 처음 시작할 때 로그인 할 수 있도록 하였고, 로그인 정보 중 사용자 ID만 저장하여 게시글을 작성할 때 누가 작성한 것인지 알 수 있도록 Model값에 userIdentifier를 추가하여 관리하였습니다.
