import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ProductImages extends StatelessWidget {
  const ProductImages({super.key, required this.imageUrl});

  final String? imageUrl;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(20),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.65,
        decoration: BoxDecoration(
          color: Colors.amber[50],
          borderRadius: BorderRadius.circular(25),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: CachedNetworkImage(imageUrl: imageUrl!, fit: BoxFit.contain),
        ),
      ),
    );
  }
}