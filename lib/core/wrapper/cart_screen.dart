import 'package:e_commerce_flutter/core/utils/animated_switcher_wrapper.dart';
import 'package:e_commerce_flutter/core/utils/product.dart';
import 'package:e_commerce_flutter/core/wrapper/payment_screen.dart';
import 'package:e_commerce_flutter/features/home/views/widgets/product_controller.dart';
import 'package:e_commerce_flutter/features/onboarding/views/empty_cart.dart';
import 'package:e_commerce_flutter/features/onboarding/views/extensions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final ProductController controller = Get.put(ProductController());

  @override
  void initState() {
    super.initState();
    controller.getCartItems();
  }

  PreferredSizeWidget _appBar(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false, // شيل السهم من AppBar
      title: Text(
        "My cart",
        style: Theme.of(context).textTheme.displayLarge,
      ),
    );
  }

  Widget cartList() {
    return ListView.builder(
      padding: const EdgeInsets.only(bottom: 10),
      itemCount: controller.cartProducts.length,
      itemBuilder: (context, index) {
        Product product = controller.cartProducts[index];
        return Container(
          width: double.infinity,
          margin: const EdgeInsets.all(15),
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 5),
          decoration: BoxDecoration(
            color: Colors.grey[200]?.withOpacity(0.6),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            children: [
              Expanded(
                flex: 3,
                child: Container(
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: ColorExtension.randomColor,
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Padding(
                      padding: const EdgeInsets.all(5),
                      child: Image.asset(
                        product.images[0],
                        width: 100,
                        height: 90,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                flex: 5,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.name.nextLine,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 15,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      controller.getCurrentSize(product),
                      style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      controller.isPriceOff(product)
                          ? "\$${product.off}"
                          : "\$${product.price}",
                      style: const TextStyle(
                        fontWeight: FontWeight.w900,
                        fontSize: 23,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      splashRadius: 10.0,
                      onPressed: () => controller.decreaseItemQuantity(product),
                      icon: const Icon(
                        Icons.remove,
                        color: Color(0xFFEC6813),
                      ),
                    ),
                    Obx(() {
                      return AnimatedSwitcherWrapper(
                        child: Text(
                          '${controller.cartProducts[index].quantity}',
                          key: ValueKey<int>(
                            controller.cartProducts[index].quantity,
                          ),
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      );
                    }),
                    IconButton(
                      splashRadius: 10.0,
                      onPressed: () => controller.increaseItemQuantity(product),
                      icon: const Icon(
                        Icons.add,
                        color: Color(0xFFEC6813),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget bottomBarTitle() {
    return Container(
      margin: const EdgeInsets.only(bottom: 5),
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            "Total",
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.w400),
          ),
          Obx(() {
            return AnimatedSwitcherWrapper(
              child: Text(
                "\$${controller.totalPrice.value}",
                key: ValueKey<int>(controller.totalPrice.value),
                style: const TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.w900,
                  color: Color(0xFFEC6813),
                ),
              ),
            );
          }),
        ],
      ),
    );
  }

  Widget bottomBarButton() {
    return Padding(
      padding: const EdgeInsets.only(left: 30, right: 30, bottom: 20),
      child: Obx(() {
        return SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.all(20),
              backgroundColor: controller.isEmptyCart
                  ? Colors.grey
                  : const Color(0xFFEC6813),
            ),
            onPressed: controller.isEmptyCart
                ? null
                : () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const PaymentScreen(),
                        ));
                  },
            child: const Text("Buy Now"),
          ),
        );
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(context),
      body: Obx(() {
        return Column(
          children: [
            Expanded(
              child: controller.cartProducts.isEmpty
                  ? const EmptyCart()
                  : cartList(),
            ),
            bottomBarTitle(),
            bottomBarButton(),
          ],
        );
      }),
    );
  }
}
