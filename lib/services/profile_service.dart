import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:electro_app_team/models/profile_model.dart'; // Import your ProfileResponse and User models

class ProfileService {
  final Dio dio;
  ProfileService({required this.dio});
  String baseUrl =
      "https://e-commerce-node-seven.vercel.app/api/v1"; // Replace with your actual API base URL

  Future<ProfileResponse?> getProfile(String token) async {
    try {
      // Send GET request with authorization header
      Response response = await dio.get(
        "$baseUrl/users", // Endpoint for fetching profile
        options: Options(
          headers: {
            'token': token, // Add the token to the Authorization header
          },
        ),
      );

      log("API Response: ${response.data.toString()}");

      // If the response status is 200, parse the profile data
      if (response.statusCode == 200) {
        // Assuming ProfileResponse has a fromJson method
        ProfileResponse profile = ProfileResponse.fromJson(response.data);
        log("Profile Loaded Successfully");
        return profile;
      } else {
        log("Failed to load profile: ${response.statusCode}");
        return null;
      }
    } on DioException catch (e) {
      // Handle Dio specific errors
      final String errorMessage =
          e.response?.data['message'] ?? "Oops, there was an error";
      log("Dio Exception: $errorMessage");
      return null;
    } catch (e) {
      // Handle other types of errors
      log("Exception: ${e.toString()}");
      return null;
    }
  }
}
