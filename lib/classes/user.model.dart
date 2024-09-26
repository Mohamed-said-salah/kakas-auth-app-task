class UserModel {
  final int id;
  final String name;
  final String? email;
  final String? phone;
  final String referrerCode;
  final String accountState;
  final String createdAt;
  final String updatedAt;

  UserModel({
    required this.id,
    required this.name,
    this.email,
    this.phone,
    required this.referrerCode,
    required this.accountState,
    required this.createdAt,
    required this.updatedAt,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      phone: json['phone'],
      referrerCode: json['referrerCode'],
      accountState: json['accountState'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
    );
  }
}
