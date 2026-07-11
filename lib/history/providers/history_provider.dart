import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';
import 'package:secure_qr_scanner/history/dto/scan_history_item.dart';

/// Notifier for managing scan history state with persistence
class HistoryNotifier extends Notifier<List<ScanHistoryItem>> {
  static const String _boxName = 'scan_history';

  Box<ScanHistoryItem> get _box {
    return Hive.box<ScanHistoryItem>(_boxName);
  }

  @override
  List<ScanHistoryItem> build() {
    try {
      if (Hive.isBoxOpen(_boxName)) {
        return _getAllHistory();
      }
    } catch (_) {
      // Catch potential box-not-open errors during unit/widget tests
    }
    return const [];
  }

  List<ScanHistoryItem> _getAllHistory() {
    final items = _box.values.toList();
    // Sort by timestamp descending (newest first)
    items.sort((a, b) => b.timestamp.compareTo(a.timestamp));
    return items;
  }

  /// Add a new scan to history
  Future<void> addScan(String content) async {
    try {
      final box = Hive.isBoxOpen(_boxName)
          ? _box
          : await Hive.openBox<ScanHistoryItem>(_boxName);

      final item = ScanHistoryItem.fromScan(content);
      await box.put(item.id, item);

      // Reactively update the state
      state = _getAllHistory();
    } catch (e) {
      // Fail silently
    }
  }

  /// Delete a history item by ID
  Future<void> deleteItem(String id) async {
    try {
      final box = Hive.isBoxOpen(_boxName)
          ? _box
          : await Hive.openBox<ScanHistoryItem>(_boxName);
      await box.delete(id);

      // Reactively update the state
      state = _getAllHistory();
    } catch (e) {
      // Fail silently
    }
  }

  /// Clear all history
  Future<void> clearAll() async {
    try {
      final box = Hive.isBoxOpen(_boxName)
          ? _box
          : await Hive.openBox<ScanHistoryItem>(_boxName);
      await box.clear();

      // Reactively update the state
      state = const [];
    } catch (e) {
      // Fail silently
    }
  }
}

/// Provider for history list state
final historyProvider = NotifierProvider<HistoryNotifier, List<ScanHistoryItem>>(
  HistoryNotifier.new,
);
