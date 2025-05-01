import 'package:dio/dio.dart';
import 'package:electro_app_team/models/profile_model.dart';

class ProfileService {
  final Dio dio;
  final String baseUrl = "https://e-commerce-node-seven.vercel.app/api/v1";
  ProfileService({required this.dio});

  Future<ProfileModel> getProfileData(String token) async {
    try {
      Response response = await dio.get(
        "$baseUrl/users",
        options: Options(headers: {'token': token}),
      );
      ProfileModel profileModel = ProfileModel.fromJson(response.data);
      return profileModel;
    } on DioException catch (e) {
      final String errorMessage =
          e.response?.data['message'] ?? "Oops there is an Error";
      throw Exception(errorMessage);
    } catch (e) {
      throw Exception("An error occurred: ${e.toString()}");
    }
  }
}
