import '../../../../core/constant/app_keys.dart';
import '../../../../core/services/local_storage_service.dart';
import '../models/cart_model.dart';

abstract class CartLocalDataSource {
  Future<List<CartModel>> getAllCartItems();
  Future<List<CartModel>> addCartItem(CartModel cartItem);
  Future<List<CartModel>> removeCartItem(CartModel cartItem);
  Future<List<CartModel>> updateCartItem(CartModel cartItem);
  Future<void> clearCart();
}

class CartLocalDataSourceImpl implements CartLocalDataSource {
  final LocalStorageService localStorageService;

  CartLocalDataSourceImpl({required this.localStorageService});

  @override
  Future<List<CartModel>> getAllCartItems() async {
    final response = localStorageService.getData(AppKeys.cartItems);
    if (response != null && response is List) {
      return response.map((x) => CartModel.fromJson(Map<String, dynamic>.from(x))).toList();
    }
    return [];
  }

  @override
  Future<List<CartModel>> addCartItem(CartModel cartItem) async {
    final currentItems = await getAllCartItems();
    final index = currentItems.indexWhere((element) => element.id == cartItem.id);
    if (index >= 0) {
      // If item exists, update its quantity
      currentItems[index] = currentItems[index].copyWith(
        quantity: currentItems[index].quantity + cartItem.quantity,
      );
    } else {
      currentItems.add(cartItem);
    }
    await _saveCartItems(currentItems);
    return currentItems;
  }

  @override
  Future<List<CartModel>> removeCartItem(CartModel cartItem) async {
    final currentItems = await getAllCartItems();
    currentItems.removeWhere((element) => element.id == cartItem.id);
    await _saveCartItems(currentItems);
    return currentItems;
  }

  @override
  Future<List<CartModel>> updateCartItem(CartModel cartItem) async {
    final currentItems = await getAllCartItems();
    final index = currentItems.indexWhere((element) => element.id == cartItem.id);
    if (index >= 0) {
      currentItems[index] = cartItem;
      await _saveCartItems(currentItems);
    }
    return currentItems;
  }

  @override
  Future<void> clearCart() async {
    await _saveCartItems([]);
  }

  Future<void> _saveCartItems(List<CartModel> items) async {
    final jsonList = items.map((x) => x.toJson()).toList();
    await localStorageService.saveData(AppKeys.cartItems, jsonList);
  }
}
