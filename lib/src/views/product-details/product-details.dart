import 'package:carousel_slider_plus/carousel_slider_plus.dart';
import 'package:commzy/src/data/status/ui-status.dart';
import 'package:commzy/src/models/product/product_datamodel.dart';
import 'package:commzy/src/resources/reusable/animated_rating.dart';
import 'package:commzy/src/resources/reusable/gap.dart';
import 'package:commzy/src/utils/nav-utils.dart';
import 'package:commzy/src/viewmodels/product-details/product-details-viewmodel.dart';
import 'package:commzy/src/views/product-details/components/bottom_buy_widget.dart';
import 'package:commzy/src/views/product-details/components/image_index_slider.dart';
import 'package:commzy/src/views/product-details/components/info_row_widget.dart';
import 'package:commzy/src/views/product-details/components/product_image_single.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class ProductDetailsScreen extends StatefulWidget {
  const ProductDetailsScreen({super.key, required this.product});
  final Product product;

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  ProductDetailsViewModel productDetailsViewModel = Get.find();
  final CarouselSliderController carouselController =
      CarouselSliderController();
  bool _startDoing = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await productDetailsViewModel.getProductById(
        context,
        id: widget.product.id!,
      );
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    productDetailsViewModel.clearProduct();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[50],
      bottomNavigationBar: AnimatedSwitcher(
        duration: Duration(milliseconds: 350),
        transitionBuilder: (Widget child, Animation<double> animation) {
          return SizeTransition(
            sizeFactor: animation,
            axisAlignment: -1.0,
            child: child,
          );
        },
        child:
            _startDoing
                ? BottomBuyWidget(product: widget.product)
                : SizedBox.shrink(),
      ),

      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: AppBar(
            leadingWidth: 45,
            forceMaterialTransparency: true,
            leading: Hero(
              tag: "BACK TO CART",
              child: IconButton.filled(
                onPressed: () => NavUtils.remove(),
                icon: Icon(Icons.arrow_back_rounded),
                color: Colors.lightBlue,
                style: ButtonStyle(
                  backgroundColor: WidgetStatePropertyAll(Colors.blueGrey[100]),

                  shape: WidgetStatePropertyAll(CircleBorder()),
                ),
              ),
            ),
          ),
        ),
      ),
      body: NotificationListener<ScrollNotification>(
        onNotification: (notification) {
          if (notification is ScrollStartNotification && !_startDoing) {
            setState(() {
              _startDoing = true;
            });
          }
          return false;
        },
        child: Obx(() {
          if (productDetailsViewModel.uiStatus.value == UiStatus.success) {
            final product = productDetailsViewModel.product!.value;
            return SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        Hero(
                          tag: "PRODUCT IMAGES ${product.id}",
                          child: CarouselSlider(
                            controller: carouselController,
                            options: CarouselOptions(
                              enableInfiniteScroll: false,
                              enlargeCenterPage: true,
                              enlargeFactor: 0.4,
                              viewportFraction: 0.6,
                              aspectRatio: 14 / 10,
                              initialPage:
                                  productDetailsViewModel
                                      .carouselCurrentIndex
                                      .value,
                              onPageChanged:
                                  (index, _) => productDetailsViewModel
                                      .updateCarouselIndex(index),
                            ),
                            items:
                                product.images?.map((image) {
                                  return Builder(
                                    builder: (context) {
                                      return ProductImages(imageUrl: image);
                                    },
                                  );
                                }).toList(),
                          ),
                        ),
                        if (product.images!.length > 1)
                          Positioned(
                            bottom: 5,
                            child: Row(
                              mainAxisSize: MainAxisSize.min,

                              children: List.generate(
                                growable: false,
                                product.images!.length,
                                (index) {
                                  return GestureDetector(
                                    onTap: () {
                                      carouselController.jumpToPage(index);
                                    },
                                    child: SingleSliderIndicator(
                                      isSelected:
                                          productDetailsViewModel
                                              .carouselCurrentIndex
                                              .value ==
                                          index,
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                      ],
                    ),

                    verticalGap(15),
                    Text(
                      product.title!,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    verticalGap(5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          product.rating!.toStringAsFixed(1),
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        horizontalGap(5),
                        ProductRating(
                          rating: product.rating,
                          colors: [Colors.amberAccent, Colors.yellowAccent],
                        ),
                      ],
                    ),
                    verticalGap(10),
                    Text(
                      product.description!,
                      style: TextStyle(
                        fontWeight: FontWeight.normal,
                        letterSpacing: 1.25,
                        fontSize: 15,
                      ),
                    ),
                    verticalGap(10),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '\$${product.price}',
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w700,
                                fontSize: 22,
                                letterSpacing: -0.5,
                              ),
                            ),
                            if (product.discountPercentage! >= 1)
                              Text(
                                '* ${product.discountPercentage!.round()}% off on purchase',
                                style: TextStyle(
                                  color: Colors.blue,
                                  fontWeight: FontWeight.w500,
                                  letterSpacing: -0.5,
                                ),
                              ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              margin:
                                  product.stock! <= 5
                                      ? EdgeInsets.only(top: 5)
                                      : null,
                              child: Image.asset(
                                product.stock! <= 5
                                    ? 'assets/images/low_stock.png'
                                    : 'assets/images/in_stock.png',
                                height: 20,
                                width: 20,
                                fit: BoxFit.cover,
                              ),
                            ),
                            horizontalGap(5),
                            Text.rich(
                              textAlign: TextAlign.center,
                              TextSpan(
                                children: [
                                  TextSpan(
                                    text: product.stock.toString(),
                                    style: TextStyle(
                                      color:
                                          product.stock! <= 5
                                              ? Colors.red
                                              : Colors.black,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 18,
                                      letterSpacing: -0.5,
                                    ),
                                  ),
                                  TextSpan(
                                    text: " in stock",
                                    style: TextStyle(
                                      color:
                                          product.stock! <= 5
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
                      ],
                    ),
                    verticalGap(12),
                    Text(
                      "Product Info",
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w700,
                        fontSize: 22,
                        letterSpacing: -0.5,
                      ),
                    ),
                    verticalGap(3),
                    InfoRowWidget(rowName: "Brand", rowInfo: product.brand!),

                    verticalGap(1),

                    InfoRowWidget(
                      rowName: "Weight",
                      rowInfo: "${product.weight!} KG",
                    ),
                    verticalGap(1),
                    InfoRowWidget(
                      rowName: "Dimensions",
                      rowChild: Column(
                        children: [
                          Text(
                            "${product.dimensions!.width!.toStringAsFixed(1)}cm X ${product.dimensions!.height!.toStringAsFixed(1)}cm X ${product.dimensions!.depth!.toStringAsFixed(1)}cm",
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w700,
                              fontSize: 16,
                              letterSpacing: -0.5,
                            ),
                          ),
                          Text(
                            "W x H x D",
                            style: TextStyle(
                              color: Colors.blueGrey,
                              fontWeight: FontWeight.w800,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                    verticalGap(12),
                    InfoRowWidget(
                      crossAlign: CrossAxisAlignment.center,
                      rowNameChild: Image.asset(
                        'assets/images/warranty.png',
                        height: 40,
                        width: 40,
                        fit: BoxFit.contain,
                      ),

                      rowInfo: product.warrantyInformation,
                    ),
                    verticalGap(2),
                    InfoRowWidget(
                      crossAlign: CrossAxisAlignment.center,
                      rowNameChild: Image.asset(
                        'assets/images/shipping.png',
                        height: 40,
                        width: 40,
                        fit: BoxFit.contain,
                      ),

                      rowInfo: product.shippingInformation,
                    ),
                    verticalGap(2),
                    InfoRowWidget(
                      crossAlign: CrossAxisAlignment.center,
                      rowNameChild: Image.asset(
                        'assets/images/return_policy.png',
                        height: 40,
                        width: 40,
                        fit: BoxFit.contain,
                      ),

                      rowInfo: product.returnPolicy,
                    ),
                    verticalGap(12),
                    Text(
                      "Reviews",
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w700,
                        fontSize: 22,
                        letterSpacing: -0.5,
                      ),
                    ),
                    verticalGap(5),
                    ListView.separated(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: product.reviews!.length,
                      separatorBuilder: (context, index) => verticalGap(3),
                      itemBuilder: (context, index) {
                        final review = product.reviews![index];
                        return ListTile(
                          tileColor: Colors.brown[50],
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          trailing: CircleAvatar(
                            backgroundColor: Colors.blue[100],
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  review.rating.toString(),
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),
                                ),
                                Icon(
                                  Icons.star_rounded,
                                  color: Colors.yellow,
                                  shadows: [
                                    Shadow(
                                      color: Colors.black54,
                                      offset: Offset(0, 1),
                                      blurRadius: 2,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          title: Text(
                            review.reviewerName!,
                            style: TextStyle(
                              color: Colors.grey[700],
                              fontWeight: FontWeight.w700,
                              fontSize: 16,
                              letterSpacing: -0.5,
                            ),
                          ),
                          subtitle: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                review.comment!,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 15,
                                ),
                              ),

                              Text(
                                DateFormat("dd MMM,yyyy").format(review.date!),
                                style: TextStyle(
                                  color: Colors.grey[900],
                                  fontWeight: FontWeight.w500,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            );
          } else {
            return Center(
              child: Text(
                productDetailsViewModel.message.value,
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                  color: Colors.red,
                ),
              ),
            );
          }
        }),
      ),
    );
  }
}
