import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:secure_qr_scanner/app/screens/menu_screen.dart';
import 'package:secure_qr_scanner/barcode/screens/barcode_scanner_screen.dart';
import 'package:secure_qr_scanner/history/screens/history_screen.dart';
import 'package:secure_qr_scanner/qr_code/screens/generator_screen.dart';
import 'package:secure_qr_scanner/qr_code/screens/result_screen.dart';
import 'package:secure_qr_scanner/qr_code/screens/scanner_screen.dart';

/// Home screen with modern glassmorphism design
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _isProcessingGallery = false;

  Future<void> _navigateToScanner(BuildContext context) async {
    final navigator = Navigator.of(context);
    final result = await navigator.push<String>(
      MaterialPageRoute(builder: (context) => const QRScannerScreen()),
    );

    if (result != null && mounted) {
      // Navigate to result screen with scanned data
      navigator.push(
        MaterialPageRoute(
          builder: (context) => QRResultScreen(scannedData: result),
        ),
      );
    }
  }

  Future<void> _navigateToBarcodeScanner(BuildContext context) async {
    final navigator = Navigator.of(context);
    final result = await navigator.push<String>(
      MaterialPageRoute(builder: (context) => const BarcodeScannerScreen()),
    );

    if (result != null && mounted) {
      // Navigate to result screen with scanned data
      navigator.push(
        MaterialPageRoute(
          builder: (context) => QRResultScreen(scannedData: result),
        ),
      );
    }
  }

  Future<void> _pickFromGallery() async {
    if (_isProcessingGallery) return;

    try {
      final picker = ImagePicker();
      final pickedFile = await picker.pickImage(source: ImageSource.gallery);

      if (pickedFile == null || !mounted) return;

      setState(() => _isProcessingGallery = true);

      // Create a temporary controller for image analysis
      final controller = MobileScannerController(
        detectionSpeed: DetectionSpeed.noDuplicates,
        facing: CameraFacing.back,
      );

      try {
        // Analyze the picked image
        final barcodes = await controller.analyzeImage(pickedFile.path);

        if (!mounted) {
          await controller.dispose();
          return;
        }

        if (barcodes == null || barcodes.barcodes.isEmpty) {
          _showError('No QR code found in the selected image');
          return;
        }

        final barcode = barcodes.barcodes.first;
        if (barcode.rawValue != null) {
          // Navigate to result screen with scanned data
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) =>
                  QRResultScreen(scannedData: barcode.rawValue!),
            ),
          );
        } else {
          _showError('Could not read QR code from image');
        }
      } finally {
        await controller.dispose();
      }
    } catch (e) {
      if (mounted) {
        _showError('Failed to scan image: ${e.toString()}');
      }
    } finally {
      if (mounted) {
        setState(() => _isProcessingGallery = false);
      }
    }
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message, style: GoogleFonts.inter()),
        backgroundColor: const Color(0xFFEF4444),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: _buildMainScreen());
  }

  Widget _buildMainScreen() {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Stack(
      children: [
        // Animated gradient background
        Positioned.fill(
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: isDark
                    ? const [
                        Color(0xFF7C3AED), // violet-600
                        Color(0xFFC026D3), // fuchsia-600
                        Color(0xFF7E22CE), // purple-700
                      ]
                    : const [
                        Color(0xFFE9D5FF), // purple-200
                        Color(0xFFFAE8FF), // fuchsia-100
                        Color(0xFFDDD6FE), // violet-200
                      ],
              ),
            ),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 40, sigmaY: 40),
              child: Container(
                color: isDark
                    ? Colors.black.withValues(alpha: 0.8)
                    : Colors.white.withValues(alpha: 0.7),
              ),
            ),
          ),
        ),

        // Content
        SafeArea(
          child: Column(
            children: [
              // Header
              _buildHeader(),

              // Main content (centered)
              Expanded(child: _buildCenterContent()),

              // Bottom navigation
              _buildBottomNavigation(),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildHeader() {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // App logo and name
          Row(
            children: [
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  gradient: const LinearGradient(
                    colors: [Color(0xFF8B5CF6), Color(0xFFD946EF)],
                  ),
                ),
                child: const Icon(Icons.qr_code, color: Colors.white, size: 20),
              ),
              const SizedBox(width: 8),
              Text(
                'QR Scanner',
                style: GoogleFonts.inter(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: isDark ? Colors.white : Colors.black87,
                ),
              ),
            ],
          ),

          // Settings button
          _buildGlassButton(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const MenuScreen()),
              );
            },
            child: Icon(
              Icons.settings,
              color: isDark ? Colors.white : Colors.black87,
              size: 16,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCenterContent() {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Hero icon with glow
          _buildHeroIcon(),

          const SizedBox(height: 24),

          // Title
          Text(
            'Ready to Scan',
            style: GoogleFonts.inter(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: isDark ? Colors.white : Colors.black87,
            ),
          ),

          const SizedBox(height: 32),

          // Action buttons
          _buildActionButtons(),
        ],
      ),
    );
  }

  Widget _buildHeroIcon() {
    return Stack(
      alignment: Alignment.center,
      children: [
        // Glow effect
        Container(
          width: 144,
          height: 144,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            gradient: const LinearGradient(
              colors: [Color(0xFF8B5CF6), Color(0xFFD946EF)],
            ),
          ),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 40, sigmaY: 40),
            child: Container(color: Colors.transparent),
          ),
        ),

        // Main icon
        Container(
          width: 144,
          height: 144,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            gradient: const LinearGradient(
              colors: [Color(0xFF8B5CF6), Color(0xFFD946EF)],
            ),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF8B5CF6).withValues(alpha: 0.5),
                blurRadius: 24,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: const Icon(
            Icons.center_focus_strong,
            color: Colors.white,
            size: 80,
          ),
        ),
      ],
    );
  }

  Widget _buildActionButtons() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        children: [
          // Primary button - Scan QR Code
          _buildPrimaryButton(
            onTap: () => _navigateToScanner(context),
            icon: Icons.qr_code_scanner,
            label: 'Scan QR Code',
          ),

          const SizedBox(height: 8),

          // Secondary button - Scan Barcode
          _buildSecondaryButton(
            onTap: () => _navigateToBarcodeScanner(context),
            icon: Icons.view_week,
            label: 'Scan Barcode',
          ),

          const SizedBox(height: 8),

          // Tertiary button - Scan from Gallery
          _buildSecondaryButton(
            onTap: _pickFromGallery,
            icon: Icons.image,
            label: 'Scan from Gallery',
          ),
        ],
      ),
    );
  }

  Widget _buildPrimaryButton({
    required VoidCallback onTap,
    required IconData icon,
    required String label,
  }) {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(16),
          child: Ink(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              gradient: const LinearGradient(
                colors: [Color(0xFF8B5CF6), Color(0xFFD946EF)],
              ),
            ),
            child: Center(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(icon, color: Colors.white, size: 20),
                  const SizedBox(width: 8),
                  Text(
                    label,
                    style: GoogleFonts.inter(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSecondaryButton({
    required VoidCallback onTap,
    required IconData icon,
    required String label,
  }) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Material(
            color: isDark
                ? Colors.white.withValues(alpha: 0.1)
                : Colors.black.withValues(alpha: 0.05),
            child: InkWell(
              onTap: onTap,
              child: Center(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      icon,
                      color: isDark ? Colors.white : Colors.black87,
                      size: 20,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      label,
                      style: GoogleFonts.inter(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: isDark ? Colors.white : Colors.black87,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBottomNavigation() {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, bottom: 24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildBottomNavButton(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const QRGeneratorScreen(),
                ),
              );
            },
            icon: Icons.auto_awesome,
            label: 'Generate',
            iconColor: const Color(0xFFA78BFA), // violet-400
          ),

          const SizedBox(width: 8),

          _buildBottomNavButton(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const HistoryScreen()),
              );
            },
            icon: Icons.history,
            label: 'History',
            iconColor: const Color(0xFFE879F9), // fuchsia-400
          ),

          const SizedBox(width: 8),

          _buildBottomNavButton(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const MenuScreen()),
              );
            },
            icon: Icons.settings,
            label: 'More',
            iconColor: const Color(0xFFC084FC), // purple-400
          ),
        ],
      ),
    );
  }

  Widget _buildBottomNavButton({
    required VoidCallback onTap,
    required IconData icon,
    required String label,
    required Color iconColor,
  }) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return ClipRRect(
      borderRadius: BorderRadius.circular(18),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Material(
          color: isDark
              ? Colors.white.withValues(alpha: 0.05)
              : Colors.black.withValues(alpha: 0.05),
          child: InkWell(
            onTap: onTap,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(icon, color: iconColor, size: 16),
                  const SizedBox(width: 6),
                  Text(
                    label,
                    style: GoogleFonts.inter(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: isDark ? Colors.white : Colors.black87,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildGlassButton({
    required VoidCallback onTap,
    required Widget child,
  }) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return ClipRRect(
      borderRadius: BorderRadius.circular(18),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Material(
          color: isDark
              ? Colors.white.withValues(alpha: 0.1)
              : Colors.black.withValues(alpha: 0.05),
          child: InkWell(
            onTap: onTap,
            child: Container(
              width: 36,
              height: 36,
              alignment: Alignment.center,
              child: child,
            ),
          ),
        ),
      ),
    );
  }
}
