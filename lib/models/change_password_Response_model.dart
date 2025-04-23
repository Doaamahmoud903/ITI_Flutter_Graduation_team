class ChangePasswordResponseModel {
  final String message;
  final bool success;

  ChangePasswordResponseModel({required this.message, required this.success});

  factory ChangePasswordResponseModel.fromJson(Map<String, dynamic> json) {
    return ChangePasswordResponseModel(
      message: json['message'],
      success: json['success'],
    );
  }
}
