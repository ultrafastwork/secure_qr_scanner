import 'package:secure_qr_scanner/qr_code/dto/content_type.dart';

/// Model representing detected QR code content with parsed metadata
class DetectedContent {
  final String rawData;
  final ContentType type;
  final Map<String, String> parsedData;

  const DetectedContent({
    required this.rawData,
    required this.type,
    this.parsedData = const {},
  });

  /// Get a specific parsed field
  String? getField(String key) => parsedData[key];

  /// Check if a field exists
  bool hasField(String key) => parsedData.containsKey(key);
}
