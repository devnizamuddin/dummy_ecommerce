import 'package:badges/badges.dart' as badges;
import 'package:dummy_ecommerce/features/products/presentation/widgets/category_chip.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/router/route_path.dart';
import '../../../cart/presentation/bloc/cart_bloc.dart';
import '../bloc/category/category_bloc.dart';
import '../bloc/product_bloc.dart';
import '../widgets/product_card.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({super.key});

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    context.read<ProductBloc>().add(GetPaginatedProductsEvent(limit: 10, skip: 0));
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_isBottom) {
      context.read<ProductBloc>().add(LoadMoreProductsEvent());
    }
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        controller: _scrollController,
        slivers: [
          SliverAppBar(
            title: const Text(
              'Discover',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            floating: true,
            actions: [
              BlocBuilder<CartBloc, CartState>(
                builder: (context, state) {
                  int cartCount = 0;
                  if (state is CartLoaded) {
                    cartCount = state.cartItems.length;
                  } else if (state is CartItemAdded) {
                    // Try to get count from current items locally, or wait for next load
                    final bloc = context.read<CartBloc>();
                    if (bloc.state is CartLoaded) {
                      cartCount = (bloc.state as CartLoaded).cartItems.length;
                    }
                  }

                  return IconButton(
                    icon: badges.Badge(
                      showBadge: cartCount > 0,
                      badgeContent: Text(
                        cartCount.toString(),
                        style: const TextStyle(color: Colors.white, fontSize: 10),
                      ),
                      position: badges.BadgePosition.topEnd(top: -10, end: -10),
                      child: const Icon(Icons.shopping_cart_outlined),
                    ),
                    onPressed: () => context.push(RoutePath.cart),
                  );
                },
              ),
              const SizedBox(width: 8),
            ],
          ),
          BlocBuilder<CategoryBloc, CategoryState>(
            builder: (context, state) {
              if (state is CategoryLoading && state.selectedCategory == null) {
                return const SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 24.0),
                    child: Center(child: CircularProgressIndicator()),
                  ),
                );
              }

              if (state is CategoryLoaded) {
                return SliverToBoxAdapter(
                  child: Container(
                    height: 50,
                    margin: const EdgeInsets.only(top: 8, bottom: 8),
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      itemCount: state.categories.length + 1, // +1 for "All"
                      itemBuilder: (context, index) {
                        final isAll = index == 0;
                        final category = isAll ? null : state.categories[index - 1];
                        final isSelected = state.selectedCategory?.slug == category?.slug;

                        return CategoryChip(
                          isAll: isAll,
                          category: category,
                          isSelected: isSelected,
                          onPressed: () {
                            if (!isSelected) {
                              context.read<CategoryBloc>().add(SelectCategoryEvent(category));
                              if (isAll) {
                                context.read<ProductBloc>().add(GetPaginatedProductsEvent(limit: 10, skip: 0));
                              } else {
                                context.read<ProductBloc>().add(GetProductsByCategoryEvent(category: category!.slug));
                              }
                            }
                          },
                        );
                      },
                    ),
                  ),
                );
              }

              return const SliverToBoxAdapter(child: SizedBox.shrink());
            },
          ),
          BlocBuilder<ProductBloc, ProductState>(
            builder: (context, state) {
              if (state is ProductLoading) {
                return const SliverFillRemaining(
                  child: Center(child: CircularProgressIndicator()),
                );
              } else if (state is ProductLoaded) {
                return SliverPadding(
                  padding: const EdgeInsets.all(16.0),
                  sliver: SliverMainAxisGroup(
                    slivers: [
                      SliverGrid(
                        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                          maxCrossAxisExtent: 250,
                          mainAxisSpacing: 16,
                          crossAxisSpacing: 16,
                          childAspectRatio: 0.70, // Adjust for the image+content
                        ),
                        delegate: SliverChildBuilderDelegate(
                          (context, index) {
                            return ProductCard(product: state.products[index]);
                          },
                          childCount: state.products.length,
                        ),
                      ),
                      if (state.isFetchingMore)
                        const SliverToBoxAdapter(
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 24.0),
                            child: Center(child: CircularProgressIndicator()),
                          ),
                        ),
                    ],
                  ),
                );
              } else if (state is ProductError) {
                return SliverFillRemaining(
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.error_outline, size: 64, color: Colors.redAccent),
                        const SizedBox(height: 16),
                        Text('Oops! ${state.message}'),
                        const SizedBox(height: 16),
                        ElevatedButton(
                          onPressed: () => context.read<ProductBloc>().add(GetPaginatedProductsEvent()),
                          child: const Text('Retry'),
                        ),
                      ],
                    ),
                  ),
                );
              }
              return const SliverFillRemaining(child: SizedBox.shrink());
            },
          ),
        ],
      ),
    );
  }
}
