import 'package:flutter/material.dart';
import 'package:news_hub/view/category/category_screen.dart';
import 'package:news_hub/view/splash_screen/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'News Hub',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: const SplashScreen(),
      routes: {'category-screen': (context) => const CategoryScreen()},
    );
  }
}
