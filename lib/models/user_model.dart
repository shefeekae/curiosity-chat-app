class UserModel {
  final String name;
  final String uid;
  final String profilePic;
  final bool isOnline;

  UserModel(
      {required this.profilePic,
      required this.uid,
      required this.name,
      required this.isOnline});

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'uid': uid,
      'profilePic': profilePic,
      'isOnline': isOnline
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      name: map['name'] ?? '',
      uid: map['uid'] ?? '',
      profilePic: map['profilePic'] ?? '',
      isOnline: map['isOnline'] ?? false,
    );
  }
}
