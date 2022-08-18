class UserModel {
  String userName;
  String email;
  String token;

  UserModel({required this.userName,
    required this.email,
    required this.token,});

  Map<String, dynamic> toMap() {
    return {
      'userName': userName,
      'email': email,
      'token': token,

    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      userName: map['userName'] as String,
      email: map['email'] as String,
      token: map['token'] as String,
    );
  }
}
