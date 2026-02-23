import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../cart/domain/entities/cart_entity.dart';
import '../../../cart/presentation/bloc/cart_bloc.dart';
import '../../domain/entities/product_entity.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({super.key, required this.product});

  final ProductEntity product;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Image.network(
                    product.thumbnail,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return const Center(child: Icon(Icons.image_not_supported, color: Colors.grey));
                    },
                  ),
                  Positioned(
                    top: 8,
                    left: 8,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.black.withValues(alpha: 0.7),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.star, color: Colors.orange, size: 14),
                          const SizedBox(width: 4),
                          Text(
                            product.rating.toString(),
                            style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                const SizedBox(height: 4),
                Text(
                  product.description,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(color: Colors.grey[600], fontSize: 12),
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '\$${product.price.toStringAsFixed(2)}',
                      style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 16, color: Colors.green),
                    ),
                    BlocBuilder<CartBloc, CartState>(
                      buildWhen: (previous, current) => current is CartLoaded,
                      builder: (context, state) {
                        CartEntity? cartItem;
                        if (state is CartLoaded) {
                          cartItem = state.cartItems.where((e) => e.id == product.id).firstOrNull;
                        } else {
                          final blocState = context.read<CartBloc>().state;
                          if (blocState is CartLoaded) {
                            cartItem = blocState.cartItems.where((e) => e.id == product.id).firstOrNull;
                          }
                        }

                        if (cartItem != null) {
                          return Container(
                            decoration: BoxDecoration(
                              color: Theme.of(context).primaryColor.withValues(alpha: 0.1),
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: Theme.of(context).primaryColor),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                InkWell(
                                  onTap: () {
                                    if (cartItem!.quantity > 1) {
                                      context.read<CartBloc>().add(
                                        UpdateCartItemEvent(
                                          cartItem: CartEntity(
                                            id: product.id,
                                            title: product.title,
                                            image: product.thumbnail,
                                            price: product.price,
                                            quantity: -1,
                                          ),
                                        ),
                                      );
                                    } else {
                                      context.read<CartBloc>().add(RemoveFromCartEvent(cartItem: cartItem));
                                    }
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                    child: Icon(Icons.remove, size: 16, color: Theme.of(context).primaryColor),
                                  ),
                                ),
                                Text(
                                  '${cartItem.quantity}',
                                  style: TextStyle(fontWeight: FontWeight.bold, color: Theme.of(context).primaryColor),
                                ),
                                InkWell(
                                  onTap: () {
                                    context.read<CartBloc>().add(
                                      UpdateCartItemEvent(
                                        cartItem: CartEntity(
                                          id: product.id,
                                          title: product.title,
                                          image: product.thumbnail,
                                          price: product.price,
                                          quantity: 1,
                                        ),
                                      ),
                                    );
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                    child: Icon(Icons.add, size: 16, color: Theme.of(context).primaryColor),
                                  ),
                                ),
                              ],
                            ),
                          );
                        }

                        return InkWell(
                          onTap: () {
                            context.read<CartBloc>().add(
                              AddToCartEvent(
                                cartItem: CartEntity(
                                  id: product.id,
                                  title: product.title,
                                  image: product.thumbnail,
                                  quantity: 1,
                                  price: product.price,
                                ),
                              ),
                            );
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('${product.title} added to cart!'),
                                duration: const Duration(seconds: 1),
                                behavior: SnackBarBehavior.floating,
                              ),
                            );
                          },
                          borderRadius: BorderRadius.circular(8),
                          child: Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Theme.of(context).primaryColor,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: const Icon(Icons.add_shopping_cart, color: Colors.white, size: 20),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
