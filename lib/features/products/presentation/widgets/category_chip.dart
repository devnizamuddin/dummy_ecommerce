import 'package:flutter/material.dart';

import '../../domain/entities/category_entity.dart';

class CategoryChip extends StatelessWidget {
  final bool isAll;
  final CategoryEntity? category;
  final bool isSelected;
  final void Function()? onPressed;
  const CategoryChip({
    super.key,
    required this.isAll,
    required this.category,
    required this.isSelected,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 12.0),
      child: RawChip(
        showCheckmark: false,
        label: Text(
          isAll ? 'All' : category!.name,
          style: TextStyle(
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
            color: isSelected ? Colors.white : Colors.black87,
          ),
        ),
        selected: isSelected,
        selectedColor: Theme.of(context).primaryColor,
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
          side: BorderSide(
            color: isSelected ? Theme.of(context).primaryColor : Colors.grey.shade300,
          ),
        ),
        elevation: isSelected ? 2 : 0,
        pressElevation: 0,
        onPressed: onPressed,
      ),
    );
  }
}
