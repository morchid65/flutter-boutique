import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_boutique/models/product.dart';

void main() {
  test('Vérification de la conversion SQL -> Product', () {
    final map = {
      "id_produit": 1,
      "titre": "Manette Razer",
      "prix": 150.0,
      "description": "Top qualité",
      "image_url": "https://img.com/razer.jpg"
    };

    final product = Product.fromSupabase(map);

    expect(product.title, "Manette Razer");
    expect(product.price, 150.0);
    expect(product.id, 1);
  });
}