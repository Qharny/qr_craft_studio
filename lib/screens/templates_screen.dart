import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:qr_craft_studio/core/theme/app_theme.dart';

class TemplatesScreen extends StatelessWidget {
  const TemplatesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    final categories = [
      {'name': 'All Presets', 'active': true},
      {'name': 'Restaurant', 'active': false},
      {'name': 'WiFi sharing', 'active': false},
      {'name': 'Business', 'active': false},
    ];

    final templates = [
      {
        'title': 'Minimal Glass Menu',
        'desc': 'Perfect for premium bars and diners',
        'gradient': [const Color(0xFF00D2FF), const Color(0xFF0055FF)]
      },
      {
        'title': 'Vibrant Social Tree',
        'desc': 'For Linktree, Instagram, & TikTok profiles',
        'gradient': [const Color(0xFF9333EA), const Color(0xFFC084FC)]
      },
      {
        'title': 'Secure Instant WiFi',
        'desc': 'One-tap router credentials connection',
        'gradient': [const Color(0xFF10B981), const Color(0xFF059669)]
      },
      {
        'title': 'Sleek Corporate vCard',
        'desc': 'Elegantly styled contact detail exchange',
        'gradient': [const Color(0xFFF59E0B), const Color(0xFFD97706)]
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Design Templates'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: false,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Prebuilt QR Styles',
                style: textTheme.bodyMedium?.copyWith(color: AppColors.textSecondary),
              ),
              const SizedBox(height: 18),

              // Categories Selector Row
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: categories.map((cat) {
                    final active = cat['active'] as bool;
                    return Container(
                      margin: const EdgeInsets.only(right: 12),
                      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
                      decoration: BoxDecoration(
                        color: active ? AppColors.primary : AppColors.cardBg,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: active ? AppColors.primary : AppColors.border,
                          width: 1,
                        ),
                      ),
                      child: Text(
                        cat['name'] as String,
                        style: textTheme.bodyMedium?.copyWith(
                          color: active ? Colors.black : AppColors.textSecondary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ).animate().fadeIn(duration: 350.ms),

              const SizedBox(height: 28),

              // Templates List
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: templates.length,
                itemBuilder: (context, index) {
                  final t = templates[index];
                  final gradientColors = t['gradient'] as List<Color>;

                  return Container(
                    margin: const EdgeInsets.only(bottom: 16),
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: AppColors.cardBg,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: AppColors.border, width: 1.2),
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 64,
                          height: 64,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: gradientColors,
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Icon(
                            Icons.qr_code_2_rounded,
                            color: Colors.white,
                            size: 38,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                t['title'] as String,
                                style: textTheme.titleMedium?.copyWith(
                                  color: AppColors.textPrimary,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                t['desc'] as String,
                                style: textTheme.bodySmall,
                              ),
                            ],
                          ),
                        ),
                        const Icon(
                          Icons.arrow_forward_ios_rounded,
                          color: AppColors.textSecondary,
                          size: 16,
                        ),
                      ],
                    ),
                  ).animate().fadeIn(delay: (index * 100).ms, duration: 400.ms).slideY(begin: 0.05);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
