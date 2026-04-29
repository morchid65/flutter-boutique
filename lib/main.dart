import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:provider/provider.dart'; // 1. On importe le package Provider
import 'providers/cart_provider.dart'; // 2. Ton nouveau "cerveau" automatique
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

  // Sync des favoris si déjà connecté
  if (supabase.auth.currentSession != null) {
    await FavoriteService.fetchFavorites();
  }

  // 3. On entoure l'app avec MultiProvider pour centraliser l'IA
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CartProvider()),
        // On pourra ajouter FavoriteProvider plus tard ici sans tout casser !
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.orange),
        useMaterial3: true
      ),
      home: const SplashScreen(), 
      routes: {
        '/login': (context) => const AuthScreen(),
        '/home': (context) => const MainScreen(),
      },
    );
  }
}