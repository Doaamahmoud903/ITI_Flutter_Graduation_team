import 'package:dio/dio.dart';
import 'package:electro_app_team/models/change_password_Response_model.dart';

class ChangePasswordService {
  final Dio dio;
  final String baseUrl = "https://e-commerce-node-seven.vercel.app/api/v1";
  ChangePasswordService({required this.dio});

  Future<ChangePasswordResponseModel> changePassword({
    required String currentPassword,
    required String newPassword,
    required String token,
  }) async {
    try {
      Response response = await dio.put(
        "$baseUrl/users/update-account",
        data: {'currentPassword': currentPassword, 'newPassword': newPassword},
        options: Options(headers: {'token': token}),
      );

      return ChangePasswordResponseModel.fromJson(response.data);
    } on DioException catch (e) {
      print('🔴 Dio Error: ${e.response?.data}');
      throw Exception(e.response?.data['message'] ?? 'Something went wrong');
    }
  }
}
