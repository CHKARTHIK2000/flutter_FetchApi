class UserModel {
  
  final String name;
  final String email;
  final String username;
  

  UserModel({
    required this.name,
    required this.email,
    required this.username,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      name: json["name"],
      username: json["username"],
      email: json["email"],
    );
  }
}
