import 'package:flutter/material.dart';
import '../models/product.dart';
import '../services/api_service.dart';
import '../services/cart_service.dart';

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
        // ✅ 2. Ajout d'un bouton pour aller voir le panier plus tard
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: () {
              // On fera la navigation vers la page Panier ici
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
                  // ✅ 3. On met l'image au début (leading) pour libérer la place à droite
                  leading: Image.network(
                    product.imageUrl,
                    width: 50,
                    height: 50,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => const Icon(Icons.broken_image),
                  ),
                  title: Text(product.title),
                  subtitle: Text("${product.price} €"),
                  // ✅ 4. Le bouton d'ajout (trailing)
                  trailing: IconButton(
                    icon: const Icon(Icons.add_shopping_cart, color: Colors.orange),
                    onPressed: () {
                      // Action : Appel du service
                      CartService.addProduct(product);
                      
                      // Feedback : On prévient l'utilisateur
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