import 'package:electro_app_team/utils/app_assets.dart';
import 'package:flutter/material.dart';
import 'package:electro_app_team/models/product_model.dart';
import 'package:electro_app_team/utils/app_colors.dart';

class ProductDetailsScreen extends StatelessWidget {
  final ProductModel product;

  const ProductDetailsScreen({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          product.title,
          style: theme.textTheme.headlineMedium?.copyWith(
            fontWeight: FontWeight.w600,
            fontSize: 18,
            color: AppColors.blueColor,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.search_rounded,
              color: AppColors.blueColor,
              size: 25,
            ),
            onPressed: () {},
          ),
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: ImageIcon(
              AssetImage(AppAssets.cartIcon),
              color: Theme.of(context).primaryColor,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: AppColors.primaryColor, width: 2),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Stack(
                    alignment: Alignment.topRight,
                    children: [
                      Image.network(
                        product.image,
                        height: height * 0.3,
                        width: double.infinity,
                        fit: BoxFit.contain,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(Icons.favorite_border_rounded, size: 25),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),

            const SizedBox(height: 16),

            Text(
              product.title,
              style: theme.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: AppColors.blueColor,
              ),
            ),
            const SizedBox(height: 8),

            Row(
              children: [
                Text(
                  'EGP ${product.price}',
                  style: const TextStyle(
                    fontSize: 18,
                    color: Colors.grey,
                    decoration: TextDecoration.lineThrough,
                  ),
                ),
                const SizedBox(width: 10),
                Text(
                  'EGP ${product.priceAfterDiscount}',
                  style: const TextStyle(
                    fontSize: 22,
                    color: AppColors.blueColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),

            Row(
              children: [
                const Icon(Icons.star, color: Colors.amber),
                const SizedBox(width: 4),
                Text(
                  '${(double.tryParse(product.rateAvg) ?? 0).toStringAsFixed(1)} / 5',
                  style: theme.textTheme.bodyMedium,
                ),
              ],
            ),
            const SizedBox(height: 16),

            Text(
              product.description,
              style: theme.textTheme.bodyLarge?.copyWith(
                color: Colors.grey[700],
              ),
            ),
            const SizedBox(height: 24),

            Text("Available Colors", style: theme.textTheme.titleMedium),
            const SizedBox(height: 8),
            Row(
              children: [
                _colorOption(Colors.red),
                _colorOption(Colors.green),
                _colorOption(Colors.blue),
                _colorOption(Colors.orange),
              ],
            ),
            const SizedBox(height: 24),

            Text("Available Sizes", style: theme.textTheme.titleMedium),
            const SizedBox(height: 8),
            Row(
              children: [
                _sizeOption("S"),
                _sizeOption("M"),
                _sizeOption("L"),
                _sizeOption("XL"),
              ],
            ),
            const SizedBox(height: 32),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  backgroundColor: AppColors.primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () {},
                icon: const Icon(Icons.shopping_cart),
                label: const Text(
                  "Add to Cart",
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _colorOption(Color color) {
    return Container(
      margin: const EdgeInsets.only(right: 10),
      width: 32,
      height: 32,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
        border: Border.all(color: Colors.grey.shade300, width: 1),
      ),
    );
  }

  Widget _sizeOption(String size) {
    return Container(
      margin: const EdgeInsets.only(right: 10),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade400),
      ),
      child: Text(size),
    );
  }
}
