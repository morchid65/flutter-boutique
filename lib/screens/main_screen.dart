import 'package:flutter/material.dart';
import 'home_screen.dart';
import 'favorites_screen.dart';
import 'cart_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0; // L'index de l'onglet actif (0 = Home)

  // La liste de nos écrans principaux
  final List<Widget> _screens = [
    const HomeScreen(),
    const FavoritesScreen(),
    const CartScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex], // On affiche l'écran correspondant à l'index
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index; // On change d'onglet au clic
          });
        },
        selectedItemColor: Colors.orange,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Accueil'),
          BottomNavigationBarItem(icon: Icon(Icons.favorite), label: 'Favoris'),
          BottomNavigationBarItem(icon: Icon(Icons.shopping_cart), label: 'Panier'),
        ],
      ),
    );
  }
}