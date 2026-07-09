import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'core/constants/app_theme.dart';
import 'providers/app_provider.dart';
import 'providers/ai_provider.dart';
import 'screens/home/home_screen.dart';
import 'data/seed_motors.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) {
          final provider = AppProvider();
          provider.selectMotor(SeedMotors.popularMotors[0], 12000.0);
          return provider;
        }),
        ChangeNotifierProvider(create: (_) => AiProvider()),
      ],
      child: const OprekIdApp(),
    ),
  );
}

class OprekIdApp extends StatelessWidget {
  const OprekIdApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Oprek.ID',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkTheme,
      home: const HomeScreen(),
    );
  }
}


