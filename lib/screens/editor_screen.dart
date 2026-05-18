import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:qr_craft_studio/core/theme/app_theme.dart';

class EditorScreen extends StatefulWidget {
  const EditorScreen({super.key});

  @override
  State<EditorScreen> createState() => _EditorScreenState();
}

class _EditorScreenState extends State<EditorScreen> {
  String _qrType = 'Website URL';

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('QR Studio Editor'),
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
              // Interactive QR Preview Container
              Center(
                child: Container(
                  width: 210,
                  height: 210,
                  padding: const EdgeInsets.all(18),
                  decoration: BoxDecoration(
                    color: AppColors.cardBg,
                    borderRadius: BorderRadius.circular(24),
                    border: Border.all(color: AppColors.primary, width: 1.8),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.primary.withOpacity(0.08),
                        blurRadius: 16,
                        spreadRadius: 2,
                      ),
                    ],
                  ),
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: const Icon(
                      Icons.qr_code_2_rounded,
                      size: 130,
                      color: Colors.black,
                    ),
                  ),
                ),
              ).animate().scaleXY(begin: 0.9, duration: 400.ms, curve: Curves.easeOutBack),

              const SizedBox(height: 28),

              // Customizer Controls
              Text(
                'Customize Layout',
                style: textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
              ).animate().fadeIn(delay: 150.ms),

              const SizedBox(height: 16),

              // Dropdown QR Selector
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: AppColors.cardBg,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: AppColors.border),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: _qrType,
                    dropdownColor: AppColors.cardBg,
                    isExpanded: true,
                    icon: const Icon(Icons.arrow_drop_down, color: AppColors.primary),
                    items: <String>['Website URL', 'Plain Text', 'WiFi Network', 'Business Card']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(
                          value,
                          style: textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w600),
                        ),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      if (newValue != null) {
                        setState(() {
                          _qrType = newValue;
                        });
                      }
                    },
                  ),
                ),
              ).animate().fadeIn(delay: 200.ms),

              const SizedBox(height: 16),

              // Input Configuration
              TextField(
                decoration: InputDecoration(
                  labelText: _qrType == 'Website URL' ? 'Website Address' : 'Enter data content',
                  hintText: _qrType == 'Website URL' ? 'https://example.com' : 'Your text here...',
                ),
              ).animate().fadeIn(delay: 250.ms),

              const SizedBox(height: 24),

              // Settings Tiles List
              Column(
                children: [
                  _buildSettingTile(
                    icon: Icons.palette_outlined,
                    title: 'Gradient Foreground',
                    subtitle: 'Cyan to Indigo active',
                    color: AppColors.primary,
                  ),
                  _buildSettingTile(
                    icon: Icons.logo_dev_rounded,
                    title: 'Branding Logo Overlay',
                    subtitle: 'Qharny Studio default logo',
                    color: AppColors.secondary,
                  ),
                  _buildSettingTile(
                    icon: Icons.rounded_corner_rounded,
                    title: 'Eye Corner Shapes',
                    subtitle: 'Custom rounded framing eyes',
                    color: Colors.pink,
                  ),
                ],
              ).animate().fadeIn(delay: 350.ms).slideY(begin: 0.08),

              const SizedBox(height: 28),

              // Action Buttons Row
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {},
                      child: const Text('Save Draft'),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: FilledButton(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('QR successfully generated and exported!'),
                            backgroundColor: AppColors.success,
                          ),
                        );
                      },
                      child: const Text('Export QR'),
                    ),
                  ),
                ],
              ).animate().fadeIn(delay: 450.ms),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSettingTile({
    required IconData icon,
    required String title,
    required String subtitle,
    required Color color,
  }) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: color.withOpacity(0.12),
          child: Icon(icon, color: color, size: 20),
        ),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
        subtitle: Text(subtitle, style: const TextStyle(fontSize: 12)),
        trailing: const Icon(Icons.arrow_forward_ios_rounded, size: 12),
      ),
    );
  }
}
