import 'package:dio/dio.dart';
import 'package:electro_app_team/models/cart_model.dart';

class CartService {
  final Dio dio;
  final String baseUrl = "https://e-commerce-node-seven.vercel.app/api/v1";

  CartService({required this.dio});

  Future<CartModel> getUserCart(String token) async {
    try {
      Response response = await dio.get(
        "$baseUrl/cart",
        options: Options(headers: {'token': token}),
      );

      return CartModel.fromJson(response.data);
    } on Exception catch (e) {
      final String errorMessage = e.toString();
      throw Exception(errorMessage);
    } catch (e) {
      throw Exception("An error occurred: ${e.toString()}");
    }
  }
}
