// Widget tests for Secure QR Scanner app

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:secure_qr_scanner/main.dart';

void main() {
  testWidgets('App loads and displays home screen', (
    WidgetTester tester,
  ) async {
    // Build our app and trigger a frame
    await tester.pumpWidget(const ProviderScope(child: SecureQRScannerApp()));

    // Verify that the app title appears
    expect(find.text('QR Scanner'), findsOneWidget);

    // Verify that hero title appears
    expect(find.text('Ready to Scan'), findsOneWidget);

    // Verify that MVP action buttons are displayed
    expect(find.text('Scan QR Code'), findsAtLeastNWidgets(1));
    expect(find.text('Scan Barcode'), findsAtLeastNWidgets(1));
    expect(find.text('Scan from Gallery'), findsOneWidget);

    // Verify bottom navigation buttons
    expect(find.text('Generate'), findsOneWidget);
    expect(find.text('History'), findsOneWidget);
    expect(find.text('More'), findsOneWidget);
  });

  testWidgets('Menu overlay opens and closes', (WidgetTester tester) async {
    await tester.pumpWidget(const ProviderScope(child: SecureQRScannerApp()));

    // Tap the More button to open menu
    await tester.tap(find.text('More'));
    await tester.pumpAndSettle();

    // Verify menu is displayed
    expect(find.text('Menu'), findsOneWidget);
    expect(find.text('Generate QR'), findsOneWidget);
    expect(find.text('Settings'), findsOneWidget);
    expect(find.text('QR Scanner v1.0'), findsOneWidget);

    // Close menu
    await tester.tap(find.byIcon(Icons.close));
    await tester.pumpAndSettle();

    // Verify menu is closed
    expect(find.text('Menu'), findsNothing);
  });
}
