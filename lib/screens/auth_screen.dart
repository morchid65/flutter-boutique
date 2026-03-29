import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _supabase = Supabase.instance.client;
  bool _isLoading = false;

  // --- LA LOGIQUE ---
  Future<void> _handleAuth(bool isSignUp) async {
    setState(() => _isLoading = true);
    try {
      if (isSignUp) {
        await _supabase.auth.signUp(email: _emailController.text, password: _passwordController.text);
        if (mounted) _showMessage("Compte créé ! Vérifiez vos emails.");
      } else {
        await _supabase.auth.signInWithPassword(email: _emailController.text, password: _passwordController.text);
        if (mounted) Navigator.pushReplacementNamed(context, '/home');
      }
    } catch (e) {
      if (mounted) _showMessage("Erreur : $e", isError: true);
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  void _showMessage(String msg, {bool isError = false}) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg), backgroundColor: isError ? Colors.red : Colors.green));
  }

  // --- LE VISUEL ---
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Connexion / Inscription"), backgroundColor: Colors.orange),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            TextField(controller: _emailController, decoration: const InputDecoration(labelText: "Email")),
            TextField(controller: _passwordController, decoration: const InputDecoration(labelText: "Mot de passe"), obscureText: true),
            const SizedBox(height: 30),
            if (_isLoading) const CircularProgressIndicator(),
            if (!_isLoading) ...[
              ElevatedButton(
                style: ElevatedButton.styleFrom(minimumSize: const Size(double.infinity, 50), backgroundColor: Colors.orange),
                onPressed: () => _handleAuth(false), 
                child: const Text("SE CONNECTER", style: TextStyle(color: Colors.white)),
              ),
              TextButton(onPressed: () => _handleAuth(true), child: const Text("Créer un compte")),
              // LE BOUTON DE SECOURS
              TextButton(
                onPressed: () async {
                  if (_emailController.text.isEmpty) {
                    _showMessage("Entrez votre email d'abord", isError: true);
                    return;
                  }
                  await _supabase.auth.resetPasswordForEmail(_emailController.text);
                  _showMessage("Lien de réinitialisation envoyé !");
                }, 
                child: const Text("Mot de passe oublié ?", style: TextStyle(color: Colors.grey)),
              ),
            ]
          ],
        ),
      ),
    );
  }
}