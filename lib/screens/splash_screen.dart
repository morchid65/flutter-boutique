import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart'; // ✅ Pour lire le Post-it
import 'onboarding_screen.dart'; // ✅ Pour envoyer vers la présentation
import 'main_screen.dart'; // ✅ Pour envoyer vers l'accueil principal

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToNext(); // On appelle la fonction d'aiguillage
  }

  // ✅ La fonction qui décide du chemin
  Future<void> _navigateToNext() async {
    // 1. On attend 3 secondes pour laisser le temps de voir le logo
    await Future.delayed(const Duration(seconds: 3)); 

    // 2. On ouvre le coffre-fort des préférences locales
    final prefs = await SharedPreferences.getInstance();
    
    // 3. On regarde si on doit afficher l'onboarding (vrai par défaut)
    final bool showOnboarding = prefs.getBool('showOnboarding') ?? true;

    if (!mounted) return; // Sécurité Flutter

    if (showOnboarding) {
      // Direction la présentation
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const OnboardingScreen()),
      );
    } else {
      // Direction le menu principal (MainScreen gère le bas de l'écran)
      Navigator.pushReplacementNamed(context, '/home');
    }
  }

  @override 
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.orange,
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