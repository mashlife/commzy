import 'package:commzy/src/models/category/category_model.dart';
import 'package:commzy/src/viewmodels/home/products-viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CategoryWidget extends StatefulWidget {
  const CategoryWidget({super.key, required this.categoryModel});

  final List<CategoryModel> categoryModel;

  @override
  State<CategoryWidget> createState() => _CategoryWidgetState();
}

class _CategoryWidgetState extends State<CategoryWidget> {
  ProductViewmodel productViewmodel = Get.find();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(horizontal: 7, vertical: 15),
      margin: EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: Color(0x9ffdfdfd),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(12),
          bottomRight: Radius.circular(12),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey[200]!,
            offset: Offset(0, 1),
            blurRadius: 4,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Wrap(
        spacing: 5,
        runSpacing: 10,
        runAlignment: WrapAlignment.center,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: List.generate(
          widget.categoryModel.length,
          (index) => Obx(() {
            final categoryModel = widget.categoryModel[index];
            bool isSelected =
                productViewmodel.categoryModel?.value.slug ==
                categoryModel.slug;
            return InkWell(
              onTap: () {
                productViewmodel.updateCategoryModel(categoryModel, context);
              },
              child: Container(
                height: isSelected ? 45 : 40,
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: isSelected ? Colors.indigo[500] : Colors.blue[300],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  widget.categoryModel[index].name!,
                  style: TextStyle(
                    color: isSelected ? Colors.white : Colors.black,
                    fontWeight: isSelected ? FontWeight.bold : FontWeight.w300,
                  ),
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}
