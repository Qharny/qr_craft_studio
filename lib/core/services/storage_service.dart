import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:qr_craft_studio/models/qr_project.dart';

class StorageService {
  static const String _projectsKey = 'qr_craft_projects';
  static SharedPreferences? _prefs;

  // Initialize SharedPreferences instance
  static Future<void> init() async {
    _prefs ??= await SharedPreferences.getInstance();
  }

  // Retrieve all QR projects from local storage
  static List<QRProject> getProjects() {
    if (_prefs == null) return [];
    
    final jsonString = _prefs!.getString(_projectsKey);
    if (jsonString == null || jsonString.isEmpty) {
      return _loadDefaultDummyProjects(); // Seed initial beautiful projects if empty!
    }

    try {
      final List<dynamic> jsonList = jsonDecode(jsonString) as List<dynamic>;
      return jsonList.map((item) => QRProject.fromJson(item as Map<String, dynamic>)).toList()
        ..sort((a, b) => b.createdAt.compareTo(a.createdAt)); // Sort newest first
    } catch (e) {
      // If parsing fails, reset to seeded defaults to avoid visual lockups
      return _loadDefaultDummyProjects();
    }
  }

  // Save a QR project (creates new or overrides existing by ID)
  static Future<void> saveProject(QRProject project) async {
    if (_prefs == null) await init();

    final projects = getProjects();
    final index = projects.indexWhere((p) => p.id == project.id);

    if (index >= 0) {
      projects[index] = project; // Edit/Update
    } else {
      projects.insert(0, project); // Create new at top
    }

    final jsonList = projects.map((p) => p.toJson()).toList();
    await _prefs!.setString(_projectsKey, jsonEncode(jsonList));
  }

  // Delete a specific project by ID
  static Future<void> deleteProject(String projectId) async {
    if (_prefs == null) await init();

    final projects = getProjects();
    projects.removeWhere((p) => p.id == projectId);

    final jsonList = projects.map((p) => p.toJson()).toList();
    await _prefs!.setString(_projectsKey, jsonEncode(jsonList));
  }

  // Load standard pre-populated gorgeous dummy projects for the first app launch
  static List<QRProject> _loadDefaultDummyProjects() {
    return [
      QRProject(
        id: 'dummy_1',
        label: 'Portfolio Hub',
        type: 'URL',
        data: 'https://qrcraft.studio/portfolio',
        qrColorValue: 0xFF00D2FF, // Primary Cyan
        createdAt: DateTime.now().subtract(const Duration(hours: 2)).toIso8601String(),
      ),
      QRProject(
        id: 'dummy_2',
        label: 'Coffee Menu',
        type: 'URL',
        data: 'https://qrcraft.studio/menu',
        qrColorValue: 0xFF9333EA, // Secondary Purple
        createdAt: DateTime.now().subtract(const Duration(hours: 5)).toIso8601String(),
      ),
      QRProject(
        id: 'dummy_3',
        label: 'Guest WiFi',
        type: 'WiFi',
        data: 'WIFI:S:Guest_WiFi;T:WPA;P:guest123;;',
        qrColorValue: 0xFF10B981, // Emerald Green
        createdAt: DateTime.now().subtract(const Duration(days: 1)).toIso8601String(),
      ),
    ];
  }
}
