import 'package:electro_app_team/models/cart_model.dart';

abstract class CartState {}

class CartInitial extends CartState {}

class CartLoading extends CartState {}

class CartSuccess extends CartState {
  final CartModel cart;
  CartSuccess(this.cart);
}

class CartFailure extends CartState {
  final String errorMessage;
  CartFailure(this.errorMessage);
}
