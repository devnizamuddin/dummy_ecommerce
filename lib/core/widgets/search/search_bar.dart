import 'package:flutter/material.dart';

class PrimarySearchBar extends StatelessWidget {
  final String hintText;
  const PrimarySearchBar({super.key, required this.hintText});

  @override
  Widget build(BuildContext context) {
    return SearchBar(
      hintText: hintText,
    );
  }
}
