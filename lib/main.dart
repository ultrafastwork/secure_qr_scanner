import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';
import 'package:secure_qr_scanner/app/providers/theme_provider.dart';
import 'package:secure_qr_scanner/app/screens/home_screen.dart';
import 'package:secure_qr_scanner/app/theme/app_theme.dart';
import 'package:secure_qr_scanner/history/dto/scan_history_item.dart';

/// Entry point of the Secure QR Scanner app
/// Initializes Hive database and runs the app with Riverpod
void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  // Initialize Hive for local storage (v1.0 MVP - Basic History)
  await Hive.initFlutter();

  // Register Hive adapters
  if (!Hive.isAdapterRegistered(0)) {
    Hive.registerAdapter(ScanHistoryItemAdapter());
  }

  // Open all Hive boxes once at startup for better performance
  await Hive.openBox('settings');
  await Hive.openBox('qr_customization');
  await Hive.openBox<ScanHistoryItem>('scan_history');

  // Set preferred orientations
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  // Always remove splash screen, even on error
  FlutterNativeSplash.remove();

  runApp(const ProviderScope(child: SecureQRScannerApp()));
}

/// Root application widget with Material app configuration and theme management
class SecureQRScannerApp extends ConsumerWidget {
  const SecureQRScannerApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Watch the theme provider to rebuild when theme changes
    final themeMode = ref.watch(themeProvider);

    return MaterialApp(
      title: 'Secure QR Scanner',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme(),
      darkTheme: AppTheme.darkTheme(),
      themeMode: themeMode,
      home: const HomeScreen(),
    );
  }
}
