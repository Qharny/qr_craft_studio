import 'package:flutter/material.dart';

class QRProject {
  final String id;
  final String label;
  final String type;
  final String data;
  final int qrColorValue;
  final String createdAt;

  const QRProject({
    required this.id,
    required this.label,
    required this.type,
    required this.data,
    required this.qrColorValue,
    required this.createdAt,
  });

  Color get qrColor => Color(qrColorValue);

  // Convert to JSON Map
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'label': label,
      'type': type,
      'data': data,
      'qrColorValue': qrColorValue,
      'createdAt': createdAt,
    };
  }

  // Parse from JSON Map
  factory QRProject.fromJson(Map<String, dynamic> json) {
    return QRProject(
      id: json['id'] as String? ?? DateTime.now().millisecondsSinceEpoch.toString(),
      label: json['label'] as String? ?? 'Untitled Project',
      type: json['type'] as String? ?? 'URL',
      data: json['data'] as String? ?? '',
      qrColorValue: json['qrColorValue'] as int? ?? 0xFF00D2FF,
      createdAt: json['createdAt'] as String? ?? DateTime.now().toIso8601String(),
    );
  }
}
