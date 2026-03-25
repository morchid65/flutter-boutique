import 'package:flutter/material.dart';
import '../services/cart_service.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // 1. On récupère les données
    final cartItems = CartService.items;

    // 2. On retourne TOUT le design dans le build
    return Scaffold(
      appBar: AppBar(
        title: const Text("Mon Panier"),
        backgroundColor: Colors.orange,
      ),
      body: cartItems.isEmpty
          ? const Center(child: Text("Votre panier est vide 🛒"))
          : Column(
              children: [
                Expanded( 
                  child: ListView.builder(
                    itemCount: cartItems.length,
                    itemBuilder: (context, index) {
                      final item = cartItems[index]; 
                      return ListTile(
                        leading: Image.network(item.product.imageUrl, width: 50),
                        title: Text(item.product.title),
                        subtitle: Text("${item.product.price} € x ${item.quantity}"),
                        trailing: Text("${(item.product.price * item.quantity).toStringAsFixed(2)} €"), // ✅ Corrigé calcul
                      );
                    },
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    border: const Border(top: BorderSide(color: Colors.orange, width: 2)),
                  ),
                  child: Row( 
                    mainAxisAlignment: MainAxisAlignment.spaceBetween, 
                    children: [
                      const Text("TOTAL", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                      Text(
                        "${CartService.totalPrice.toStringAsFixed(2)} €", 
                        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.orange),
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}
