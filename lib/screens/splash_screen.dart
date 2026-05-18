import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:lottie/lottie.dart';
import 'package:qr_craft_studio/core/theme/app_theme.dart';
import 'package:qr_craft_studio/core/utils/custom_route_transition.dart';
import 'package:qr_craft_studio/screens/main_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Lottie Animation Container loaded from user asset
            SizedBox(
              width: 240,
              height: 240,
              child: Lottie.asset(
                'assets/code.json',
                controller: _controller,
                onLoaded: (composition) {
                  _controller
                    ..duration = composition.duration
                    ..forward().then((_) {
                      // Smooth transition once animation finishes playing
                      Navigator.pushReplacement(
                        context,
                        PremiumPageRoute(
                          page: const MainScreen(),
                          transitionType: TransitionType.fade,
                          duration: const Duration(milliseconds: 650),
                        ),
                      );
                    });
                },
              ),
            ),
            const SizedBox(height: 20),
            // Premium Brand Typography & Micro-animations
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: 'QR ',
                    style: textTheme.displayMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 30,
                    ),
                  ),
                  TextSpan(
                    text: 'CRAFT',
                    style: textTheme.displayMedium?.copyWith(
                      fontWeight: FontWeight.w900,
                      color: AppColors.primary,
                      fontSize: 30,
                    ),
                  ),
                ],
              ),
            ).animate().fadeIn(delay: 350.ms, duration: 450.ms).slideY(begin: 0.15),
            const SizedBox(height: 8),
            Text(
              'Crafting your digital gateway...',
              style: textTheme.bodyMedium?.copyWith(
                color: AppColors.textSecondary,
                letterSpacing: 0.6,
                fontSize: 14,
              ),
            ).animate().fadeIn(delay: 650.ms, duration: 450.ms),
          ],
        ),
      ),
    );
  }
}
