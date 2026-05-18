import 'package:flutter/material.dart';
import 'package:qr_craft_studio/core/theme/app_theme.dart';
import 'package:qr_craft_studio/models/qr_category.dart';

class CategoryItem extends StatelessWidget {
  final QRCategory category;
  final VoidCallback? onTap;

  const CategoryItem({
    super.key,
    required this.category,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            width: 58,
            height: 58,
            decoration: BoxDecoration(
              color: AppColors.cardBg,
              shape: BoxShape.circle,
              border: Border.all(color: AppColors.border, width: 1.2),
            ),
            child: Center(
              child: Icon(
                category.icon,
                color: Colors.white,
                size: 22,
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            category.label,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
