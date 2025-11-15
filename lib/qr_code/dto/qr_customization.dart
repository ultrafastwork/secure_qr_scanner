import 'package:flutter/material.dart';

/// QR Code style shape options
enum QrShapeStyle {
  smooth,
  rounded,
  square,
  circle;

  String get displayName {
    switch (this) {
      case QrShapeStyle.smooth:
        return 'Smooth';
      case QrShapeStyle.rounded:
        return 'Rounded';
      case QrShapeStyle.square:
        return 'Square';
      case QrShapeStyle.circle:
        return 'Circle';
    }
  }

  IconData get icon {
    switch (this) {
      case QrShapeStyle.smooth:
        return Icons.blur_circular;
      case QrShapeStyle.rounded:
        return Icons.rounded_corner;
      case QrShapeStyle.square:
        return Icons.crop_square;
      case QrShapeStyle.circle:
        return Icons.circle;
    }
  }
}

/// QR Code customization settings
class QrCustomization {
  final Color foregroundColor;
  final Color backgroundColor;
  final QrShapeStyle shapeStyle;
  final String? logoPath; // Path to logo image
  final double logoSize; // Logo size percentage (0.0 - 0.3)

  const QrCustomization({
    this.foregroundColor = Colors.black,
    this.backgroundColor = Colors.white,
    this.shapeStyle = QrShapeStyle.smooth,
    this.logoPath,
    this.logoSize = 0.2,
  });

  /// Create a copy with modified fields
  QrCustomization copyWith({
    Color? foregroundColor,
    Color? backgroundColor,
    QrShapeStyle? shapeStyle,
    String? logoPath,
    double? logoSize,
  }) {
    return QrCustomization(
      foregroundColor: foregroundColor ?? this.foregroundColor,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      shapeStyle: shapeStyle ?? this.shapeStyle,
      logoPath: logoPath ?? this.logoPath,
      logoSize: logoSize ?? this.logoSize,
    );
  }

  /// Convert to Map for storage
  Map<String, dynamic> toMap() {
    return {
      'foregroundColor': foregroundColor.toARGB32(),
      'backgroundColor': backgroundColor.toARGB32(),
      'shapeStyle': shapeStyle.name,
      'logoPath': logoPath,
      'logoSize': logoSize,
    };
  }

  /// Create from Map
  factory QrCustomization.fromMap(Map<String, dynamic> map) {
    return QrCustomization(
      foregroundColor: Color(map['foregroundColor'] as int),
      backgroundColor: Color(map['backgroundColor'] as int),
      shapeStyle: QrShapeStyle.values.firstWhere(
        (e) => e.name == map['shapeStyle'],
        orElse: () => QrShapeStyle.smooth,
      ),
      logoPath: map['logoPath'] as String?,
      logoSize: (map['logoSize'] as num?)?.toDouble() ?? 0.2,
    );
  }

  /// Default customization
  static const defaultCustomization = QrCustomization();
}

/// Saved QR customization preset
class QrPreset {
  final String id;
  final String name;
  final QrCustomization customization;
  final DateTime createdAt;

  QrPreset({
    required this.id,
    required this.name,
    required this.customization,
    required this.createdAt,
  });

  /// Convert to Map for storage
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'customization': customization.toMap(),
      'createdAt': createdAt.millisecondsSinceEpoch,
    };
  }

  /// Create from Map
  factory QrPreset.fromMap(Map<String, dynamic> map) {
    return QrPreset(
      id: map['id'] as String,
      name: map['name'] as String,
      customization: QrCustomization.fromMap(
        map['customization'] as Map<String, dynamic>,
      ),
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['createdAt'] as int),
    );
  }
}
