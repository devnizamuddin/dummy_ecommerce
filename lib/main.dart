import 'package:flutter/material.dart';

import 'dependency_handler.dart';
import 'dummy_ecommerce.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeApp();
  runApp(const DummyEcommerce());
}
