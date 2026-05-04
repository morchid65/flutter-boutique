import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; // ✅ Nécessaire pour utiliser context.read
import '../models/product.dart';
import '../providers/cart_provider.dart';

class ProductDetailScreen extends StatelessWidget {
  final Product product;
  const ProductDetailScreen({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(product.title),
        backgroundColor: Colors.orange,
      ),
      body: Column(
        children: [
          Image.network(
            product.imageUrl, 
            height: 300, 
            width: double.infinity, 
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) => const Icon(Icons.broken_image, size: 100),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.title, 
                  style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)
                ),
                Text(
                  "${product.price} €", 
                  style: const TextStyle(fontSize: 20, color: Colors.orange)
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      // ✅ CORRECTION : On utilise le Provider, pas CartService
                      context.read<CartProvider>().addProduct(product);

                      // ✅ Message de confirmation
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text("${product.title} ajouté au panier !"),
                          backgroundColor: Colors.green,
                          duration: const Duration(seconds: 2),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange,
                      padding: const EdgeInsets.symmetric(vertical: 15),
                    ),
                    child: const Text(
                      "Ajouter au panier", 
                      style: TextStyle(color: Colors.white, fontSize: 18)
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}