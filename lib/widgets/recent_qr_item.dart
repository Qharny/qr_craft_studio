import 'package:flutter/material.dart';
import 'package:qr_craft_studio/core/theme/app_theme.dart';
import 'package:qr_craft_studio/models/qr_project.dart';

class RecentQRItem extends StatelessWidget {
  final QRProject project;

  const RecentQRItem({
    super.key,
    required this.project,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 16),
      width: 110,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.cardBg,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border, width: 1.2),
      ),
      child: Column(
        children: [
          Expanded(
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: const Color(0xFF0F172A), // Inside card dark background
                borderRadius: BorderRadius.circular(12),
              ),
              child: Center(
                child: Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: project.qrColor.withOpacity(0.3), width: 1),
                  ),
                  child: Icon(
                    Icons.qr_code_2_rounded,
                    color: project.qrColor,
                    size: 42,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            project.label,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
