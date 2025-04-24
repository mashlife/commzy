import 'package:cached_network_image/cached_network_image.dart';
import 'package:commzy/src/models/product/product_datamodel.dart';
import 'package:commzy/src/resources/reusable/animated_rating.dart';
import 'package:commzy/src/resources/reusable/gap.dart';
import 'package:commzy/src/services/shop_sevices.dart';
import 'package:commzy/src/utils/nav-utils.dart';
import 'package:commzy/src/views/product-details/product-details.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ShopItems extends StatelessWidget {
  const ShopItems({
    super.key,
    required this.product,
    required bool showStock,
    this.color,
  }) : _showStock = showStock;

  final Product product;
  final bool _showStock;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final ShopServices shopServices = Get.find();
    return GestureDetector(
      onTap: () => NavUtils.nextScreen(ProductDetailsScreen(product: product)),
      child: Container(
        decoration: BoxDecoration(
          color: color ?? Colors.blue[100],
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: EdgeInsets.all(8),
          child: Row(
            children: [
              Stack(
                children: [
                  Hero(
                    tag: "PRODUCT IMAGES ${product.id}",
                    child: SizedBox(
                      height: 60,
                      width: 60,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: CachedNetworkImage(
                          imageUrl: product.thumbnail!,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),

                  if (product.discountPercentage! >= 1)
                    Positioned(
                      top: 0,
                      right: 0,
                      child: Container(
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.red,
                        ),
                        child: Text("${product.discountPercentage!.round()}%"),
                      ),
                    ),
                ],
              ),
              horizontalGap(10),
              Flexible(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.title!,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    verticalGap(2),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            ProductRating(
                              rating: product.rating,
                              colors: [Colors.amberAccent, Colors.yellowAccent],
                            ),
                            verticalGap(5),
                            AnimatedOpacity(
                              opacity: _showStock ? 1 : 0,
                              curve: Curves.easeInBack,
                              duration: Duration(seconds: 1),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    margin:
                                        product.availabilityStatus ==
                                                "Low Stock"
                                            ? EdgeInsets.only(top: 8)
                                            : null,
                                    child: Image.asset(
                                      product.availabilityStatus == "Low Stock"
                                          ? 'assets/images/low_stock.png'
                                          : 'assets/images/in_stock.png',
                                      height: 20,
                                      width: 20,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  horizontalGap(5),
                                  Text(
                                    product.availabilityStatus!,
                                    style: TextStyle(
                                      color:
                                          product.availabilityStatus ==
                                                  "Low Stock"
                                              ? Colors.red
                                              : Colors.black,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14,
                                      letterSpacing: -0.5,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              '\$${product.price!}',
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w700,
                                fontSize: 16,
                                letterSpacing: -0.5,
                              ),
                            ),
                            verticalGap(5),
                            SizedBox(
                              height: 35,
                              width: 50,
                              child: IconButton.filled(
                                alignment: Alignment.center,
                                onPressed: () {
                                  shopServices.addProducts(product);
                                },
                                icon: Icon(
                                  Icons.add_shopping_cart_rounded,
                                  size: 20,
                                ),
                                color: Colors.white,
                                style: ButtonStyle(
                                  backgroundColor: WidgetStatePropertyAll(
                                    Colors.blue[900],
                                  ),
                                  shape: WidgetStatePropertyAll(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(100),
                                        bottomRight: Radius.circular(100),

                                        topLeft: Radius.circular(40),
                                        bottomLeft: Radius.circular(40),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
