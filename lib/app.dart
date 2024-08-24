import 'package:flutter/material.dart';
import 'package:movie_catalog/themes/app_colors.dart';
import 'package:movie_catalog/pages/home_page/home_page.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Movie Catalog',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.darkJet,
        ),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}
