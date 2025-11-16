import 'package:hive_ce/hive.dart';
import 'package:secure_qr_scanner/history/dto/scan_history_item.dart';

/// Service for managing scan history with Hive
class HistoryService {
  static const String _boxName = 'scan_history';
  Box<ScanHistoryItem>? _box;

  /// Initialize the Hive box (box is already opened in main.dart)
  Future<void> init() async {
    _box = Hive.box<ScanHistoryItem>(_boxName);
  }

  /// Get all history items sorted by timestamp (newest first)
  List<ScanHistoryItem> getAllHistory() {
    if (_box == null) return [];
    final items = _box!.values.toList();
    items.sort((a, b) => b.timestamp.compareTo(a.timestamp));
    return items;
  }

  /// Add a new scan to history
  Future<void> addScan(String content) async {
    if (_box == null) await init();
    final item = ScanHistoryItem.fromScan(content);
    await _box!.put(item.id, item);
  }

  /// Delete a history item by ID
  Future<void> deleteItem(String id) async {
    if (_box == null) return;
    await _box!.delete(id);
  }

  /// Clear all history
  Future<void> clearAll() async {
    if (_box == null) return;
    await _box!.clear();
  }

  /// Get history count
  int getCount() {
    return _box?.length ?? 0;
  }

  /// Check if item exists
  bool hasItem(String id) {
    return _box?.containsKey(id) ?? false;
  }

  /// Close the box (cleanup)
  Future<void> close() async {
    await _box?.close();
  }
}
