import 'package:flutter/material.dart';
import '../services/cart_service.dart';
import '../services/api_service.dart';
import '../models/product.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final ApiService apiService = ApiService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Mon Panier"), backgroundColor: Colors.orange),
      body: FutureBuilder<List<Product>>(
        future: apiService.getProducts(), // On récupère tous les produits pour matcher les IDs
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          final cartItems = CartService.items;
          if (cartItems.isEmpty) {
            return const Center(child: Text("Votre panier est vide 🛒"));
          }

          final allProducts = snapshot.data!;
          // On ne garde que les produits qui sont dans le panier
          final productsInCart = allProducts.where((p) => cartItems.containsKey(p.id)).toList();

          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: productsInCart.length,
                  itemBuilder: (context, index) {
                    final product = productsInCart[index];
                    final quantity = cartItems[product.id];
                    return ListTile(
                      leading: Image.network(product.imageUrl, width: 50, errorBuilder: (c, e, s) => const Icon(Icons.broken_image)),
                      title: Text(product.title),
                      subtitle: Text("${product.price} € x $quantity"),
                      trailing: Text("${(product.price * quantity!).toStringAsFixed(2)} €"),
                    );
                  },
                ),
              ),
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(color: Colors.grey[200], borderRadius: const BorderRadius.vertical(top: Radius.circular(20))),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("Total :", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                        Text("${CartService.getTotalPrice(allProducts).toStringAsFixed(2)} €", 
                             style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.orange)),
                      ],
                    ),
                    const SizedBox(height: 20),
                    
                    // ✅ LE BOUTON VALIDER CORRIGÉ
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orange,
                        minimumSize: const Size(double.infinity, 50),
                      ),
                      onPressed: () async {
                        try {
                          // 1. Appel au service Supabase
                          await CartService.checkout();
                          
                          // 2. Si ça marche, on prévient l'utilisateur
                          if (context.mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text("🚀 Commande validée sur Supabase !"), backgroundColor: Colors.green),
                            );
                            Navigator.pop(context); // Retour à l'accueil
                          }
                        } catch (e) {
                          // 3. Si ça plante (ex: pas d'internet)
                          if (context.mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text("Erreur : ${e.toString()}"), backgroundColor: Colors.red),
                            );
                          }
                        }
                      },
                      child: const Text("VALIDER LA COMMANDE", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}