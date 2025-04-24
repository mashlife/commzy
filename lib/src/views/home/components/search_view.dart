import 'package:commzy/src/resources/reusable/gap.dart';
import 'package:commzy/src/viewmodels/home/search-viewmodel.dart';
import 'package:commzy/src/views/home/components/shop_items.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Future<dynamic> showSearchView(BuildContext context) {
  return showModalBottomSheet(
    isScrollControlled: true,

    backgroundColor: Colors.grey[50],
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
    ),
    context: context,
    builder:
        (context) => DraggableScrollableSheet(
          initialChildSize: 0.45,
          minChildSize: 0.25,
          maxChildSize: 0.9,
          expand: false,
          builder:
              (BuildContext context, ScrollController scrollController) =>
                  Container(
                    margin: const EdgeInsets.all(16),
                    child: SingleChildScrollView(
                      controller: scrollController,
                      physics: BouncingScrollPhysics(),
                      child: SearchView(),
                    ),
                  ),
        ),
  );
}

class SearchView extends StatelessWidget {
  const SearchView({super.key});

  @override
  Widget build(BuildContext context) {
    final SearchViewmodel searchViewmodel = Get.find();
    return Padding(
      padding: EdgeInsets.all(12),
      child: Column(
        children: [
          Container(
            height: 50,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(25),
                bottomLeft: Radius.circular(19),
                bottomRight: Radius.circular(3),
              ),
              color: Colors.blue[50]!.withOpacity(0.8),
            ),
            child: TextField(
              textAlignVertical: TextAlignVertical.center,
              autocorrect: false,
              style: TextStyle(fontWeight: FontWeight.w600),
              decoration: InputDecoration(
                hintText: "e.g Smartphones",
                suffixIcon: Icon(Icons.search),
                hintStyle: TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                  fontWeight: FontWeight.w600,
                ),

                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xffb6b7b7)),
                  borderRadius: BorderRadius.circular(15),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xffff6e00)),
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
              onChanged:
                  (text) =>
                      searchViewmodel.getSearchedProducts(searchString: text),
            ),
          ),
          verticalGap(18),
          Obx(() {
            return searchViewmodel.searchedProducts.isNotEmpty
                ? ListView.separated(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: searchViewmodel.searchedProducts.length,
                  separatorBuilder: (context, index) => verticalGap(10),
                  itemBuilder: (context, index) {
                    final product = searchViewmodel.searchedProducts[index];
                    return ShopItems(
                      product: product,
                      showStock: true,
                      color: Colors.brown[50],
                    );
                  },
                )
                : AnimatedSwitcher(
                  duration: Duration(milliseconds: 350),
                  transitionBuilder: (
                    Widget child,
                    Animation<double> animation,
                  ) {
                    return ScaleTransition(scale: animation, child: child);
                  },
                  child:
                      searchViewmodel.searchText.text.trim().isNotEmpty
                          ? Container(
                            padding: const EdgeInsets.all(24.0),
                            height: 100,
                            width: 100,
                            child: Center(child: CircularProgressIndicator()),
                          )
                          : SizedBox.shrink(),
                );
          }),
        ],
      ),
    );
  }
}
