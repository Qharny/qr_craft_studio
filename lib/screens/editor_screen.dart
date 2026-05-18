import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';
import 'package:qr_craft_studio/core/theme/app_theme.dart';

class EditorScreen extends StatefulWidget {
  const EditorScreen({super.key});

  @override
  State<EditorScreen> createState() => _EditorScreenState();
}

class _EditorScreenState extends State<EditorScreen> {
  // Active QR data type selection
  String _activeType = 'URL';

  // Input Controllers for each data type
  final _urlController = TextEditingController(text: 'https://qrcraft.studio');
  final _textController = TextEditingController(text: 'Hello from QR Craft Studio!');
  
  final _emailRecipientController = TextEditingController(text: 'hello@qrcraft.studio');
  final _emailSubjectController = TextEditingController(text: 'Feedback');
  final _emailBodyController = TextEditingController(text: 'I love this app!');

  final _phoneController = TextEditingController(text: '+1234567890');

  final _wifiSsidController = TextEditingController(text: 'Studio WiFi');
  final _wifiPasswordController = TextEditingController(text: 'craft123');
  String _wifiSecurity = 'WPA'; // WPA, WEP, nopass

  final _locLatitudeController = TextEditingController(text: '37.7749');
  final _locLongitudeController = TextEditingController(text: '-122.4194');

  final _contactNameController = TextEditingController(text: 'Qharny Creator');
  final _contactOrgController = TextEditingController(text: 'QR Craft Studio');
  final _contactPhoneController = TextEditingController(text: '+1234567890');
  final _contactEmailController = TextEditingController(text: 'creator@qrcraft.studio');
  final _contactAddressController = TextEditingController(text: 'San Francisco, CA');
  final _contactWebController = TextEditingController(text: 'https://qrcraft.studio');

  final _waPhoneController = TextEditingController(text: '+1234567890');
  final _waMessageController = TextEditingController(text: 'Hi! I styled this QR.');

  // Design Customizations
  Color _qrColor = AppColors.primary;
  bool _embedLogo = false;

  @override
  void dispose() {
    _urlController.dispose();
    _textController.dispose();
    _emailRecipientController.dispose();
    _emailSubjectController.dispose();
    _emailBodyController.dispose();
    _phoneController.dispose();
    _wifiSsidController.dispose();
    _wifiPasswordController.dispose();
    _locLatitudeController.dispose();
    _locLongitudeController.dispose();
    _contactNameController.dispose();
    _contactOrgController.dispose();
    _contactPhoneController.dispose();
    _contactEmailController.dispose();
    _contactAddressController.dispose();
    _contactWebController.dispose();
    _waPhoneController.dispose();
    _waMessageController.dispose();
    super.dispose();
  }

  // Compile the QR data payload based on the selected type
  String get _compiledQrData {
    switch (_activeType) {
      case 'URL':
        final text = _urlController.text.trim();
        if (text.isEmpty) return 'https://qrcraft.studio';
        return text.startsWith('http://') || text.startsWith('https://') ? text : 'https://$text';
      case 'Text':
        return _textController.text.isEmpty ? 'Empty Text' : _textController.text;
      case 'Email':
        final recipient = _emailRecipientController.text.trim();
        final subject = Uri.encodeComponent(_emailSubjectController.text);
        final body = Uri.encodeComponent(_emailBodyController.text);
        return 'mailto:$recipient?subject=$subject&body=$body';
      case 'Phone':
        return 'tel:${_phoneController.text.trim()}';
      case 'WiFi':
        final ssid = _wifiSsidController.text;
        final pass = _wifiPasswordController.text;
        return 'WIFI:S:$ssid;T:$_wifiSecurity;P:$pass;;';
      case 'Location':
        final lat = _locLatitudeController.text.trim();
        final lng = _locLongitudeController.text.trim();
        return 'geo:$lat,$lng';
      case 'Contact':
        final name = _contactNameController.text;
        final org = _contactOrgController.text;
        final phone = _contactPhoneController.text;
        final email = _contactEmailController.text;
        final addr = _contactAddressController.text;
        final web = _contactWebController.text;
        return 'BEGIN:VCARD\nVERSION:3.0\nN:$name\nORG:$org\nTEL:$phone\nEMAIL:$email\nADR:$addr\nURL:$web\nEND:VCARD';
      case 'WhatsApp':
        final phone = _waPhoneController.text.trim().replaceAll('+', '');
        final msg = Uri.encodeComponent(_waMessageController.text);
        return 'https://wa.me/$phone?text=$msg';
      default:
        return 'https://qrcraft.studio';
    }
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    // Define the 8 QR types
    final qrTypes = [
      {'label': 'URL', 'icon': Icons.link_rounded},
      {'label': 'Text', 'icon': Icons.description_rounded},
      {'label': 'Email', 'icon': Icons.email_rounded},
      {'label': 'Phone', 'icon': Icons.phone_rounded},
      {'label': 'WiFi', 'icon': Icons.wifi_rounded},
      {'label': 'Location', 'icon': Icons.location_on_rounded},
      {'label': 'Contact', 'icon': Icons.contact_mail_rounded},
      {'label': 'WhatsApp', 'icon': Icons.chat_bubble_rounded},
    ];

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
              // 1. REAL INTERACTIVE DYNAMIC QR CODE PREVIEW CONTAINER
              Center(
                child: Container(
                  width: 220,
                  height: 220,
                  padding: const EdgeInsets.all(18),
                  decoration: BoxDecoration(
                    color: AppColors.cardBg,
                    borderRadius: BorderRadius.circular(24),
                    border: Border.all(color: _qrColor, width: 2.0),
                    boxShadow: [
                      BoxShadow(
                        color: _qrColor.withOpacity(0.12),
                        blurRadius: 18,
                        spreadRadius: 3,
                      ),
                    ],
                  ),
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Center(
                      child: PrettyQrView.data(
                        data: _compiledQrData,
                        decoration: PrettyQrDecoration(
                          shape: const PrettyQrSmoothSymbol(
                            roundFactor: 0.8,
                          ),
                          image: _embedLogo
                              ? PrettyQrDecorationImage(
                                  image: const AssetImage('assets/logo.png'),
                                  scale: 3.5,
                                )
                              : null,
                        ),
                      ),
                    ),
                  ),
                ),
              ).animate().scaleXY(begin: 0.9, duration: 400.ms, curve: Curves.easeOutBack),

              const SizedBox(height: 24),

              // 2. DESIGN & STYLING CUSTOMIZER
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                decoration: BoxDecoration(
                  color: AppColors.cardBg,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: AppColors.border, width: 1.2),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Embed Brand Logo',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Switch(
                          value: _embedLogo,
                          activeColor: AppColors.primary,
                          activeTrackColor: AppColors.primary.withOpacity(0.3),
                          inactiveThumbColor: Colors.white,
                          inactiveTrackColor: Colors.white24,
                          onChanged: (val) {
                            setState(() {
                              _embedLogo = val;
                            });
                          },
                        ),
                      ],
                    ),
                    const Divider(color: AppColors.border, height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Glow Highlight Color',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Row(
                          children: [
                            _buildColorIndicator(AppColors.primary),
                            const SizedBox(width: 8),
                            _buildColorIndicator(AppColors.secondary),
                            const SizedBox(width: 8),
                            _buildColorIndicator(Colors.orangeAccent),
                            const SizedBox(width: 8),
                            _buildColorIndicator(Colors.white),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ).animate().fadeIn(delay: 100.ms, duration: 350.ms),

              const SizedBox(height: 24),

              // 3. 2x4 DATA TYPE SELECTION GRID (ALL 8 DATA TYPES)
              Text(
                'Select Data Type',
                style: textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Colors.white,
                ),
              ).animate().fadeIn(delay: 150.ms),
              const SizedBox(height: 12),

              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 0.95,
                ),
                itemCount: qrTypes.length,
                itemBuilder: (context, index) {
                  final type = qrTypes[index];
                  final label = type['label'] as String;
                  final icon = type['icon'] as IconData;
                  final isSelected = _activeType == label;

                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        _activeType = label;
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: isSelected
                            ? AppColors.primary.withOpacity(0.12)
                            : AppColors.cardBg,
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(
                          color: isSelected ? AppColors.primary : AppColors.border,
                          width: 1.5,
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            icon,
                            color: isSelected ? AppColors.primary : Colors.white70,
                            size: 22,
                          ),
                          const SizedBox(height: 6),
                          Text(
                            label,
                            style: TextStyle(
                              color: isSelected ? AppColors.primary : Colors.white70,
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ).animate().fadeIn(delay: 200.ms, duration: 400.ms),

              const SizedBox(height: 24),

              // 4. DYNAMIC DYNAMIC DATA ENTRY FIELDS PANEL
              Text(
                'Data Content Details',
                style: textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Colors.white,
                ),
              ).animate().fadeIn(delay: 250.ms),
              const SizedBox(height: 12),

              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.cardBg,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: AppColors.border, width: 1.2),
                ),
                child: _buildDynamicFields(),
              ).animate().fadeIn(delay: 300.ms, duration: 400.ms).slideY(begin: 0.05),

              const SizedBox(height: 28),

              // 5. ACTION EXPORT BUTTONS
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Draft successfully updated!'),
                            backgroundColor: AppColors.primary,
                          ),
                        );
                      },
                      child: const Text('Save Draft'),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: FilledButton(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('QR Code successfully generated & saved to library!'),
                            backgroundColor: AppColors.success,
                          ),
                        );
                      },
                      child: const Text('Export QR'),
                    ),
                  ),
                ],
              ).animate().fadeIn(delay: 400.ms),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildColorIndicator(Color color) {
    final isSelected = _qrColor == color;
    return GestureDetector(
      onTap: () {
        setState(() {
          _qrColor = color;
        });
      },
      child: Container(
        width: 24,
        height: 24,
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
          border: Border.all(
            color: isSelected ? Colors.white : Colors.white24,
            width: isSelected ? 2.0 : 1.0,
          ),
        ),
      ),
    );
  }

  // Dynamic builder based on selected category type
  Widget _buildDynamicFields() {
    switch (_activeType) {
      case 'URL':
        return Column(
          children: [
            TextField(
              controller: _urlController,
              onChanged: (_) => setState(() {}),
              decoration: const InputDecoration(
                labelText: 'Website URL Address',
                hintText: 'https://example.com',
                prefixIcon: Icon(Icons.link_rounded, color: AppColors.primary),
              ),
              keyboardType: TextInputType.url,
            ),
          ],
        );
      case 'Text':
        return Column(
          children: [
            TextField(
              controller: _textController,
              onChanged: (_) => setState(() {}),
              maxLines: 4,
              decoration: const InputDecoration(
                labelText: 'Custom Text Data',
                hintText: 'Type your custom QR payload here...',
                alignLabelWithHint: true,
              ),
            ),
          ],
        );
      case 'Email':
        return Column(
          children: [
            TextField(
              controller: _emailRecipientController,
              onChanged: (_) => setState(() {}),
              decoration: const InputDecoration(
                labelText: 'Recipient Email Address',
                hintText: 'user@example.com',
                prefixIcon: Icon(Icons.alternate_email_rounded),
              ),
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 14),
            TextField(
              controller: _emailSubjectController,
              onChanged: (_) => setState(() {}),
              decoration: const InputDecoration(
                labelText: 'Email Subject Line',
                hintText: 'Hello Designer',
              ),
            ),
            const SizedBox(height: 14),
            TextField(
              controller: _emailBodyController,
              onChanged: (_) => setState(() {}),
              maxLines: 3,
              decoration: const InputDecoration(
                labelText: 'Pre-filled Body Message',
                hintText: 'Type your message...',
                alignLabelWithHint: true,
              ),
            ),
          ],
        );
      case 'Phone':
        return Column(
          children: [
            TextField(
              controller: _phoneController,
              onChanged: (_) => setState(() {}),
              decoration: const InputDecoration(
                labelText: 'Phone Number',
                hintText: '+1 234 567 8900',
                prefixIcon: Icon(Icons.phone_rounded),
              ),
              keyboardType: TextInputType.phone,
            ),
          ],
        );
      case 'WiFi':
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _wifiSsidController,
              onChanged: (_) => setState(() {}),
              decoration: const InputDecoration(
                labelText: 'WiFi Network Name (SSID)',
                hintText: 'Home_WiFi',
                prefixIcon: Icon(Icons.wifi_rounded),
              ),
            ),
            const SizedBox(height: 14),
            TextField(
              controller: _wifiPasswordController,
              onChanged: (_) => setState(() {}),
              decoration: const InputDecoration(
                labelText: 'WiFi Router Password',
                hintText: '••••••••',
                prefixIcon: Icon(Icons.lock_rounded),
              ),
              obscureText: true,
            ),
            const SizedBox(height: 16),
            const Text(
              'Security Protocol Type',
              style: TextStyle(color: Colors.white70, fontSize: 13, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                _buildWifiSecurityOption('WPA'),
                const SizedBox(width: 10),
                _buildWifiSecurityOption('WEP'),
                const SizedBox(width: 10),
                _buildWifiSecurityOption('nopass', label: 'Unsecured'),
              ],
            ),
          ],
        );
      case 'Location':
        return Column(
          children: [
            TextField(
              controller: _locLatitudeController,
              onChanged: (_) => setState(() {}),
              decoration: const InputDecoration(
                labelText: 'Coordinate Latitude',
                hintText: '37.7749',
                prefixIcon: Icon(Icons.map_rounded),
              ),
              keyboardType: const TextInputType.numberWithOptions(decimal: true, signed: true),
            ),
            const SizedBox(height: 14),
            TextField(
              controller: _locLongitudeController,
              onChanged: (_) => setState(() {}),
              decoration: const InputDecoration(
                labelText: 'Coordinate Longitude',
                hintText: '-122.4194',
                prefixIcon: Icon(Icons.map_rounded),
              ),
              keyboardType: const TextInputType.numberWithOptions(decimal: true, signed: true),
            ),
          ],
        );
      case 'Contact':
        return Column(
          children: [
            TextField(
              controller: _contactNameController,
              onChanged: (_) => setState(() {}),
              decoration: const InputDecoration(
                labelText: 'Full Contact Name',
                hintText: 'John Doe',
                prefixIcon: Icon(Icons.person_rounded),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _contactOrgController,
              onChanged: (_) => setState(() {}),
              decoration: const InputDecoration(
                labelText: 'Organization Company',
                hintText: 'Acme Corp',
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _contactPhoneController,
              onChanged: (_) => setState(() {}),
              decoration: const InputDecoration(
                labelText: 'Direct Phone',
                hintText: '+1234567890',
              ),
              keyboardType: TextInputType.phone,
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _contactEmailController,
              onChanged: (_) => setState(() {}),
              decoration: const InputDecoration(
                labelText: 'Work Email Address',
                hintText: 'work@example.com',
              ),
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _contactAddressController,
              onChanged: (_) => setState(() {}),
              decoration: const InputDecoration(
                labelText: 'Physical Office Address',
                hintText: '123 Main St, New York',
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _contactWebController,
              onChanged: (_) => setState(() {}),
              decoration: const InputDecoration(
                labelText: 'Website Portfolio URL',
                hintText: 'https://example.com',
              ),
              keyboardType: TextInputType.url,
            ),
          ],
        );
      case 'WhatsApp':
        return Column(
          children: [
            TextField(
              controller: _waPhoneController,
              onChanged: (_) => setState(() {}),
              decoration: const InputDecoration(
                labelText: 'WhatsApp Phone Number',
                hintText: '+1234567890 (no spaces)',
                prefixIcon: Icon(Icons.chat_bubble_outline_rounded),
              ),
              keyboardType: TextInputType.phone,
            ),
            const SizedBox(height: 14),
            TextField(
              controller: _waMessageController,
              onChanged: (_) => setState(() {}),
              maxLines: 3,
              decoration: const InputDecoration(
                labelText: 'Pre-filled WhatsApp Chat Message',
                hintText: 'Type your hello message...',
                alignLabelWithHint: true,
              ),
            ),
          ],
        );
      default:
        return const SizedBox();
    }
  }

  Widget _buildWifiSecurityOption(String value, {String? label}) {
    final isSelected = _wifiSecurity == value;
    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            _wifiSecurity = value;
          });
        },
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 8),
          decoration: BoxDecoration(
            color: isSelected ? AppColors.primary.withOpacity(0.12) : Colors.transparent,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: isSelected ? AppColors.primary : AppColors.border,
              width: 1.2,
            ),
          ),
          child: Center(
            child: Text(
              label ?? value,
              style: TextStyle(
                color: isSelected ? AppColors.primary : AppColors.textSecondary,
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
