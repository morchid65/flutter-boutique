import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:flutter_boutique/providers/cart_provider.dart';
import 'package:flutter_boutique/screens/home_screen.dart';

void main() {
  testWidgets('Thomas ajoute un Burger au panier', (WidgetTester tester) async {
    // On prépare l'app avec le Provider
    await tester.pumpWidget(
      ChangeNotifierProvider(
        create: (_) => CartProvider(),
        child: const MaterialApp(home: HomeScreen()),
      ),
    );

    // 1. On attend que les produits (simulés dans ton ApiService) s'affichent
    await tester.pumpAndSettle();

    // 2. Thomas clique sur l'icône d'ajout au panier du premier produit
    final addIcon = find.byIcon(Icons.add_shopping_cart).first;
    await tester.tap(addIcon);
    
    // On reconstruit l'écran après le clic
    await tester.pump();

    // 3. VERIFICATION : Le SnackBar s'affiche-t-il ?
    expect(find.byType(SnackBar), findsOneWidget);
    
    // 4. VERIFICATION : Le badge du panier affiche-t-il "1" ?
    expect(find.text('1'), findsOneWidget);
  });
}