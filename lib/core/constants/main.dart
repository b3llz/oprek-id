import 'package:flutter/material.dart';
import 'core/constants/app_theme.dart';

void main() {
  // Inisialisasi awal sebelum aplikasi jalan
  WidgetsFlutterBinding.ensureInitialized();
  
  runApp(const OprekIdApp());
}

class OprekIdApp extends StatelessWidget {
  const OprekIdApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Oprek.ID',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkTheme, // Memanggil bengkel tema kita
      home: Scaffold(
        body: Center(
          child: Text(
            'Bengkel Oprek.ID Buka!',
            style: Theme.of(context).textTheme.displayLarge?.copyWith(
              fontSize: 24,
              color: Theme.of(context).primaryColor,
            ),
          ),
        ),
      ),
    );
  }
}

