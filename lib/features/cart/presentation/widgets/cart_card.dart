import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/cart_entity.dart';
import '../bloc/cart_bloc.dart';

class CartCard extends StatelessWidget {
  const CartCard({super.key, required this.product});

  final CartEntity product;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 10, offset: const Offset(0, 4))],
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.horizontal(left: Radius.circular(16)),
            child: Image.network(
              product.image,
              height: 100,
              width: 100,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => Container(
                height: 100,
                width: 100,
                color: Colors.grey[200],
                child: const Icon(Icons.image_not_supported, color: Colors.grey),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '\$${product.price.toStringAsFixed(2)}',
                    style: const TextStyle(fontWeight: FontWeight.w900, color: Colors.green, fontSize: 16),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                IconButton(
                  icon: const Icon(Icons.delete_outline, color: Colors.red),
                  onPressed: () {
                    context.read<CartBloc>().add(RemoveFromCartEvent(cartItem: product));
                  },
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      InkWell(
                        onTap: () {
                          if (product.quantity > 1) {
                            context.read<CartBloc>().add(
                              UpdateCartItemEvent(
                                cartItem: CartEntity(
                                  id: product.id,
                                  title: product.title,
                                  image: product.image,
                                  price: product.price,
                                  quantity: -1,
                                ),
                              ),
                            );
                          }
                        },
                        child: const Padding(padding: EdgeInsets.all(8.0), child: Icon(Icons.remove, size: 16)),
                      ),
                      Text(product.quantity.toString(), style: const TextStyle(fontWeight: FontWeight.bold)),
                      InkWell(
                        onTap: () {
                          context.read<CartBloc>().add(
                            UpdateCartItemEvent(
                              cartItem: CartEntity(
                                id: product.id,
                                title: product.title,
                                image: product.image,
                                price: product.price,
                                quantity: 1,
                              ),
                            ),
                          );
                        },
                        child: const Padding(padding: EdgeInsets.all(8.0), child: Icon(Icons.add, size: 16)),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
