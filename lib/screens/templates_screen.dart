import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:qr_craft_studio/core/theme/app_theme.dart';

class TemplatesScreen extends StatelessWidget {
  const TemplatesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    final categories = [
      {'name': 'All', 'active': true},
      {'name': 'Business', 'active': false},
      {'name': 'Events', 'active': false},
      {'name': 'Hospitality', 'active': false},
      {'name': 'Utility', 'active': false},
      {'name': 'Social', 'active': false},
    ];

    final templates = [
      {
        'title': 'Modern Restaurant Menu',
        'desc': 'Dynamic pricing & photo integration',
        'category': 'HOSPITALITY',
        'imageUrl': 'https://images.unsplash.com/photo-1504674900247-0877df9cc836?auto=format&fit=crop&w=600&q=80',
        'actionIcon': Icons.arrow_forward_rounded,
        'isAccentAction': true,
      },
      {
        'title': 'Premium Event Pass',
        'desc': 'Secure entry with time-based codes',
        'category': 'EVENTS',
        'imageUrl': 'https://images.unsplash.com/photo-1492684223066-81342ee5ff30?auto=format&fit=crop&w=600&q=80',
        'actionIcon': Icons.add_rounded,
        'isAccentAction': false,
      },
      {
        'title': 'Executive V-Card',
        'desc': 'One-tap contact card networking',
        'category': 'BUSINESS',
        'imageUrl': 'https://images.unsplash.com/photo-1507679799987-c73779587ccf?auto=format&fit=crop&w=600&q=80',
        'actionIcon': Icons.chevron_right_rounded,
        'isAccentAction': false,
      },
      {
        'title': 'Seamless WiFi Connector',
        'desc': 'Instant join with network encryption',
        'category': 'UTILITY',
        'imageUrl': 'https://images.unsplash.com/photo-1497366216548-37526070297c?auto=format&fit=crop&w=600&q=80',
        'actionIcon': Icons.bolt_rounded,
        'isAccentAction': false,
      },
      {
        'title': 'Social Link Hub',
        'desc': 'Unified presence for all platforms',
        'category': 'SOCIAL',
        'imageUrl': 'https://images.unsplash.com/photo-1618005182384-a83a8bd57fbe?auto=format&fit=crop&w=600&q=80',
        'actionIcon': Icons.add_rounded,
        'isAccentAction': false,
      },
    ];

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Top Bar matching the image (logo left, bell & profile right)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 36,
                        height: 36,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: const LinearGradient(
                            colors: [AppColors.secondary, AppColors.primary],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                        ),
                        child: const Center(
                          child: Icon(
                            Icons.qr_code_2_rounded,
                            color: Colors.white,
                            size: 20,
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
                  Row(
                    children: [
                      IconButton(
                        icon: const Icon(
                          Icons.notifications_none_rounded,
                          color: Colors.white,
                          size: 22,
                        ),
                        onPressed: () {},
                      ),
                      const SizedBox(width: 8),
                      Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: AppColors.primary, width: 1.5),
                        ),
                        child: const CircleAvatar(
                          radius: 16,
                          backgroundImage: NetworkImage(
                            'https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?auto=format&fit=crop&w=120&q=80',
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const Divider(color: AppColors.border, height: 1, thickness: 1.0),

            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Search Bar
                    Container(
                      height: 52,
                      decoration: BoxDecoration(
                        color: AppColors.cardBg,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: AppColors.border, width: 1.2),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.search_rounded,
                            color: AppColors.textSecondary,
                            size: 20,
                          ),
                          const SizedBox(width: 12),
                          const Expanded(
                            child: TextField(
                              decoration: InputDecoration(
                                hintText: 'Search premium templates...',
                                hintStyle: TextStyle(
                                  color: AppColors.textSecondary,
                                  fontSize: 14,
                                ),
                                border: InputBorder.none,
                                enabledBorder: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                contentPadding: EdgeInsets.zero,
                              ),
                              style: TextStyle(color: Colors.white, fontSize: 14),
                            ),
                          ),
                          IconButton(
                            icon: const Icon(
                              Icons.tune_rounded,
                              color: AppColors.textSecondary,
                              size: 20,
                            ),
                            onPressed: () {},
                          ),
                        ],
                      ),
                    ).animate().fadeIn(duration: 350.ms).slideY(begin: -0.05),
                    const SizedBox(height: 18),

                    // Categories Selector Row
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: categories.map((cat) {
                          final active = cat['active'] as bool;
                          return Container(
                            margin: const EdgeInsets.only(right: 12),
                            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                            decoration: BoxDecoration(
                              gradient: active
                                  ? const LinearGradient(
                                      colors: [AppColors.primary, Color(0xFF0077FF)],
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                    )
                                  : null,
                              color: active ? null : AppColors.cardBg,
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: active ? Colors.transparent : AppColors.border,
                                width: 1.2,
                              ),
                            ),
                            child: Text(
                              cat['name'] as String,
                              style: textTheme.bodyMedium?.copyWith(
                                color: active ? Colors.white : AppColors.textSecondary,
                                fontWeight: FontWeight.bold,
                                fontSize: 13,
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ).animate().fadeIn(delay: 100.ms, duration: 350.ms),

                    const SizedBox(height: 24),

                    // Templates List matching layout of screen mockup
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: templates.length,
                      itemBuilder: (context, index) {
                        final t = templates[index];
                        final isAccent = t['isAccentAction'] as bool;

                        return Container(
                          margin: const EdgeInsets.only(bottom: 20),
                          decoration: BoxDecoration(
                            color: AppColors.cardBg,
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(color: AppColors.border, width: 1.2),
                          ),
                          child: Column(
                            children: [
                              // Top graphic cover with category capsule tag
                              Container(
                                height: 160,
                                decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
                                  image: DecorationImage(
                                    image: NetworkImage(t['imageUrl'] as String),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                child: Stack(
                                  children: [
                                    Positioned(
                                      top: 14,
                                      right: 14,
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                                        decoration: BoxDecoration(
                                          color: Colors.black.withOpacity(0.65),
                                          borderRadius: BorderRadius.circular(20),
                                          border: Border.all(
                                            color: Colors.white.withOpacity(0.15),
                                            width: 1,
                                          ),
                                        ),
                                        child: Text(
                                          t['category'] as String,
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 9,
                                            letterSpacing: 0.8,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              // Bottom info block with dynamic icon button
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            t['title'] as String,
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          const SizedBox(height: 6),
                                          Text(
                                            t['desc'] as String,
                                            style: const TextStyle(
                                              color: AppColors.textSecondary,
                                              fontSize: 12,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(width: 12),
                                    // Custom round icon button
                                    Container(
                                      width: 40,
                                      height: 40,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        gradient: isAccent
                                            ? const LinearGradient(
                                                colors: [AppColors.primary, Color(0xFF0077FF)],
                                                begin: Alignment.topLeft,
                                                end: Alignment.bottomRight,
                                              )
                                            : null,
                                        color: isAccent ? null : const Color(0xFF0F172A),
                                        border: isAccent
                                            ? null
                                            : Border.all(
                                                color: AppColors.border,
                                                width: 1.2,
                                              ),
                                      ),
                                      child: Center(
                                        child: Icon(
                                          t['actionIcon'] as IconData,
                                          color: isAccent ? Colors.black : AppColors.textSecondary,
                                          size: 18,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ).animate().fadeIn(delay: (index * 80).ms, duration: 400.ms).slideY(begin: 0.05);
                      },
                    ),
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
