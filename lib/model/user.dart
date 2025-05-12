class User {
  String userId;
  String userName;
  String userEmail;
  String userPhone;
  String userAddress;

  User({
    required this.userId,
    required this.userName,
    required this.userEmail,
    required this.userPhone,
    required this.userAddress,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      userId: json['id'],
      userName: json['name'],
      userEmail: json['email'],
      userPhone: json['phone'],
      userAddress: json['address'],
    );
  }
}
