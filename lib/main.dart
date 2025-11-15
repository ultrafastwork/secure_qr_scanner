import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:secure_qr_scanner/app/screens/home_screen.dart';
import 'package:secure_qr_scanner/app/theme/app_theme.dart';

/// Entry point of the Secure QR Scanner app
/// Initializes Hive database and runs the app with Riverpod
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Hive for local storage (v1.0 MVP - Basic History)
  final appDocumentDir = await getApplicationDocumentsDirectory();
  Hive.init(appDocumentDir.path);

  // Set preferred orientations
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(const ProviderScope(child: SecureQRScannerApp()));
}

/// Root application widget with Material app configuration
class SecureQRScannerApp extends StatelessWidget {
  const SecureQRScannerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Secure QR Scanner',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme(),
      darkTheme: AppTheme.darkTheme(),
      themeMode: ThemeMode.system,
      home: const HomeScreen(),
    );
  }
}
