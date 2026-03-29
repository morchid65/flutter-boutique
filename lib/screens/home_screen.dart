import 'package:flutter/material.dart';
import '../models/product.dart';
import '../services/api_service.dart';
import '../services/cart_service.dart';
import 'cart_screen.dart';
import 'product_detail_screen.dart'; // ✅ L'import indispensable pour que ça marche

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ApiService apiService = ApiService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Le menu du Resto"),
        backgroundColor: Colors.orange,
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const CartScreen()),
              );
            },
          )
        ],
      ),
      body: FutureBuilder<List<Product>>(
        future: apiService.getProducts(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Erreur : ${snapshot.error}"));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text("Aucun produit trouvé."));
          } else {
            final products = snapshot.data!;
            return ListView.builder(
              itemCount: products.length,
              itemBuilder: (context, index) {
                final product = products[index];
                return ListTile(
                  leading: Image.network(
                    product.imageUrl,
                    width: 50,
                    height: 50,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => const Icon(Icons.broken_image),
                  ),
                  title: Text(product.title),
                  subtitle: Text("${product.price} €"),
                  
                  // ✅ LE CLIC POUR ALLER AUX DÉTAILS
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProductDetailScreen(product: product),
                      ),
                    );
                  },

                  trailing: IconButton(
                    icon: const Icon(Icons.add_shopping_cart, color: Colors.orange),
                    onPressed: () {
                      CartService.addProduct(product);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text("${product.title} ajouté !"),
                          duration: const Duration(seconds: 1),
                          backgroundColor: Colors.green,
                        ),
                      );
                    },
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}