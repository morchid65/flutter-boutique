import '../models/cart_item.dart';
import '../models/product.dart';

class CartService {
    // Liste partagée (Singleton simple pour l'instant)
    static final List<CartItem> _items = [];

    static List<CartItem> get items => _items;

    static void addProduct(Product product) {
        // Vérifier si le produit est déjà dans le panier
        // Remplace orELse par orElse
        var existingItem = _items.firstWhere(
        (item) => item.product.id == product.id,
        orElse: () => CartItem(product: product, quantity: 0), // <--- Ici avec un "l" minuscule
        );

        if (existingItem.quantity == 0) {
            _items.add(existingItem);
        }
        existingItem.quantity++;
    }

    static double get totalPrice =>
    _items.fold(0, (sum, item) => sum + (item.product.price * item.quantity));
}