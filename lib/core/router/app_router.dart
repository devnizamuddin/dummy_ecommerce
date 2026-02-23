import '../../features/cart/presentation/pages/cart_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../features/products/presentation/bloc/product_bloc.dart';
import '../../features/products/presentation/pages/product_page.dart';
import 'error_route_page.dart';
import 'route_path.dart';

class AppRouter {
  AppRouter();

  final _rootNavigatorKey = GlobalKey<NavigatorState>();

  late final GoRouter router = GoRouter(
    debugLogDiagnostics: true,
    navigatorKey: _rootNavigatorKey,
    initialLocation: RoutePath.home,
    errorBuilder: (context, state) => ErrorRoutePage(state: state),
    routes: [
      GoRoute(
        name: RoutePath.home,
        path: RoutePath.home,
        builder: (context, state) => BlocProvider(
          create: (context) => ProductBloc(),
          child: const ProductPage(),
        ),
      ),
      GoRoute(
        name: RoutePath.cart,
        path: RoutePath.cart,
        builder: (context, state) => BlocProvider(
          create: (context) => ProductBloc(),
          child: const CartPage(),
        ),
      ),
    ],
  );
}
