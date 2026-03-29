import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'screens/splash_screen.dart'; 
import 'screens/main_screen.dart'; // ✅ AJOUTE CET IMPORT

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  await dotenv.load(fileName: ".env");

  await Supabase.initialize(
    url: dotenv.env['SUPABASE_URL']!,
    anonKey: dotenv.env['SUPABASE_ANON_KEY']!, 
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // Le SplashScreen s'affiche en premier, puis il fera le push vers '/home'
      home: SplashScreen(), 
      routes: {
        // ✅ ON CHANGE ICI : On envoie vers le vrai MainScreen
        '/home': (context) => const MainScreen(), 
      },
    );
  }
}