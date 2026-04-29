import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/cart_item.dart';

class CartService {
  final _supabase = Supabase.instance.client;

  // C'est ici qu'on ajoutera plus tard la logique pour enregistrer 
  // la commande dans les tables 'histo_panier' et 'contenir'
  Future<void> saveOrderToSupabase(List<CartItem> items, double total) async {
    try {
      final userId = _supabase.auth.currentUser?.id;
      if (userId == null) return;

      // 1. On crée l'entrée dans histo_panier (L'entête de la commande)
      // 2. On récupère l'ID
      // 3. On boucle sur 'items' pour remplir la table 'contenir'
      
      print("Commande de $total € envoyée pour l'utilisateur $userId");
    } catch (e) {
      print("Erreur lors de la sauvegarde : $e");
      rethrow;
    }
  }
}