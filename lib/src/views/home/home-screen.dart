import 'package:commzy/src/data/status/ui-status.dart';
import 'package:commzy/src/resources/reusable/gap.dart';
import 'package:commzy/src/services/shop_sevices.dart';
import 'package:commzy/src/viewmodels/home/category-viewmodel.dart';
import 'package:commzy/src/viewmodels/home/products-viewmodel.dart';
import 'package:commzy/src/views/home/components/category_widget.dart';
import 'package:commzy/src/views/home/components/search_view.dart';
import 'package:commzy/src/views/home/components/shop_items.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  ProductViewmodel productViewmodel = Get.find();
  CategoryViewModel categoryViewmodel = Get.find();
  ShopServices shopServices = Get.find();
  bool _showStock = false;

  bool _showCategory = false;
  late final ScrollController _scrollController;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _scrollController = ScrollController();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (productViewmodel.products == null) {
        await productViewmodel.getProducts(context);
      }
      if (categoryViewmodel.categories.isEmpty) {
        await categoryViewmodel.getCategories(context);
      }
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[50],
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: AppBar(
            centerTitle: true,
            forceMaterialTransparency: true,
            title: Text("CommZy"),
            leading: IconButton(
              onPressed: () async => await showSearchView(context),
              icon: Icon(Icons.search),
            ),
            actions: [
              IconButton.outlined(
                onPressed: () {
                  setState(() {
                    _showCategory = !_showCategory;
                    _scrollController.animateTo(
                      0,
                      duration: Duration(milliseconds: 350),
                      curve: Curves.easeInBack,
                    );
                  });
                  if (_showCategory == false) {
                    productViewmodel.removeCategoryModel();
                  }
                },
                icon: Icon(Icons.filter_list_rounded),
                style: ButtonStyle(
                  backgroundColor:
                      _showCategory
                          ? WidgetStatePropertyAll(Colors.blue[100])
                          : null,
                ),
              ),
              horizontalGap(10),
              Stack(
                clipBehavior: Clip.none,
                children: [
                  Hero(
                    tag: "BACK TO CART",
                    child: IconButton.filled(
                      onPressed: () {},
                      icon: Icon(Icons.shopping_cart),
                      color: Colors.lightBlue,
                      style: ButtonStyle(
                        backgroundColor: WidgetStatePropertyAll(
                          Colors.blueGrey[100],
                        ),
                        shape: WidgetStatePropertyAll(CircleBorder()),
                      ),
                    ),
                  ),
                  Obx(
                    () =>
                        shopServices.userCart.isNotEmpty
                            ? Positioned(
                              top: -10,
                              left: -5,
                              child: Container(
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: Colors.lightBlueAccent,
                                  shape: BoxShape.circle,
                                ),
                                child: Text(
                                  '${shopServices.userCart.length}',
                                  style: TextStyle(color: Colors.black),
                                ),
                              ),
                            )
                            : SizedBox.shrink(),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      body: Obx(() {
        if (productViewmodel.uiStatus.value == UiStatus.success) {
          if (_showStock == false) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              setState(() {
                _showStock = true;
              });
            });
          }

          return SingleChildScrollView(
            controller: _scrollController,
            child: Padding(
              padding: EdgeInsets.all(10),
              child: Column(
                children: [
                  AnimatedSwitcher(
                    duration: Duration(milliseconds: 250),
                    transitionBuilder: (
                      Widget child,
                      Animation<double> animation,
                    ) {
                      return SizeTransition(
                        sizeFactor: animation,
                        axisAlignment: -1.0,
                        child: child,
                      );
                    },
                    child:
                        _showCategory
                            ? CategoryWidget(
                              key: ValueKey('CategoryWidget'),
                              categoryModel: categoryViewmodel.categories,
                            )
                            : SizedBox.shrink(),
                  ),
                  Obx(
                    () =>
                        productViewmodel.categoryModel != null &&
                                productViewmodel.categorizedProducts.isNotEmpty
                            ? ListView.separated(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount:
                                  productViewmodel.categorizedProducts.length,
                              separatorBuilder:
                                  (context, index) => verticalGap(10),
                              itemBuilder: (context, index) {
                                final product =
                                    productViewmodel.categorizedProducts[index];
                                return ShopItems(
                                  product: product,
                                  showStock: _showStock,
                                );
                              },
                            )
                            : ListView.separated(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount:
                                  productViewmodel
                                      .products
                                      ?.value
                                      .products
                                      ?.length ??
                                  0,
                              separatorBuilder:
                                  (context, index) => verticalGap(10),
                              itemBuilder: (context, index) {
                                final product =
                                    productViewmodel
                                        .products
                                        ?.value
                                        .products?[index];
                                return ShopItems(
                                  product: product!,
                                  showStock: _showStock,
                                );
                              },
                            ),
                  ),
                ],
              ),
            ),
          );
        } else {
          return Center(
            child: Text(
              productViewmodel.message.value,
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 16,
                color: Colors.red,
              ),
            ),
          );
        }
      }),
    );
  }
}
