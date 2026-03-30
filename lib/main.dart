import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'screens/splash_screen.dart'; 
import 'screens/main_screen.dart';
import 'screens/auth_screen.dart'; 
import 'services/favorite_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");

  await Supabase.initialize(
    url: dotenv.env['SUPABASE_URL']!,
    anonKey: dotenv.env['SUPABASE_ANON_KEY']!, 
  );

  final supabase = Supabase.instance.client;

  // 🚀 INJECTION CORRIGÉE (SANS LE CHAMP DESCRIPTION QUI BUGUE)
  try {
    final response = await supabase.from('produit').select();
    if ((response as List).isEmpty) {
      await supabase.from('produit').insert({
        'titre': 'Burger Gourmet',
        'prix': 14.50,
        'image_url': 'https://images.unsplash.com/photo-1568901346375-23c9450c58cd?w=500',
        'categorie': 'Plats',
      });
      debugPrint("✅ Produit injecté avec succès !");
    }
  } catch (e) {
    debugPrint("❌ Erreur injection : $e");
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: Colors.orange), useMaterial3: true),
      home: const SplashScreen(), 
      routes: {
        '/login': (context) => const AuthScreen(),
        '/home': (context) => const MainScreen(),
      },
    );
  }
}