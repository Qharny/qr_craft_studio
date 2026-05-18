import 'package:flutter/material.dart';
import 'package:qr_craft_studio/core/theme/app_theme.dart';
import 'package:qr_craft_studio/screens/splash_screen.dart';

void main() {
  runApp(const QRCraftStudioApp());
}

class QRCraftStudioApp extends StatelessWidget {
  const QRCraftStudioApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'QR Craft Studio',
      theme: AppTheme.darkTheme,
      themeMode: ThemeMode.dark,
      debugShowCheckedModeBanner: false,
      home: const SplashScreen(),
    );
  }
}
