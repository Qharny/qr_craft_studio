import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:qr_craft_studio/core/theme/app_theme.dart';

class AnalyticsScreen extends StatelessWidget {
  const AnalyticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Dynamic Analytics'),
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
                'Monitor QR Code Scans',
                style: textTheme.bodyMedium?.copyWith(color: AppColors.textSecondary),
              ),
              const SizedBox(height: 24),

              // Total Scans Card Row
              Row(
                children: [
                  Expanded(
                    child: _buildMetricCard('Total Scans', '12.4k', '+8%', AppColors.primary),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: _buildMetricCard('Active QRs', '12 codes', '+2 new', AppColors.secondary),
                  ),
                ],
              ).animate().fadeIn(duration: 400.ms),

              const SizedBox(height: 24),

              // Visual Graph placeholder
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: AppColors.cardBg,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: AppColors.border, width: 1.2),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Daily Scan Activity',
                      style: textTheme.titleMedium?.copyWith(
                        color: AppColors.textPrimary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 20),
                    // Beautiful custom bar chart mockup
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        _buildChartBar(30, 'Mon'),
                        _buildChartBar(55, 'Tue'),
                        _buildChartBar(85, 'Wed', isActive: true),
                        _buildChartBar(40, 'Thu'),
                        _buildChartBar(60, 'Fri'),
                        _buildChartBar(95, 'Sat', isActive: true),
                        _buildChartBar(20, 'Sun'),
                      ],
                    ),
                  ],
                ),
              ).animate().fadeIn(delay: 200.ms).scaleXY(begin: 0.97),

              const SizedBox(height: 28),

              // Recent Scans list
              Text(
                'Recent Activity Logs',
                style: textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
              ).animate().fadeIn(delay: 350.ms),

              const SizedBox(height: 16),

              Column(
                children: [
                  _buildLogTile('iOS iPhone 15', 'United States', '2 mins ago'),
                  _buildLogTile('Android Pixel 8', 'United Kingdom', '15 mins ago'),
                  _buildLogTile('iOS iPad Air', 'Canada', '1 hour ago'),
                ],
              ).animate().fadeIn(delay: 450.ms).slideY(begin: 0.08),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMetricCard(String label, String value, String change, Color accentColor) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: AppColors.cardBg,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border, width: 1.2),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(color: AppColors.textSecondary, fontSize: 13)),
          const SizedBox(height: 10),
          Text(
            value,
            style: const TextStyle(color: AppColors.textPrimary, fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 6),
          Text(
            change,
            style: TextStyle(color: accentColor, fontWeight: FontWeight.bold, fontSize: 12),
          ),
        ],
      ),
    );
  }

  Widget _buildChartBar(double heightPercentage, String label, {bool isActive = false}) {
    return Column(
      children: [
        Container(
          width: 14,
          height: 110 * (heightPercentage / 100),
          decoration: BoxDecoration(
            color: isActive ? AppColors.primary : AppColors.textSecondary.withOpacity(0.3),
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        const SizedBox(height: 8),
        Text(label, style: const TextStyle(fontSize: 11, color: AppColors.textSecondary)),
      ],
    );
  }

  Widget _buildLogTile(String device, String country, String time) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        leading: const CircleAvatar(
          backgroundColor: Color(0x11FFFFFF),
          child: Icon(Icons.qr_code_scanner_rounded, color: AppColors.primary, size: 18),
        ),
        title: Text(device, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
        subtitle: Text(country, style: const TextStyle(fontSize: 12)),
        trailing: Text(time, style: const TextStyle(fontSize: 11, color: AppColors.textSecondary)),
      ),
    );
  }
}
