class Product {
  final int id; 
  final String title;
  final double price;
  final String description;
  final String imageUrl;

  // Le constructeur :  la "recette" pour créer l'objet en mémoire
  Product({
    required this.id,
    required this.title,
    required this.price,
    required this.description,
    required this.imageUrl,
  });

  // La "Factory" :  elle traduit le langage de l'API (JSON) en langage Dart.
  // C'est comme transformer un bon de commande en un vrai plat cuisiné.
  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      title: json['title'],
      // On reconvertit le prix en nombre à virgule (double) pour éviter les bugs
      price: (json['price'] as num).toDouble(),
      description: json['description'],
      // L'API Platzi envoie une liste d'images, on prend la première [0]
      imageUrl: json['images'][0],
    );
  }
}