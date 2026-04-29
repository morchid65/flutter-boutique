import 'package:flutter/material.dart';
import '../services/favorite_service.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

// Ajout du 's' pour correspondre à ton appel dans main_screen
class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key});

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  @override
  Widget build(BuildContext context) {
    final favoriteIds = FavoriteService.favoriteIds;

    return Scaffold(
      appBar: AppBar(title: const Text("Mes Favoris")),
      body: favoriteIds.isEmpty
          ? const Center(child: Text("Aucun favori pour le moment"))
          : FutureBuilder(
              future: Supabase.instance.client
                  .from('produit')
                  .select()
                  // Correction ici : on utilise .inFilter
                  .inFilter('id_produit', favoriteIds),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                
                if (snapshot.hasError) {
                  return Center(child: Text("Erreur : ${snapshot.error}"));
                }

                final items = snapshot.data as List;
                return ListView.builder(
                  itemCount: items.length,
                  itemBuilder: (context, index) {
                    final item = items[index];
                    return ListTile(
                      leading: item['image_url'] != null 
                        ? Image.network(item['image_url'], width: 50, errorBuilder: (c, e, s) => const Icon(Icons.fastfood))
                        : const Icon(Icons.fastfood),
                      title: Text(item['titre'] ?? 'Produit sans nom'),
                      subtitle: Text("${item['prix']} €"),
                      trailing: IconButton(
                        icon: const Icon(Icons.favorite, color: Colors.red),
                        onPressed: () async {
                          await FavoriteService.toggleFavorite(item['id_produit']);
                          // On redemande à l'écran de se dessiner
                          setState(() {}); 
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