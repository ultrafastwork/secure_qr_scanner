import 'dart:io';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';
import 'package:secure_qr_scanner/history/dto/scan_history_item.dart';
import 'package:secure_qr_scanner/history/providers/history_provider.dart';

void main() {
  late Directory tempDir;

  setUp(() async {
    tempDir = await Directory.systemTemp.createTemp('hive_test');
    Hive.init(tempDir.path);
    if (!Hive.isAdapterRegistered(0)) {
      Hive.registerAdapter(ScanHistoryItemAdapter());
    }
    await Hive.openBox<ScanHistoryItem>('scan_history');
  });

  tearDown(() async {
    await Hive.close();
    if (await tempDir.exists()) {
      await tempDir.delete(recursive: true);
    }
  });

  test('HistoryNotifier adds, deletes, and clears scans correctly', () async {
    final container = ProviderContainer();
    addTearDown(container.dispose);

    // Initial state should be empty
    var state = container.read(historyProvider);
    expect(state, isEmpty);

    // Add a scan
    await container.read(historyProvider.notifier).addScan('https://google.com');
    state = container.read(historyProvider);
    expect(state, hasLength(1));
    expect(state.first.content, 'https://google.com');
    expect(state.first.type, 'Web Link');

    // Add another scan
    await container.read(historyProvider.notifier).addScan('hello text');
    state = container.read(historyProvider);
    expect(state, hasLength(2));
    expect(state.first.content, 'hello text');
    expect(state.first.type, 'Plain Text');

    // Delete first scan
    final deleteId = state.first.id;
    await container.read(historyProvider.notifier).deleteItem(deleteId);
    state = container.read(historyProvider);
    expect(state, hasLength(1));
    expect(state.first.content, 'https://google.com');

    // Clear all scans
    await container.read(historyProvider.notifier).clearAll();
    state = container.read(historyProvider);
    expect(state, isEmpty);
  });
}
