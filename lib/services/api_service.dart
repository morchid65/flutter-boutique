import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/product.dart';

class ApiService {
  // L'adresse du grossiste (API Platzi)
  final String baseUrl = "https://api.escuelajs.co/api/v1/products";

  // Fonction pour récupérer la liste des plats
  Future<List<Product>> getProducts() async {
    final response = await http.get(Uri.parse(baseUrl));

    if (response.statusCode == 200) {
      // Si la livraison est ok (code 200)
      List<dynamic> body = jsonDecode(response.body);

      // On transforme le texte brut en liste d'objets "Product"
      return body.map((item) => Product.fromJson(item)).toList();
    } else { 
      // Si le livreur est perdu
      throw Exception("Impossible de charger les produits");
    }
  }
}
