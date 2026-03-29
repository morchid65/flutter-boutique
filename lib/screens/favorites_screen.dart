import 'package:flutter/material.dart';
import '../services/favorite_service.dart';
import 'product_detail_screen.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key});

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  @override
  Widget build(BuildContext context) {
    final favorites = FavoriteService.favorites;

    return Scaffold(
      appBar: AppBar(title: const Text("Mes Favoris"), backgroundColor: Colors.orange),
      body: favorites.isEmpty
          ? const Center(child: Text("Aucun favori pour l'instant."))
          : ListView.builder(
              itemCount: favorites.length,
              itemBuilder: (context, index) {
                final product = favorites[index];
                return ListTile(
                  leading: Image.network(product.imageUrl, width: 50, height: 50, fit: BoxFit.cover),
                  title: Text(product.title),
                  subtitle: Text("${product.price} €"),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ProductDetailScreen(product: product)),
                    ).then((_) => setState(() {})); // Magie : rafraîchit la liste au retour
                  },
                );
              },
            ),
    );
  }
}