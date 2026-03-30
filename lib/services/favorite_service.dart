import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class FavoriteService {
  static final List<int> _favoriteIds = [];
  static final _supabase = Supabase.instance.client;

  static List<int> get favoriteIds => _favoriteIds;
  static bool isFavorite(int productId) => _favoriteIds.contains(productId);

  // 1. Charger les favoris depuis la table 'public.favoris'
  static Future<void> fetchFavorites() async {
    final user = _supabase.auth.currentUser;
    if (user == null) return;

    try {
      final data = await _supabase
          .from('favoris')
          .select('id_produit')
          .eq('id_utilisateur', user.id); // user.id est l'UUID de auth.users
      
      _favoriteIds.clear();
      for (var row in (data as List)) {
        _favoriteIds.add(row['id_produit'] as int);
      }
      debugPrint("⭐ Favoris chargés : $_favoriteIds");
    } catch (e) {
      debugPrint("❌ Erreur fetch favoris : $e");
    }
  }

  // 2. Ajouter/Supprimer dans la table 'public.favoris'
  static Future<void> toggleFavorite(int productId) async {
    final user = _supabase.auth.currentUser;
    if (user == null) {
      debugPrint("Faut être connecté pour liker !");
      return;
    }

    try {
      if (isFavorite(productId)) {
        await _supabase.from('favoris').delete().match({
          'id_utilisateur': user.id,
          'id_produit': productId,
        });
        _favoriteIds.remove(productId);
      } else {
        await _supabase.from('favoris').insert({
          'id_utilisateur': user.id,
          'id_produit': productId,
        });
        _favoriteIds.add(productId);
      }
    } catch (e) {
      debugPrint("❌ Erreur toggle favoris : $e");
    }
  }
}