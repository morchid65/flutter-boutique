import 'package:flutter/material.dart';
import '../models/product.dart';
import '../services/api_service.dart';
import '../services/favorite_service.dart';
import 'product_detail_screen.dart';
import 'package:provider/provider.dart'; // Ajout de l'écouteur
import '../providers/cart_provider.dart'; 

// On peut même repasser en StatelessWidget si on veut, mais gardons ta structure
class _HomeScreenState extends State<HomeScreen> {
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
        // PETIT BONUS : On affiche le nombre d'articles dans le panier ici !
        actions: [
          Consumer<CartProvider>(
            builder: (context, cart, child) => Badge(
              label: Text(cart.items.length.toString()),
              child: IconButton(icon: const Icon(Icons.shopping_cart), onPressed: () => Navigator.pushNamed(context, '/cart')),
            ),
          ),
        ],
      ),
      body: FutureBuilder<List<Product>>(
        future: _productsFuture,
        builder: (context, snapshot) {
          // ... (Gestion d'erreur et loading identiques) ...

          final products = snapshot.data!;
          return ListView.builder(
            itemCount: products.length,
            itemBuilder: (context, index) {
              final product = products[index];
              final isFav = FavoriteService.isFavorite(product.id);

              return ListTile(
                // ... (Leading et Title identiques) ...
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: Icon(isFav ? Icons.favorite : Icons.favorite_border, color: isFav ? Colors.red : null),
                      onPressed: () async {
                        await FavoriteService.toggleFavorite(product.id);
                        setState(() {}); // Pour les favoris (pour l'instant)
                      },
                    ),
                    // NOUVEAU : Bouton ajout rapide au panier via Provider
                    IconButton(
                      icon: const Icon(Icons.add_shopping_cart, color: Colors.orange),
                      onPressed: () {
                        context.read<CartProvider>().addProduct(product); // L'IA enregistre l'info !
                      },
                    ),
                  ],
                ),
                // ... onTap identique ...
              );
            },
          );
        },
      ),
    );
  }
}