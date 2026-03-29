import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/cart_item.dart';
import '../models/product.dart';

class CartService {
  static final _supabase = Supabase.instance.client;
  
  // Ta liste d'objets CartItem
  static final List<CartItem> _items = [];

  static List<CartItem> get items => _items;

  // 1. Ajouter un produit (Ta logique corrigée)
  static void addProduct(Product product) {
    // On cherche si le produit existe déjà
    final index = _items.indexWhere((item) => item.product.id == product.id);

    if (index != -1) {
      // Si oui, on augmente la quantité
      _items[index].quantity++;
    } else {
      // Si non, on l'ajoute à la liste
      _items.add(CartItem(product: product, quantity: 1));
    }
  }

  // 2. Calcul du prix total
  static double get totalPrice =>
      _items.fold(0, (sum, item) => sum + (item.product.price * item.quantity));

  // 3. LA LOGIQUE SUPABASE (Validation de commande)
  static Future<void> checkout() async {
    final user = _supabase.auth.currentUser;
    
    if (user == null) throw Exception("Connectez-vous pour commander");
    if (_items.isEmpty) throw Exception("Le panier est vide");

    try {
      // ÉTAPE A : Créer l'entrée dans 'histo_panier'
      final panierResponse = await _supabase
          .from('histo_panier')
          .insert({
            'id_utilisateur': user.id,
            'date_panier': DateTime.now().toIso8601String(),
          })
          .select()
          .single();

      final int idPanier = panierResponse['id_panier'];

      // ÉTAPE B : Préparer les lignes pour la table 'contenir'
      // On transforme notre liste de CartItem en format JSON pour Supabase
      final List<Map<String, dynamic>> details = _items.map((item) {
        return {
          'id_panier': idPanier,
          'id_produit': item.product.id,
          'quantite': item.quantity,
        };
      }).toList();

      // ÉTAPE C : Insertion groupée
      await _supabase.from('contenir').insert(details);

      // ÉTAPE D : Vider le panier après succès
      _items.clear();

    } catch (e) {
      print("Erreur checkout : $e");
      throw Exception("Erreur lors de la validation : $e");
    }
  }
}