import 'package:flutter/material.dart';
import '../models/product.dart';
import '../services/cart_service.dart';
import '../services/favorite_service.dart'; // ✅ Import du nouveau service

class ProductDetailScreen extends StatefulWidget { // ✅ On passe en StatefulWidget pour changer l'icône
  final Product product;
  const ProductDetailScreen({super.key, required this.product});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  @override
  Widget build(BuildContext context) {
    // On utilise widget.product car on est dans la classe State
    final product = widget.product; 

    return Scaffold(
      appBar: AppBar(
        title: Text(product.title),
        backgroundColor: Colors.orange,
        actions: [
          // ✅ LE BOUTON FAVORIS
          IconButton(
            icon: Icon(
              FavoriteService.isFavorite(product) ? Icons.favorite : Icons.favorite_border,
              color: FavoriteService.isFavorite(product) ? Colors.red : Colors.white,
            ),
            onPressed: () {
              setState(() {
                FavoriteService.toggleFavorite(product);
              });
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(FavoriteService.isFavorite(product) ? "Ajouté aux favoris" : "Retiré des favoris"),
                  duration: const Duration(seconds: 1),
                ),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.network(product.imageUrl, width: double.infinity, height: 300, fit: BoxFit.cover),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(product.title, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 10),
                  Text("${product.price} €", style: const TextStyle(fontSize: 20, color: Colors.orange, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 20),
                  Text(product.description, style: const TextStyle(fontSize: 16)),
                  const SizedBox(height: 30),
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(double.infinity, 50),
                      backgroundColor: Colors.orange,
                    ),
                    onPressed: () {
                      CartService.addProduct(product);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Ajouté au panier !"), duration: Duration(seconds: 1)),
                      );
                    },
                    icon: const Icon(Icons.add_shopping_cart, color: Colors.white),
                    label: const Text("AJOUTER AU PANIER", style: TextStyle(color: Colors.white)),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}