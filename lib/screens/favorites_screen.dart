import 'package:flutter/material.dart';
import '../models/product.dart';
import '../services/favorite_service.dart';
import '../services/api_service.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key});

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Mes Favoris"), backgroundColor: Colors.orange),
      body: FutureBuilder<List<Product>>(
        future: ApiService().getProducts(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());
          
          // On ne garde que les produits dont l'ID est dans la liste des favoris
          final favorites = snapshot.data!.where((p) => FavoriteService.isFavorite(p.id)).toList();

          if (favorites.isEmpty) {
            return const Center(child: Text("Aucun favori pour le moment."));
          }

          return ListView.builder(
            itemCount: favorites.length,
            itemBuilder: (context, index) {
              final product = favorites[index];
              return ListTile(
                leading: Image.network(product.imageUrl, width: 50, fit: BoxFit.cover),
                title: Text(product.title),
                trailing: IconButton(
                  icon: const Icon(Icons.favorite, color: Colors.red),
                  onPressed: () async {
                    // ✅ CORRECTION ICI : on passe product.id (int)
                    await FavoriteService.toggleFavorite(product.id);
                    setState(() {}); // Rafraîchit l'écran
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}