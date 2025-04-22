class ProfileModel {
  final String name;
  final String email;

  final String mobileNumber;
  final String address;

  ProfileModel({
    required this.name,
    required this.email,
    required this.mobileNumber,
    required this.address,
  });

  factory ProfileModel.fromJson(json) {
    return ProfileModel(
      name: json['user']['name'],
      email: json['user']['email'],
      mobileNumber: json['user']['phone'],
      address: json['user']['address'],
    );
  }
}
