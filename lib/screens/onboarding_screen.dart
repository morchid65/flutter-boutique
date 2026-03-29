import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  bool _neverShowAgain = false;

  Future<void> _completeOnboarding() async {
    if (_neverShowAgain) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('showOnboarding', false);
    }
    if (mounted) {
      Navigator.pushReplacementNamed(context, '/home');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const Spacer(),
            const Icon(Icons.auto_awesome, size: 100, color: Colors.orange),
            const SizedBox(height: 40),
            const Text("Bienvenue sur EatSmart", style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
            const Padding(
              padding: EdgeInsets.all(20),
              child: Text("Découvrez les meilleurs plats de votre quartier.", textAlign: TextAlign.center),
            ),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Checkbox(
                  value: _neverShowAgain,
                  onChanged: (val) => setState(() => _neverShowAgain = val!),
                ),
                const Text("Ne plus afficher cet écran"),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(minimumSize: const Size(double.infinity, 50), backgroundColor: Colors.orange),
                onPressed: _completeOnboarding,
                child: const Text("COMMENCER", style: TextStyle(color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}