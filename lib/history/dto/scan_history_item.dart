import 'package:hive_ce/hive.dart';

part 'scan_history_item.g.dart';

/// Hive model for storing scanned QR code history
@HiveType(typeId: 0)
class ScanHistoryItem extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String content;

  @HiveField(2)
  final String type; // 'URL', 'Text', 'Phone', 'Email', 'Wi-Fi', etc.

  @HiveField(3)
  final DateTime timestamp;

  ScanHistoryItem({
    required this.id,
    required this.content,
    required this.type,
    required this.timestamp,
  });

  /// Helper to determine content type from scanned data
  static String determineType(String content) {
    if (content.startsWith('http://') ||
        content.startsWith('https://') ||
        content.startsWith('www.')) {
      return 'URL';
    }
    if (content.startsWith('tel:')) return 'Phone';
    if (content.startsWith('mailto:')) return 'Email';
    if (content.startsWith('WIFI:')) return 'Wi-Fi';
    return 'Text';
  }

  /// Create a new history item from scanned content
  factory ScanHistoryItem.fromScan(String content) {
    return ScanHistoryItem(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      content: content,
      type: determineType(content),
      timestamp: DateTime.now(),
    );
  }
}
