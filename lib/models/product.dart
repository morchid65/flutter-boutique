class Product {
  final int id;
  final String title;
  final double price;
  final String description;
  final String imageUrl;

  Product({
    required this.id,
    required this.title,
    required this.price,
    required this.description,
    required this.imageUrl,
  });

  // ✅ On change 'fromJson' par 'fromSupabase' avec tes vrais noms de colonnes
  factory Product.fromSupabase(Map<String, dynamic> map) {
    return Product(
      id: map['id_produit'],      // Nom exact dans ton SQL
      title: map['titre'],        // Nom exact dans ton SQL
      price: (map['prix'] as num).toDouble(),
      description: map['description'] ?? '',
      imageUrl: map['image_url'] ?? '', // Nom exact dans ton SQL
    );
  }
}