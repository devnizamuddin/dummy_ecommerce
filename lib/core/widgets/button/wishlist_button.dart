import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class WishlistButton extends StatelessWidget {
  final bool isWishlist;
  final double size;
  final void Function(bool newValue) onToggle;

  const WishlistButton({
    super.key,
    this.size = 16,
    required this.onToggle,
    required this.isWishlist,
  });

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white.withValues(alpha: 0.85),
      ),
      child: IconButton(
        padding: EdgeInsets.zero,

        constraints: BoxConstraints(maxHeight: size, maxWidth: size),
        onPressed: () => onToggle(!isWishlist),
        icon: Icon(
          isWishlist ? FontAwesomeIcons.solidHeart : FontAwesomeIcons.heart,
          color: isWishlist ? Colors.red : Colors.grey[700],
          size: size,
        ),
        tooltip: isWishlist ? 'Remove from wishlist' : 'Add to wishlist',
      ),
    );
  }
}
