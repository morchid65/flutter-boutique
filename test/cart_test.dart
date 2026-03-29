import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_boutique/services/cart_service.dart';
import 'package:flutter_boutique/models/product.dart';

void main() {
  test('Calcul du total panier avec plusieurs articles', () {
    final p1 = Product(id: 1, title: "Souris", price: 50.0, description: "", imageUrl: "");
    
    // On nettoie le panier avant le test
    CartService.items.clear();

    CartService.addProduct(p1);
    CartService.addProduct(p1); // 2 x 50€

    expect(CartService.totalPrice, 100.0);
    expect(CartService.items.length, 1); // 1 seul type de produit
    expect(CartService.items[0].quantity, 2); // Mais en quantité 2
  });
}