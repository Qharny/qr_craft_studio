import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:qr_craft_studio/core/services/storage_service.dart';
import 'package:qr_craft_studio/core/theme/app_theme.dart';
import 'package:qr_craft_studio/models/qr_category.dart';
import 'package:qr_craft_studio/models/qr_project.dart';
import 'package:qr_craft_studio/screens/main_screen.dart';
import 'package:qr_craft_studio/widgets/category_item.dart';
import 'package:qr_craft_studio/widgets/recent_qr_item.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  static const List<QRCategory> _categories = [
    QRCategory(label: 'Link', icon: Icons.link_rounded),
    QRCategory(label: 'WiFi', icon: Icons.wifi_rounded),
    QRCategory(label: 'vCard', icon: Icons.badge_rounded),
    QRCategory(label: 'WhatsApp', icon: Icons.chat_bubble_outline_rounded),
  ];

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final List<QRProject> projects = StorageService.getProjects();

    return Scaffold(
      floatingActionButton: Container(
        height: 56,
        width: 56,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: const LinearGradient(
            colors: [AppColors.secondary, AppColors.primary],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          boxShadow: [
            BoxShadow(
              color: AppColors.secondary.withOpacity(0.35),
              blurRadius: 14,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: RawMaterialButton(
          shape: const CircleBorder(),
          onPressed: () {
            MainScreen.switchToTab(context, 1);
          },
          child: const Icon(
            Icons.add_rounded,
            color: Colors.white,
            size: 30,
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Top Bar matching the image
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: AppColors.primary, width: 1.5),
                        ),
                        child: const CircleAvatar(
                          radius: 18,
                          backgroundImage: NetworkImage(
                            'https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?auto=format&fit=crop&w=120&q=80',
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: 'QR ',
                              style: textTheme.titleLarge?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontSize: 18,
                              ),
                            ),
                            TextSpan(
                              text: 'CRAFT',
                              style: textTheme.titleLarge?.copyWith(
                                fontWeight: FontWeight.w900,
                                color: AppColors.primary,
                                fontSize: 18,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.notifications_none_rounded,
                      color: Colors.white,
                      size: 22,
                    ),
                    onPressed: () {},
                  ),
                ],
              ),
            ),
            const Divider(color: AppColors.border, height: 1, thickness: 1.0),

            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Hello, Creator! greeting
                    Text(
                      'Hello, Creator!',
                      style: textTheme.displayMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: 26,
                        color: Colors.white,
                      ),
                    ).animate().fadeIn(duration: 350.ms).slideX(begin: -0.1),
                    const SizedBox(height: 4),
                    Text(
                      'Ready to craft your next digital gateway?',
                      style: textTheme.bodyMedium?.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ).animate().fadeIn(delay: 100.ms, duration: 350.ms),
                    const SizedBox(height: 24),

                    // Quick Generate gradient card banner
                    GestureDetector(
                      onTap: () => MainScreen.switchToTab(context, 1),
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 26),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          gradient: const LinearGradient(
                            colors: [
                              Color(0xFF5B21B6), // Deep rich violet purple
                              Color(0xFF0284C7), // Vibrant cyan blue
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.2),
                              blurRadius: 10,
                              offset: const Offset(0, 4),
                            )
                          ],
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Quick Generate',
                                    style: textTheme.headlineMedium?.copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                      fontSize: 20,
                                    ),
                                  ),
                                  const SizedBox(height: 6),
                                  Text(
                                    'Create a QR in seconds',
                                    style: textTheme.bodyMedium?.copyWith(
                                      color: Colors.white.withOpacity(0.85),
                                      fontSize: 13,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const Icon(
                              Icons.bolt_rounded,
                              color: Colors.white,
                              size: 38,
                            ).animate().shimmer(duration: 2.seconds, delay: 500.ms),
                          ],
                        ),
                      ),
                    ).animate().fadeIn(delay: 200.ms, duration: 400.ms).scaleXY(begin: 0.97),
                    const SizedBox(height: 28),

                    // Recent QR Codes Header
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Recent QR Codes',
                          style: textTheme.headlineSmall?.copyWith(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: Colors.white,
                          ),
                        ),
                        TextButton(
                          onPressed: () {},
                          child: const Text(
                            'View All',
                            style: TextStyle(color: AppColors.textSecondary, fontSize: 13),
                          ),
                        ),
                      ],
                    ).animate().fadeIn(delay: 300.ms),
                    const SizedBox(height: 12),

                    // Horizontal list of recent codes matching design
                    SizedBox(
                      height: 145,
                      child: projects.isEmpty
                          ? Center(
                              child: Text(
                                'No custom QRs yet. Go to Editor to craft one!',
                                style: textTheme.bodyMedium?.copyWith(
                                  color: AppColors.textSecondary,
                                ),
                              ),
                            )
                          : ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: projects.length,
                              itemBuilder: (context, index) {
                                return RecentQRItem(project: projects[index]);
                              },
                            ),
                    ).animate().fadeIn(delay: 350.ms, duration: 450.ms).slideX(begin: 0.05),
                    const SizedBox(height: 28),

                    // Categories Header
                    Text(
                      'Categories',
                      style: textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Colors.white,
                      ),
                    ).animate().fadeIn(delay: 400.ms),
                    const SizedBox(height: 16),

                    // Row of circular category buttons
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: _categories.map((cat) {
                        return CategoryItem(
                          category: cat,
                          onTap: () => MainScreen.switchToTab(context, 1),
                        );
                      }).toList(),
                    ).animate().fadeIn(delay: 450.ms, duration: 450.ms).slideY(begin: 0.05),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
