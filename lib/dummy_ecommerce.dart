import 'package:dummy_ecommerce/features/cart/presentation/bloc/cart_bloc.dart';
import 'package:dummy_ecommerce/features/products/presentation/bloc/category/category_bloc.dart';
import 'package:dummy_ecommerce/features/products/presentation/bloc/product_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/router/app_router.dart';

class DummyEcommerce extends StatelessWidget {
  const DummyEcommerce({super.key});

  @override
  Widget build(BuildContext context) {
    late final AppRouter appRouter = AppRouter();
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => ProductBloc()),
        BlocProvider(create: (_) => CategoryBloc()..add(GetCategoriesEvent())),
        BlocProvider(create: (_) => CartBloc()..add(GetAllCartItemsEvent())),
      ],
      child: MaterialApp.router(
        routerConfig: appRouter.router,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
