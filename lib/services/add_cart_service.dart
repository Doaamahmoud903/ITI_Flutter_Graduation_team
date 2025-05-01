import 'package:dio/dio.dart';
import 'package:electro_app_team/models/add_cart_model.dart';

class AddCartService {
  final Dio dio;
  final String baseUrl = "https://e-commerce-node-seven.vercel.app/api/v1";

  AddCartService({required this.dio});

  Future<AddCartModel> addToCart({
    required String productId,
    required int quantity,
    required String token,
  }) async {
    try {
      final response = await dio.post(
        '$baseUrl/cart',
        data: {'productId': productId, 'quantity': quantity},
        options: Options(headers: {'token': token}),
      );

      return AddCartModel.fromJson(response.data);
    } on DioException catch (e) {
      throw Exception(e.response?.data['message'] ?? 'Something went wrong');
    } catch (e) {
      throw Exception('Something went wrong');
    }
  }
}
