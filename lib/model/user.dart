class User {
  final String userId;
  final String userName;
  final String userEmail;
  final String userPhone;
  final String userAddress;

  User({
    required this.userId,
    required this.userName,
    required this.userEmail,  // fixed typo here: was 'tChis.userEmail'
    required this.userPhone,
    required this.userAddress,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      userId: json['id']?.toString() ?? '',  // use only once
      userName: json['name'] ?? '',
      userEmail: json['email'] ?? '',
      userPhone: json['phone'] ?? '',
      userAddress: json['address'] ?? '',
    );
  }
}
