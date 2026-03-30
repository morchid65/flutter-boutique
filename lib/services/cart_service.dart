import 'package:flutter/material.dart';
import '../models/product.dart';
import '../models/cart_item.dart';

class CartService {
  static final List<CartItem> _items = [];

  static List<CartItem> get items => _items;

  // ✅ Cette méthode gère les deux noms possibles pour éviter les erreurs
  static void addToCart(Product product) => addProduct(product);

  static void addProduct(Product product) {
    for (var item in _items) {
      if (item.product.id == product.id) {
        item.quantity++;
        debugPrint("Quantité augmentée pour: ${product.title}");
        return;
      }
    }
    _items.add(CartItem(product: product));
    debugPrint("Nouveau produit ajouté: ${product.title}");
  }

  static double get totalPrice {
    return _items.fold(0, (sum, item) => sum + (item.product.price * item.quantity));
  }

  static Future<void> checkout() async {
    if (_items.isEmpty) return;
    // Simulation d'envoi à Supabase
    await Future.delayed(const Duration(milliseconds: 500));
    _items.clear();
  }
}