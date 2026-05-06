import 'package:flutter/foundation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/product.dart';
import '../models/cart_item.dart'; // <--- On importe la "boîte"

class CartService {
  static final _supabase = Supabase.instance.client;
  
  // 1. La liste contient maintenant des BOÎTES (CartItem)
  static List<CartItem> items = [];

  // 2. Le total utilise la quantité de la boîte
  static double get totalPrice {
    return items.fold(0, (sum, box) => sum + (box.product.price * box.quantity));
  }

  // 3. Ajouter un produit
  static void addProduct(Product p) {
    // On cherche si on a déjà une boîte avec ce produit dedans
    int index = items.indexWhere((box) => box.product.id == p.id);

    if (index != -1) {
      // Si oui, on augmente le chiffre sur la boîte
      items[index].quantity++;
    } else {
      // Si non, on crée une nouvelle boîte pour ce produit
      items.add(CartItem(product: p, quantity: 1));
    }
  }

  // Le reste (Supabase) ne change pas
  Future<void> saveOrderToSupabase(double total) async {
    try {
      final userId = _supabase.auth.currentUser?.id;
      if (userId == null) return;
      debugPrint("Commande de $total € envoyée pour l'utilisateur $userId");
    } catch (e) {
      debugPrint("Erreur lors de la sauvegarde : $e");
      rethrow;
    }
  }
}