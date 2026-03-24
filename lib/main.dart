import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'screens/splash_screen.dart'; 

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // On charge le fichier
  await dotenv.load(fileName: ".env");

  // On vérifie que les noms correspondent EXACTEMENT à ton fichier .env
  await Supabase.initialize(
    url: dotenv.env['SUPABASE_URL']!,
    anonKey: dotenv.env['SUPABASE_ANON_KEY']!, // Vérifie si c'est KEY ou ANON_KEY dans ton .env
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // Correction : PAS DE "const" ici car SplashScreen est dynamique
      home: SplashScreen(), 
      routes: {
        '/home': (context) => const Scaffold(body: Center(child: Text("Home"))),
      },
    );
  }
}