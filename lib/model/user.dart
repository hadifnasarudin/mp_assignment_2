class User {
  final String userId;
  final String userName;
  final String userEmail;
  final String userPhone;
  final String userAddress;

  User({
    required this.userId,
    required this.userName,
    required this.userEmail,
    required this.userPhone,
    required this.userAddress,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
<<<<<<< HEAD
      userId: json['id']?.toString() ?? '',
=======
      userId: json['id'].toString() ?? '',
>>>>>>> 6e02cbf471cb74e4033fc5c6aeb04cedb3ee2499
      userName: json['name'] ?? '',
      userEmail: json['email'] ?? '',
      userPhone: json['phone'] ?? '',
      userAddress: json['address'] ?? '',
    );
  }
}
