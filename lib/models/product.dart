class Product {
  final int id;
  final String title;
  final double price;
  final String imageUrl;

  Product({
    required this.id,
    required this.title,
    required this.price,
    required this.imageUrl,
  });

  factory Product.fromSupabase(Map<String, dynamic> map) {
    return Product(
      id: map['id_produit'] as int,
      title: map['titre'] as String,
      price: (map['prix'] as num).toDouble(),
      imageUrl: map['image_url'] as String,
    );
  }
}