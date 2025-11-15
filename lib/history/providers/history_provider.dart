import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:secure_qr_scanner/history/dto/scan_history_item.dart';
import 'package:secure_qr_scanner/history/services/history_service.dart';

/// Provider for history service instance
final historyServiceProvider = Provider<HistoryService>((ref) {
  final service = HistoryService();
  service.init();
  return service;
});

/// Provider for history list (refreshable)
final historyListProvider = FutureProvider.autoDispose<List<ScanHistoryItem>>((
  ref,
) async {
  final service = ref.watch(historyServiceProvider);
  await service.init();
  return service.getAllHistory();
});
