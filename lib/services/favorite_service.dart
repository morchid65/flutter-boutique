import '../models/product.dart';

class FavoriteService {
  // Notre liste de favoris (en mémoire pour l'instant)
  static final List<Product> _favorites = [];

  static List<Product> get favorites => _favorites;

  // Ajouter ou Retirer (Toggle)
  static void toggleFavorite(Product product) {
    if (_favorites.any((p) => p.id == product.id)) {
      _favorites.removeWhere((p) => p.id == product.id);
    } else {
      _favorites.add(product);
    }
  }

  // Vérifier si un produit est favori
  static bool isFavorite(Product product) {
    return _favorites.any((p) => p.id == product.id);
  }
}