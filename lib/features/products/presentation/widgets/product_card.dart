import 'package:flutter/material.dart';

import '../../domain/entities/product_entity.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({super.key, required this.product});

  final ProductEntity product;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          Image.network(
            product.thumbnail,
            height: 200,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
          Text(product.title),
          Text(product.price.toString()),
        ],
      ),
    );
  }
}
