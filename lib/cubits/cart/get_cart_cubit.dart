import 'package:dio/dio.dart';
import 'package:electro_app_team/cubits/cart/cart_state.dart';
import 'package:electro_app_team/models/cart_model.dart';
import 'package:electro_app_team/services/get_user_cart.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GetCartCubit extends Cubit<CartState> {
  GetCartCubit() : super(CartInitial());
  final CartService cartService = CartService(dio: Dio());
  Future<void> getUserCart(String token) async {
    try {
      emit(CartLoading());
      CartModel cartModel = await cartService.getUserCart(token);
      emit(CartSuccess(cartModel));
    } on Exception catch (e) {
      emit(CartFailure(e.toString()));
    }
  }
}
