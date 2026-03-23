import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'screens/splash_screen.dart'; 

// Correction : BIEN ECRIRE "Future" avec un "e"
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");

  await Supabase.initialize(
    // Correction : Ajout du "!" pour le type String
    url: dotenv.env['SUPABASE_URL']!,
    anonKey: dotenv.env['SUPABASE_KEY']!,
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