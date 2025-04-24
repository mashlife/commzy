import 'package:commzy/src/models/product/product_datamodel.dart';
import 'package:commzy/src/services/shop_sevices.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BottomBuyWidget extends StatefulWidget {
  const BottomBuyWidget({super.key, required this.product});

  final Product product;

  @override
  State<BottomBuyWidget> createState() => _BottomBuyWidgetState();
}

class _BottomBuyWidgetState extends State<BottomBuyWidget> {
  double priceAfterDiscount = 0.00;

  int? cartProductIndex;
  ShopServices shopServices = Get.find();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    var discount =
        (widget.product.price!) * (widget.product.discountPercentage! / 100);
    priceAfterDiscount = widget.product.price! - discount;
  }

  @override
  void dispose() {
    // TODO: implement dispose

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 2, horizontal: 15),
      height: 70,
      width: double.infinity,
      color: Colors.amber,
      alignment: Alignment.center,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text("After discount: \$"),
              Text(
                priceAfterDiscount.toStringAsFixed(2),
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ],
          ),

          Obx(() {
            cartProductIndex = shopServices.cartHasProductById(
              widget.product.id!,
            );

            return cartProductIndex != null
                ? Container(
                  height: 40,
                  width: 130,
                  decoration: BoxDecoration(
                    color: Colors.blue[400],
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap:
                            () => shopServices.removeProducts(widget.product),
                        child: SizedBox(width: 35, child: Icon(Icons.remove)),
                      ),
                      VerticalDivider(
                        color: Colors.grey,
                        thickness: 2,
                        width: 10,
                      ),
                      Obx(
                        () => SizedBox(
                          width: 40,
                          child: Text(
                            shopServices.userCart[cartProductIndex!].quantity
                                .toString(),
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                      VerticalDivider(
                        color: Colors.grey,
                        thickness: 2,
                        width: 10,
                      ),
                      GestureDetector(
                        onTap: () => shopServices.addProducts(widget.product),
                        child: SizedBox(width: 35, child: Icon(Icons.add)),
                      ),
                    ],
                  ),
                )
                : IconButton.filled(
                  onPressed: () => shopServices.addProducts(widget.product),
                  icon: Icon(Icons.add_shopping_cart_rounded),
                  iconSize: 32,
                  padding: EdgeInsets.all(10),
                  color: Colors.lightBlue,
                  style: ButtonStyle(
                    backgroundColor: WidgetStatePropertyAll(
                      Colors.blueGrey[100],
                    ),
                    shape: WidgetStatePropertyAll(CircleBorder()),
                  ),
                );
          }),
        ],
      ),
    );
  }
}
