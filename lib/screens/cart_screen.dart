import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; // L'outil pour écouter l'IA
import '../providers/cart_provider.dart'; // On pointe vers le nouveau cerveau

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // On utilise Consumer pour que l'écran "écoute" les changements du panier
    return Consumer<CartProvider>(
      builder: (context, cartProvider, child) {
        final items = cartProvider.items; // On récupère la liste via le provider

        return Scaffold(
          appBar: AppBar(title: const Text("Mon Panier")),
          body: items.isEmpty
              ? const Center(child: Text("Votre panier est vide"))
              : Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        itemCount: items.length,
                        itemBuilder: (context, index) {
                          final item = items[index];
                          return ListTile(
                            leading: Image.network(
                              item.product.imageUrl, 
                              width: 40, 
                              errorBuilder: (c, e, s) => const Icon(Icons.fastfood)
                            ),
                            title: Text(item.product.title),
                            subtitle: Text("${item.product.price}€ x ${item.quantity}"),
                            // BOUTON SUPPRIMER (Étape 3 du projet)
                            trailing: IconButton(
                              icon: const Icon(Icons.delete_outline, color: Colors.red),
                              onPressed: () {
                                // On dit au provider de retirer le produit
                                cartProvider.removeProduct(item.product);
                              },
                            ),
                          );
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          // Le prix total se met à jour tout seul !
                          Text(
                            "Total : ${cartProvider.totalPrice.toStringAsFixed(2)}€", 
                            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)
                          ),
                          const SizedBox(height: 10),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () async {
                                await cartProvider.checkout(); //
                                if (context.mounted) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(content: Text("Commande validée !")),
                                  );
                                }
                              },
                              style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
                              child: const Text("PAYER", style: TextStyle(color: Colors.white)),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
        );
      },
    );
  }
}