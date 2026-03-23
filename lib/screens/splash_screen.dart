import 'package:flutter/material.dart';
import 'home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Simulation d'un temps de rechargement de 2 secondes
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        // Une fois chargé, on va vers la salle (Home)
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const HomeScreen()),
        );
      }
    });
  }



@override 
Widget build(BuildContext context) {
  return const Scaffold(
    backgroundColor: Colors.orange, // La couleur du restaurant
    body: Center( 
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.restaurant_menu, size: 80, color: Colors.white),
          SizedBox(height: 20),
          Text(
            "My Restaurant",
            style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),
          CircularProgressIndicator(color: Colors.white),
        ],
      ),
    ),
  );
}
}