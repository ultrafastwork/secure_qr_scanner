import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:secure_qr_scanner/app/screens/settings_screen.dart';
import 'package:secure_qr_scanner/barcode/screens/barcode_scanner_screen.dart';
import 'package:secure_qr_scanner/history/screens/history_screen.dart';
import 'package:secure_qr_scanner/qr_code/screens/custom_qr_generator_screen.dart'
    as custom_qr;
import 'package:secure_qr_scanner/qr_code/screens/generator_screen.dart';
import 'package:secure_qr_scanner/qr_code/screens/result_screen.dart';
import 'package:secure_qr_scanner/qr_code/screens/scanner_screen.dart';
import 'package:secure_qr_scanner/qr_code/screens/wifi_generator_screen.dart';

/// Home screen with modern glassmorphism design
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _showMenu = false;

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Main home screen
          _buildMainScreen(),
          // Menu overlay
          if (_showMenu) _buildMenuOverlay(),
        ],
      ),
    );
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
            onTap: () => setState(() => _showMenu = true),
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
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const BarcodeScannerScreen(),
                ),
              );
            },
            icon: Icons.view_week,
            label: 'Scan Barcode',
          ),

          const SizedBox(height: 8),

          // Tertiary button - Scan from Gallery
          _buildSecondaryButton(
            onTap: () async {
              // Navigate to scanner screen which has gallery picking functionality
              final navigator = Navigator.of(context);
              await navigator.push(
                MaterialPageRoute(
                  builder: (context) => const QRScannerScreen(),
                ),
              );
            },
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
            onTap: () => setState(() => _showMenu = true),
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

  Widget _buildMenuOverlay() {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      child: GestureDetector(
        onTap: () => setState(() => _showMenu = false),
        child: Container(
          color: Colors.black.withValues(alpha: 0.95),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
            child: SafeArea(
              child: Column(
                children: [
                  // Menu header
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Menu',
                          style: GoogleFonts.inter(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        _buildGlassButton(
                          onTap: () => setState(() => _showMenu = false),
                          child: const Icon(
                            Icons.close,
                            color: Colors.white,
                            size: 20,
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Menu items
                  Expanded(
                    child: ListView(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      children: [
                        _buildFeaturedMenuItem(
                          icon: Icons.center_focus_strong,
                          title: 'Scan QR Code',
                          subtitle: 'Open camera scanner',
                          onTap: () async {
                            setState(() => _showMenu = false);
                            await _navigateToScanner(context);
                            if (mounted) {
                              setState(() => _showMenu = true);
                            }
                          },
                        ),

                        const SizedBox(height: 8),

                        _buildMenuItem(
                          icon: Icons.view_week,
                          title: 'Scan Barcode',
                          subtitle: 'EAN, UPC, Code128, etc',
                          onTap: () async {
                            setState(() => _showMenu = false);
                            await Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) =>
                                    const BarcodeScannerScreen(),
                              ),
                            );
                            if (mounted) {
                              setState(() => _showMenu = true);
                            }
                          },
                        ),

                        const SizedBox(height: 8),

                        _buildMenuItem(
                          icon: Icons.auto_awesome,
                          title: 'Generate QR',
                          subtitle: 'Create QR codes',
                          onTap: () async {
                            setState(() => _showMenu = false);
                            await Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => const QRGeneratorScreen(),
                              ),
                            );
                            if (mounted) {
                              setState(() => _showMenu = true);
                            }
                          },
                        ),

                        const SizedBox(height: 8),

                        _buildMenuItem(
                          icon: Icons.palette,
                          title: 'Custom QR',
                          subtitle: 'QR with colors & logo',
                          onTap: () async {
                            setState(() => _showMenu = false);
                            await Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) =>
                                    const custom_qr.CustomQrGeneratorScreen(),
                              ),
                            );
                            if (mounted) {
                              setState(() => _showMenu = true);
                            }
                          },
                        ),

                        const SizedBox(height: 8),

                        _buildMenuItem(
                          icon: Icons.wifi_tethering,
                          title: 'Wi-Fi QR',
                          subtitle: 'Share Wi-Fi easily',
                          onTap: () async {
                            setState(() => _showMenu = false);
                            await Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) =>
                                    const WifiGeneratorScreen(),
                              ),
                            );
                            if (mounted) {
                              setState(() => _showMenu = true);
                            }
                          },
                        ),

                        const SizedBox(height: 8),

                        _buildMenuItem(
                          icon: Icons.history,
                          title: 'History',
                          subtitle: 'View past scans',
                          onTap: () async {
                            setState(() => _showMenu = false);
                            await Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => const HistoryScreen(),
                              ),
                            );
                            if (mounted) {
                              setState(() => _showMenu = true);
                            }
                          },
                        ),

                        const SizedBox(height: 8),

                        _buildMenuItem(
                          icon: Icons.settings,
                          title: 'Settings',
                          subtitle: 'Preferences & theme',
                          onTap: () async {
                            setState(() => _showMenu = false);
                            await Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => const SettingsScreen(),
                              ),
                            );
                            if (mounted) {
                              setState(() => _showMenu = true);
                            }
                          },
                        ),
                      ],
                    ),
                  ),

                  // Footer
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      border: Border(
                        top: BorderSide(
                          color: Colors.white.withValues(alpha: 0.1),
                          width: 1,
                        ),
                      ),
                    ),
                    child: Text(
                      'QR Scanner v1.0',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.inter(
                        fontSize: 12,
                        color: Colors.white.withValues(alpha: 0.4),
                      ),
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

  Widget _buildFeaturedMenuItem({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Ink(
          height: 80,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            gradient: const LinearGradient(
              colors: [Color(0xFF7C3AED), Color(0xFFC026D3)],
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.white.withValues(alpha: 0.2),
                  ),
                  child: Icon(icon, color: Colors.white, size: 20),
                ),

                const SizedBox(width: 12),

                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        title,
                        style: GoogleFonts.inter(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        subtitle,
                        style: GoogleFonts.inter(
                          fontSize: 12,
                          color: Colors.white.withValues(alpha: 0.6),
                        ),
                      ),
                    ],
                  ),
                ),

                Icon(
                  Icons.chevron_right,
                  color: Colors.white.withValues(alpha: 0.6),
                  size: 20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMenuItem({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Material(
          color: Colors.white.withValues(alpha: 0.05),
          child: InkWell(
            onTap: onTap,
            child: Container(
              height: 80,
              padding: const EdgeInsets.all(20),
              child: Row(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.white.withValues(alpha: 0.1),
                    ),
                    child: Icon(icon, color: Colors.white, size: 20),
                  ),

                  const SizedBox(width: 12),

                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          title,
                          style: GoogleFonts.inter(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          subtitle,
                          style: GoogleFonts.inter(
                            fontSize: 12,
                            color: Colors.white.withValues(alpha: 0.6),
                          ),
                        ),
                      ],
                    ),
                  ),

                  Icon(
                    Icons.chevron_right,
                    color: Colors.white.withValues(alpha: 0.4),
                    size: 20,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
