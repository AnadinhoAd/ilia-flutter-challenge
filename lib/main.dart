import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:movie_catalog/app.dart';
import 'package:movie_catalog/di/injector.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  initLocator();
  runApp(const MyApp());
}
