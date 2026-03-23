import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_boutique/models/product.dart';

void main() {
  // On définit un test 
  test('Le modèle Product doit transformer le JSON correctement', () {
    // 1. On prépare un faux morceau de texte (JSON)
    final map = {
      "id":1,
      "title": "Burger Gourmet",
      "price": 12.5,
      "description": "Un burger magnifique",
      "images": ["https://photo.com/burger.jpg"]
    };

    // 2. On utilise notre "moule" Product
    final product = Product.fromJson(map);

    // 3. on vérifie que les données sont bien à leur place 
    expect(product.id, 1);
    expect(product.title, "Burger Gourmet");
    expect(product.price, 12.5);
    expect(product.imageUrl, ["https://photo.com/burger.jpg"]);
  });
}