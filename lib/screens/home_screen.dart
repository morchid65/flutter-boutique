import 'package:flutter/material.dart';
import '../models/product.dart';
import '../services/api_service.dart';
import '../services/favorite_service.dart';
import 'product_detail_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // On stocke le futur ici pour éviter de relancer la requête SQL à chaque clic sur un cœur
  late Future<List<Product>> _productsFuture;

  @override
  void initState() {
    super.initState();
    _productsFuture = ApiService().getProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Le menu du Resto"),
        backgroundColor: Colors.orange,
      ),
      body: FutureBuilder<List<Product>>(
        future: _productsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          
          if (snapshot.hasError) {
            return Center(child: Text("Erreur : ${snapshot.error}"));
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text("Aucun produit trouvé."));
          }

          final products = snapshot.data!;
          return ListView.builder(
            itemCount: products.length,
            itemBuilder: (context, index) {
              final product = products[index];
              
              // On vérifie l'état du favori dans notre service statique
              final isFav = FavoriteService.isFavorite(product.id);

              return ListTile(
                leading: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    product.imageUrl, 
                    width: 50, 
                    height: 50, 
                    fit: BoxFit.cover,
                    // Si l'image bugue (404), on affiche un burger par défaut
                    errorBuilder: (c, e, s) => const Icon(Icons.fastfood, color: Colors.orange),
                  ),
                ),
                title: Text(product.title),
                subtitle: Text("${product.price} €"),
                
                // LE BOUTON CŒUR DYNAMIQUE
                trailing: IconButton(
                  icon: Icon(
                    isFav ? Icons.favorite : Icons.favorite_border,
                    color: isFav ? Colors.red : null,
                  ),
                  onPressed: () async {
                    // Action dans Supabase + Ardoise locale
                    await FavoriteService.toggleFavorite(product.id);
                    
                    // ON RAFRAÎCHIT L'ÉCRAN
                    // Comme _productsFuture est figé, cela ne recharge PAS les données du serveur
                    // Cela change juste la couleur de l'icône instantanément.
                    setState(() {}); 
                  },
                ),

                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ProductDetailScreen(product: product),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}