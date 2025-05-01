class User {
  final String id;
  final String name;
  final String email;
  final String phone;
  final String address;
  final bool confirmEmail;
  final String role;
  final String status;
  final String createdAt;
  final String updatedAt;
  final String code;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.address,
    required this.confirmEmail,
    required this.role,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.code,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['_id'],
      name: json['name'],
      email: json['email'],
      phone: json['phone'],
      address: json['address'],
      confirmEmail: json['confirmEmail'],
      role: json['role'],
      status: json['status'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      code: json['code'],
    );
  }
}

class ProfileResponse {
  final String message;
  final bool success;
  final User user;

  ProfileResponse({
    required this.message,
    required this.success,
    required this.user,
  });

  factory ProfileResponse.fromJson(Map<String, dynamic> json) {
    return ProfileResponse(
      message: json['message'],
      success: json['success'],
      user: User.fromJson(json['user']),
    );
  }
}
