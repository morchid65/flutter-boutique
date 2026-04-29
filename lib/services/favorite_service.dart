import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class FavoriteService {
  // L'Ardoise magique : on stocke les IDs des produits aimés
  static final List<int> _favoriteIds = [];
  static final _supabase = Supabase.instance.client;

  // Getters pour que les écrans puissent lire les données
  static List<int> get favoriteIds => _favoriteIds;
  
  // Vérifie si un produit spécifique est dans l'Ardoise
  static bool isFavorite(int productId) => _favoriteIds.contains(productId);

  /// 1. CHARGER : On va chercher les favoris dans la cave au démarrage
  static Future<void> fetchFavorites() async {
    final user = _supabase.auth.currentUser;
    if (user == null) return;

    try {
      final data = await _supabase
          .from('favoris')
          .select('id_produit')
          .eq('id_utilisateur', user.id);
      
      _favoriteIds.clear(); // On vide l'ardoise avant de la remplir
      for (var row in (data as List)) {
        // On s'assure de bien stocker des entiers (int)
        _favoriteIds.add(row['id_produit'] as int);
      }
      debugPrint("⭐ Ardoise mise à jour : $_favoriteIds");
    } catch (e) {
      debugPrint("❌ Erreur lors du fetch des favoris : $e");
    }
  }

  /// 2. TOGGLE : Ajouter ou Supprimer (Le bouton Cœur)
  static Future<void> toggleFavorite(int productId) async {
    final user = _supabase.auth.currentUser;
    if (user == null) {
      debugPrint("⛔ Action impossible : Utilisateur non connecté");
      return;
    }

    try {
      if (isFavorite(productId)) {
        // --- CAS : DÉJÀ AIMÉ -> ON SUPPRIME ---
        await _supabase.from('favoris').delete().match({
          'id_utilisateur': user.id,
          'id_produit': productId,
        });
        _favoriteIds.remove(productId); // On efface de l'ardoise locale
        debugPrint("💔 Produit $productId retiré des favoris");
      } else {
        // --- CAS : PAS ENCORE AIMÉ -> ON AJOUTE ---
        await _supabase.from('favoris').insert({
          'id_utilisateur': user.id,
          'id_produit': productId,
        });
        _favoriteIds.add(productId); // On écrit sur l'ardoise locale
        debugPrint("❤️ Produit $productId ajouté aux favoris");
      }
    } catch (e) {
      // Si Supabase renvoie une erreur (ex: problème de RLS ou réseau)
      debugPrint("❌ Erreur SQL lors du toggle : $e");
    }
  }
}