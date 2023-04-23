# iDC-Project

### 'iOS Developer Community' iOS 개발자들을 위함 커뮤니티앱
- MVVM 아키텍쳐 패턴을 사용하여 코드를 Model, View, ViewModel로 나누어 구현하였습니다.
- Firebase와 연결하여 서버에서 게시글을 가져오고, 올릴 수 있도록 구현하였습니다.
  ```swift
  class FirebaseDB {
    
    var db: Firestore = Firestore.firestore()
    var posts: [PostForm] = []
    
    // MARK: - Function Code
    func getPost() async throws -> [PostForm] {
        let collectionRefernece = db.collection("Post")
        let querySnapshot = try await collectionRefernece
            .order(by: "time", descending: true)
            .getDocuments()
        
        var posts: [PostForm] = []
        for document in querySnapshot.documents {
            guard let post = PostForm(dictionary: document.data(), documentID: document.documentID) else { throw NSError(domain: "Error getting documents", code: 404) }
            posts.append(post)
        }
        
        print("Get Post Success")
        
        return posts
    }
    
    //...
    
  }
  ```
  
- FirebaseDB에 접근하는 코드는 모두 FirebaseDB 코드를 만들어 따로 관리하였고, 게시물을 가져오고 처리하는 일은 ViewModel이 처리하도록 만들었습니다. ViewController는 View와 관련된 코드만 있도록 정리하였습니다.
  ```swift
  class PostListViewModel {
    
    private var postList: [PostForm] = []
    let firebase = FirebaseDB()
  }

  // MARK: - IntPut
  extension PostListViewModel {

    func getPost() async throws {
        let postList = try await firebase.getPost()
        self.postList = postList
    }
    
    func searchPost(keyword: String) async throws {
        let postList = try await firebase.searchPost(keyword: keyword)
        self.postList = postList
    }
  }

  // MARK: - Output
  extension PostListViewModel {
    
    var numberOfSections: Int {
        return 1
    }
    
    func numberOfRowsInSection(_ section: Int) -> Int {
        return self.postList.count
    }
    
    func postAtIndex(_ index: Int) -> PostViewModel {
        let post = self.postList[index]
        return PostViewModel(post)
    }
  }
  ```
  
- 게시글의 Model을 만들어 데이터를 관리하기 편하게 하였고, FirebaseDB에서 데이터를 가져올 때 딕셔너리로 가져오는 것을 토대로 초기화할 수 있도록 코드를 작성하였습니다.
  ```swift
  struct PostForm {
    var id: String
    var title: String
    var description: String
    var comment: [String]
    var time: String
    
    init (id: String, title: String, description: String, comment: [String], time: String) {
        self.id = id
        self.title = title
        self.description = description
        self.comment = comment
        self.time = time
    }
    
    init?(dictionary: [String:Any], documentID: Any) {
        self.id = documentID as! String
        self.title = dictionary["title"] as! String
        self.description = dictionary["description"] as! String
        self.comment = dictionary["comment"] as! [String]
        self.time = dictionary["time"] as! String
    }
  }
  ```
- Apple 로그인 기능으로 앱을 처음 시작할 때 로그인 할 수 있도록 하였습니다.
Apple 문서: https://developer.apple.com/documentation/sign_in_with_apple/implementing_user_authentication_with_sign_in_with_apple

- 사용자 관리를 위해 Apple 로그인을 할 때 Firebase도 sign in 할 수 있도로 설정하였고 Firebase에 로그인 될 때 사용되는 UID를 키체인으로 저장하여 사용자가 작성하는 게시물에 UID 항목을 추가하여 사용자가 본인이 쓴 게시물을 관리하 수 있도로 하였습니다.
  ```swift
  // LoginViewModel
  // Firebase sign in
  FirebaseAuth.Auth.auth().signIn(with: credential) { (authResult, error) in
                
      if let user = authResult?.user {
          // UID 키체인으로 저장
          KeychainWrapper.standard.set(user.uid, forKey: "UID")
          print("Login Success: ", user.uid, user.email ?? "-")
          self.onLoginSuccess?()
      } else if let error = error {
          print(error.localizedDescription)
          return
      }
  }
  ```
  
  ```swift
  // PostViewModel
  func writePost(title: String, description: String, time: String) {
      // 키체인으로 저장한 UID를 가져와 게시글 작성
      let UID = KeychainWrapper.standard.string(forKey: "UID")!
      let newWritePost: WritePostForm = WritePostForm(UID: UID, title: title, description: description, comment: [], time: time)
      firebase.writePost(newWritePost)
  }
  ```
  
