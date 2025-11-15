import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:secure_qr_scanner/app/providers/theme_provider.dart';

/// Settings screen with theme toggle and app information
class SettingsScreen extends ConsumerStatefulWidget {
  const SettingsScreen({super.key});

  @override
  ConsumerState<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends ConsumerState<SettingsScreen> {
  String _appVersion = '';

  @override
  void initState() {
    super.initState();
    _loadAppVersion();
  }

  Future<void> _loadAppVersion() async {
    final packageInfo = await PackageInfo.fromPlatform();
    setState(() {
      _appVersion = 'v${packageInfo.version}+${packageInfo.buildNumber}';
    });
  }

  @override
  Widget build(BuildContext context) {
    final currentTheme = ref.watch(themeProvider);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      body: Stack(
        children: [
          // Gradient background
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
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Row(
                    children: [
                      // Back button
                      Container(
                        decoration: BoxDecoration(
                          color: isDark
                              ? Colors.white.withValues(alpha: 0.1)
                              : Colors.black.withValues(alpha: 0.05),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: isDark
                                ? Colors.white.withValues(alpha: 0.1)
                                : Colors.black.withValues(alpha: 0.1),
                            width: 1,
                          ),
                        ),
                        child: IconButton(
                          icon: const Icon(Icons.arrow_back_ios_new),
                          onPressed: () => Navigator.of(context).pop(),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Text(
                        'Settings',
                        style: GoogleFonts.inter(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: isDark
                              ? Colors.white
                              : const Color(0xFF1F1F1F),
                        ),
                      ),
                    ],
                  ),
                ),

                // Settings content
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 8),

                        // Appearance Section
                        _buildSectionTitle('Appearance', isDark),
                        const SizedBox(height: 12),
                        _buildGlassCard(
                          isDark: isDark,
                          child: Column(
                            children: [
                              _buildThemeOption(
                                title: 'Light',
                                subtitle: 'Light theme',
                                icon: Icons.light_mode,
                                isSelected: currentTheme == ThemeMode.light,
                                onTap: () {
                                  ref
                                      .read(themeProvider.notifier)
                                      .setTheme(ThemeMode.light);
                                },
                                isDark: isDark,
                              ),
                              _buildDivider(isDark),
                              _buildThemeOption(
                                title: 'Dark',
                                subtitle: 'Dark theme',
                                icon: Icons.dark_mode,
                                isSelected: currentTheme == ThemeMode.dark,
                                onTap: () {
                                  ref
                                      .read(themeProvider.notifier)
                                      .setTheme(ThemeMode.dark);
                                },
                                isDark: isDark,
                              ),
                              _buildDivider(isDark),
                              _buildThemeOption(
                                title: 'System',
                                subtitle: 'Follow system settings',
                                icon: Icons.settings_suggest,
                                isSelected: currentTheme == ThemeMode.system,
                                onTap: () {
                                  ref
                                      .read(themeProvider.notifier)
                                      .setTheme(ThemeMode.system);
                                },
                                isDark: isDark,
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 32),

                        // About Section
                        _buildSectionTitle('About', isDark),
                        const SizedBox(height: 12),
                        _buildGlassCard(
                          isDark: isDark,
                          child: Column(
                            children: [
                              _buildInfoRow(
                                label: 'App Version',
                                value: _appVersion.isNotEmpty
                                    ? _appVersion
                                    : 'Loading...',
                                isDark: isDark,
                              ),
                              _buildDivider(isDark),
                              _buildInfoRow(
                                label: 'Developer',
                                value: 'Ultrafastwork',
                                isDark: isDark,
                              ),
                              _buildDivider(isDark),
                              _buildInfoRow(
                                label: 'Framework',
                                value: 'Flutter',
                                isDark: isDark,
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 32),

                        // App Description
                        Center(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Text(
                              'Secure QR Code & Barcode Scanner\nwith advanced features',
                              textAlign: TextAlign.center,
                              style: GoogleFonts.inter(
                                fontSize: 13,
                                color: isDark
                                    ? Colors.white.withValues(alpha: 0.5)
                                    : Colors.black.withValues(alpha: 0.5),
                                height: 1.5,
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(height: 32),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title, bool isDark) {
    return Text(
      title,
      style: GoogleFonts.inter(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: isDark ? Colors.white : const Color(0xFF1F1F1F),
      ),
    );
  }

  Widget _buildGlassCard({required bool isDark, required Widget child}) {
    return Container(
      decoration: BoxDecoration(
        color: isDark
            ? Colors.white.withValues(alpha: 0.05)
            : Colors.white.withValues(alpha: 0.8),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isDark
              ? Colors.white.withValues(alpha: 0.1)
              : Colors.black.withValues(alpha: 0.1),
          width: 1,
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: child,
        ),
      ),
    );
  }

  Widget _buildThemeOption({
    required String title,
    required String subtitle,
    required IconData icon,
    required bool isSelected,
    required VoidCallback onTap,
    required bool isDark,
  }) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: isSelected
                    ? const Color(0xFF8B5CF6).withValues(alpha: 0.2)
                    : isDark
                    ? Colors.white.withValues(alpha: 0.05)
                    : Colors.black.withValues(alpha: 0.05),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                icon,
                color: isSelected
                    ? const Color(0xFF8B5CF6)
                    : isDark
                    ? Colors.white.withValues(alpha: 0.7)
                    : Colors.black.withValues(alpha: 0.7),
                size: 24,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: GoogleFonts.inter(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: isDark ? Colors.white : const Color(0xFF1F1F1F),
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
                    style: GoogleFonts.inter(
                      fontSize: 13,
                      color: isDark
                          ? Colors.white.withValues(alpha: 0.5)
                          : Colors.black.withValues(alpha: 0.5),
                    ),
                  ),
                ],
              ),
            ),
            if (isSelected)
              const Icon(
                Icons.check_circle,
                color: Color(0xFF8B5CF6),
                size: 24,
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow({
    required String label,
    required String value,
    required bool isDark,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: GoogleFonts.inter(
              fontSize: 15,
              color: isDark
                  ? Colors.white.withValues(alpha: 0.7)
                  : Colors.black.withValues(alpha: 0.7),
            ),
          ),
          Text(
            value,
            style: GoogleFonts.inter(
              fontSize: 15,
              fontWeight: FontWeight.w500,
              color: isDark ? Colors.white : const Color(0xFF1F1F1F),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDivider(bool isDark) {
    return Divider(
      height: 1,
      thickness: 1,
      color: isDark
          ? Colors.white.withValues(alpha: 0.05)
          : Colors.black.withValues(alpha: 0.05),
    );
  }
}
