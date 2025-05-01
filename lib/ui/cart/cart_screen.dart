import 'package:electro_app_team/cubits/cart/cart_state.dart';
import 'package:electro_app_team/cubits/cart/get_cart_cubit.dart';
import 'package:electro_app_team/utils/app_assets.dart';
import 'package:electro_app_team/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import '../../providers/language_provider.dart';
import '../../providers/theme_provider.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});
  static const String routeName = "CartScreen";

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  void initState() {
    super.initState();
    String token =
        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiI2ODAxMTIzN2E1NGVkNGExYTYyZjM2MTQiLCJlbWFpbCI6ImFuYTYwZG9kYUBnbWFpbC5jb20iLCJyb2xlIjoidXNlciIsImlhdCI6MTc0NTMwMzU0Mn0.ceAWk_n1OWRIf39_Q8BCqh-YUsBNon05Txjf9EAddf4";
    BlocProvider.of<GetCartCubit>(context).getUserCart(token);
  }

  @override
  Widget build(BuildContext context) {
    var themeProvider = Provider.of<ThemeProvider>(context);
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Row(
          children: [
            Text("Cart", style: Theme.of(context).textTheme.headlineLarge),
            const Spacer(),
            IconButton(
              onPressed: () {},
              icon: ImageIcon(
                AssetImage(AppAssets.searchIcon),
                color:
                    themeProvider.currentTheme == ThemeMode.light
                        ? AppColors.darkBlueColor
                        : AppColors.whiteColor,
              ),
            ),
            IconButton(
              onPressed: () {},
              icon: ImageIcon(
                AssetImage(AppAssets.addToCart),
                color:
                    themeProvider.currentTheme == ThemeMode.light
                        ? AppColors.darkBlueColor
                        : AppColors.whiteColor,
              ),
            ),
          ],
        ),
      ),
      body: BlocBuilder<GetCartCubit, CartState>(
        builder: (context, state) {
          if (state is CartLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is CartFailure) {
            return Center(
              child: Text(
                state.errorMessage,
                style: const TextStyle(color: Colors.red),
              ),
            );
          } else if (state is CartSuccess) {
            final cartItems = state.cart.cartItems;
            return _buildCartList(cartItems, width, height, themeProvider);
          }
          return const SizedBox();
        },
      ),
    );
  }

  Widget _buildCartList(cartItems, width, height, themeProvider) {
    return ListView.builder(
      itemCount: cartItems.length,
      itemBuilder: (context, index) {
        final item = cartItems[index];
        final product = item.product;

        return Container(
          margin: EdgeInsets.symmetric(
            horizontal: width * 0.03,
            vertical: height * 0.01,
          ),
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(width: 2, color: AppColors.primaryColor),
          ),
          child: Row(
            children: [
              Image.network(
                product.imageCover,
                width: 100,
                height: 100,
                fit: BoxFit.cover,
              ),
              SizedBox(width: width * 0.04),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.title,
                      style: Theme.of(context).textTheme.headlineSmall,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 5),
                    Text(
                      product.category.name,
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    const SizedBox(height: 5),
                    Text(
                      "${product.price} EGP",
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: AppColors.primaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: ImageIcon(
                      AssetImage(AppAssets.deleteIcon),
                      color:
                          themeProvider.currentTheme == ThemeMode.light
                              ? AppColors.darkBlueColor
                              : AppColors.whiteColor,
                    ),
                  ),
                  Row(
                    children: [
                      IconButton(
                        onPressed: () {},
                        icon: ImageIcon(
                          AssetImage(AppAssets.plusIcon),
                          color:
                              themeProvider.currentTheme == ThemeMode.light
                                  ? AppColors.darkBlueColor
                                  : AppColors.whiteColor,
                        ),
                      ),
                      Text(
                        item.quantity.toString(),
                        style: const TextStyle(
                          color: AppColors.primaryColor,
                          fontSize: 18,
                        ),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: ImageIcon(
                          AssetImage(AppAssets.minusIcon),
                          color:
                              themeProvider.currentTheme == ThemeMode.light
                                  ? AppColors.darkBlueColor
                                  : AppColors.whiteColor,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
