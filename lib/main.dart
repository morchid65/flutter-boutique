import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'screens/splash_screen.dart'; 
import 'screens/main_screen.dart';
import 'services/favorite_service.dart'; // ✅ N'oublie pas l'import du service !

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // 1. On charge les variables d'environnement (.env)
  await dotenv.load(fileName: ".env");

  // 2. On initialise la connexion Supabase
  await Supabase.initialize(
    url: dotenv.env['SUPABASE_URL']!,
    anonKey: dotenv.env['SUPABASE_ANON_KEY']!, 
  );

  // 3. On pré-charge les favoris de l'utilisateur (optionnel mais recommandé)
  // On ne bloque pas forcément le démarrage si l'utilisateur n'est pas connecté
  try {
    await FavoriteService.fetchFavorites();
  } catch (e) {
    print("Erreur chargement favoris au démarrage : $e");
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'EatSmart',
      theme: ThemeData(
        primarySwatch: Colors.orange,
        useMaterial3: true,
      ),
      // Le SplashScreen s'occupe de l'aiguillage (Onboarding -> Auth -> Home)
      home: const SplashScreen(), 
      routes: {
        '/home': (context) => const MainScreen(), 
      },
    );
  }
}