import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Appbar(title: const Text ("Mon Restaurant")),
      body: const Center(child: Text("Bienvenue en salle !")),
    );
  }
}