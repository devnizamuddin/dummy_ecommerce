import 'package:flutter/material.dart';

import 'core/router/app_router.dart';

class DummyEcommerce extends StatelessWidget {
  const DummyEcommerce({super.key});

  @override
  Widget build(BuildContext context) {
    late final AppRouter appRouter = AppRouter();
    return MaterialApp.router(
      routerConfig: appRouter.router,
      debugShowCheckedModeBanner: false,
    );
  }
}
