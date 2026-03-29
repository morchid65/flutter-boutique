import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/product.dart';

class ApiService {
  // ✅ On utilise le client Supabase au lieu de l'URL http
  final _supabase = Supabase.instance.client;

  Future<List<Product>> getProducts() async {
    try {
      // ✅ On récupère les données de TA table 'produit'
      final List<dynamic> data = await _supabase.from('produit').select();

      // ✅ On transforme les lignes SQL en objets Product
      return data.map((item) => Product.fromSupabase(item)).toList();
    } catch (e) {
      throw Exception("Erreur Supabase : $e");
    }
  }
}