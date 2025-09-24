import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:e_commerce_flutter/features/home/views/widgets/product_controller.dart';
import 'package:e_commerce_flutter/features/home/views/widgets/product_grid_view.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          "Favorites",
          style: Theme.of(context).textTheme.displayLarge,
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: GetBuilder<ProductController>(
          init: Get.find<ProductController>()..getFavoriteItems(),
          builder: (controller) {
            final favoriteItems = controller.filteredProducts;

            if (favoriteItems.isEmpty) {
              return const Center(
                child: Text(
                  "No favorite items yet.",
                  style: TextStyle(fontSize: 18, color: Colors.grey),
                ),
              );
            }

            return ProductGridView(
              items: favoriteItems,
              likeButtonPressed: (index) => controller.isFavorite(index),
              isPriceOff: (product) => controller.isPriceOff(product),
            );
          },
        ),
      ),
    );
  }
}
