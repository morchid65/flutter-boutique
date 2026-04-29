import 'package:flutter/material.dart';
import '../models/product.dart';
import '../models/cart_item.dart';

// On passe d'un Service Statique à un Provider réactif
class CartProvider with ChangeNotifier {
  // On enlève "static", chaque instance gère son état
  final List<CartItem> _items = [];

  List<CartItem> get items => _items;

  // Calcul du total dynamique
  double get totalPrice {
    return _items.fold(0, (sum, item) => sum + (item.product.price * item.quantity));
  }

  // AJOUTER UN PRODUIT
  void addProduct(Product product) {
    bool found = false;
    for (var item in _items) {
      if (item.product.id == product.id) {
        item.quantity++;
        found = true;
        break;
      }
    }
    if (!found) {
      _items.add(CartItem(product: product));
    }
    
    // IMPORTANT : On prévient l'UI que le panier a changé[cite: 1]
    notifyListeners(); 
  }

  // SUPPRIMER UN PRODUIT (Étape 3 de ton chantier)
  void removeProduct(Product product) {
    final index = _items.indexWhere((item) => item.product.id == product.id);
    
    if (index != -1) {
      if (_items[index].quantity > 1) {
        // Si on en a plusieurs, on diminue juste la quantité
        _items[index].quantity--;
      } else {
        // Si c'est le dernier, on le retire complètement du plateau
        _items.removeAt(index);
      }
      // On prévient la salle que l'addition change ![cite: 1]
      notifyListeners();
    }
  }

  // VIDER LE PANIER
  void clearCart() {
    _items.clear();
    notifyListeners();
  }

  // PAYER (Le checkout)
  Future<void> checkout() async {
    if (_items.isEmpty) return;
    
    // Simulation d'envoi à la base de données (Supabase)
    await Future.delayed(const Duration(milliseconds: 500));
    
    clearCart(); // On vide et on notifie
  }
}