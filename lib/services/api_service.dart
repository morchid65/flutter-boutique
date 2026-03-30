import 'package:flutter/material.dart';
import '../models/product.dart';

class ApiService {
  Future<List<Product>> getProducts() async {
    // 🧪 Simulation de délai réseau
    await Future.delayed(const Duration(milliseconds: 500));
    
    return [
      Product(
        id: 1,
        title: "Burger Gourmet",
        price: 14.50,
        imageUrl: "https://images.unsplash.com/photo-1568901346375-23c9450c58cd?w=500",
      ),
      Product(
        id: 2,
        title: "Frites Maison",
        price: 4.00,
        imageUrl: "https://images.unsplash.com/photo-1573016608244-7d5f8540ed18?w=500",
      ),
    ];
  }
}