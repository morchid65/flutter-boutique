import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; 
import '../models/product.dart';
import '../services/api_service.dart';
import '../services/favorite_service.dart';
import '../providers/cart_provider.dart'; 
import 'product_detail_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

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
        actions: [
          Consumer<CartProvider>(
            builder: (context, cart, child) => Badge(
              label: Text(cart.items.length.toString()),
              child: IconButton(
                icon: const Icon(Icons.shopping_cart), 
                onPressed: () => Navigator.pushNamed(context, '/cart'),
              ),
            ),
          ),
        ],
      ),
      body: FutureBuilder<List<Product>>(
        future: _productsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Erreur : ${snapshot.error}"));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text("Aucun produit trouvé."));
          }

          final products = snapshot.data!;
          return ListView.builder(
            itemCount: products.length,
            itemBuilder: (context, index) {
              final product = products[index];
              final isFav = FavoriteService.isFavorite(product.id);

              return ListTile(
                leading: Image.network(product.imageUrl, width: 50, 
                  errorBuilder: (context, error, stackTrace) => const Icon(Icons.fastfood)),
                title: Text(product.title), // Corrigé : .title au lieu de .name
                subtitle: Text("${product.price} €"),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: Icon(isFav ? Icons.favorite : Icons.favorite_border, 
                        color: isFav ? Colors.red : null),
                      onPressed: () async {
                        await FavoriteService.toggleFavorite(product.id);
                        setState(() {}); 
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.add_shopping_cart, color: Colors.orange),
                      onPressed: () {
                        context.read<CartProvider>().addProduct(product);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("${product.title} ajouté !"), duration: const Duration(seconds: 1)),
                        );
                      },
                    ),
                  ],
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ProductDetailScreen(product: product)),
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