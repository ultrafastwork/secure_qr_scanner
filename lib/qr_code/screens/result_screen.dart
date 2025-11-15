import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

/// Screen to display scanned QR code result with actions
class QRResultScreen extends ConsumerWidget {
  final String scannedData;
  final bool isFromHistory;

  const QRResultScreen({
    super.key,
    required this.scannedData,
    this.isFromHistory = false,
  });

  bool get _isUrl {
    return scannedData.startsWith('http://') ||
        scannedData.startsWith('https://') ||
        scannedData.startsWith('www.');
  }

  String get _contentType {
    if (_isUrl) return 'URL';
    if (scannedData.startsWith('tel:')) return 'Phone';
    if (scannedData.startsWith('mailto:')) return 'Email';
    if (scannedData.startsWith('WIFI:')) return 'Wi-Fi';
    return 'Text';
  }

  IconData get _contentIcon {
    if (_isUrl) return Icons.link;
    if (scannedData.startsWith('tel:')) return Icons.phone;
    if (scannedData.startsWith('mailto:')) return Icons.email;
    if (scannedData.startsWith('WIFI:')) return Icons.wifi;
    return Icons.text_fields;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Stack(
        children: [
          // Gradient background
          Positioned.fill(
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color(0xFF7C3AED), // violet-600
                    Color(0xFFC026D3), // fuchsia-600
                    Color(0xFF7E22CE), // purple-700
                  ],
                ),
              ),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 40, sigmaY: 40),
                child: Container(color: Colors.black.withOpacity(0.8)),
              ),
            ),
          ),

          // Content
          SafeArea(
            child: Column(
              children: [
                _buildTopBar(context),
                Expanded(child: _buildContent(context)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTopBar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Row(
        children: [
          _buildGlassButton(
            onTap: () => Navigator.of(context).pop(),
            child: const Icon(Icons.arrow_back, color: Colors.white, size: 20),
          ),
          const SizedBox(width: 12),
          Text(
            'Scan Result',
            style: GoogleFonts.inter(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          const SizedBox(height: 20),

          // Success icon with glow
          _buildSuccessIcon(),

          const SizedBox(height: 32),

          // Content type badge
          _buildContentTypeBadge(),

          const SizedBox(height: 24),

          // Scanned data display
          _buildDataDisplay(context),

          const SizedBox(height: 32),

          // Action buttons
          _buildActionButtons(context),

          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildSuccessIcon() {
    return Stack(
      alignment: Alignment.center,
      children: [
        // Glow effect
        Container(
          width: 120,
          height: 120,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: const LinearGradient(
              colors: [Color(0xFF10B981), Color(0xFF059669)],
            ),
          ),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 30, sigmaY: 30),
            child: Container(color: Colors.transparent),
          ),
        ),

        // Icon container
        Container(
          width: 120,
          height: 120,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: const LinearGradient(
              colors: [Color(0xFF10B981), Color(0xFF059669)],
            ),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF10B981).withOpacity(0.5),
                blurRadius: 24,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: const Icon(Icons.check_circle, color: Colors.white, size: 60),
        ),
      ],
    );
  }

  Widget _buildContentTypeBadge() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.1),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.white.withOpacity(0.2), width: 1),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(_contentIcon, color: const Color(0xFFA78BFA), size: 16),
              const SizedBox(width: 8),
              Text(
                _contentType,
                style: GoogleFonts.inter(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDataDisplay(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.05),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.white.withOpacity(0.1), width: 1),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Content',
                style: GoogleFonts.inter(
                  fontSize: 12,
                  color: Colors.white.withOpacity(0.6),
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 12),
              SelectableText(
                scannedData,
                style: GoogleFonts.inter(
                  fontSize: 16,
                  color: Colors.white,
                  height: 1.5,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    return Column(
      children: [
        // Primary action based on content type
        if (_isUrl)
          _buildPrimaryButton(
            onTap: () => _openInBrowser(context),
            icon: Icons.open_in_browser,
            label: 'Open in Browser',
          )
        else
          _buildPrimaryButton(
            onTap: () => _copyToClipboard(context),
            icon: Icons.content_copy,
            label: 'Copy to Clipboard',
          ),

        const SizedBox(height: 12),

        // Secondary actions
        Row(
          children: [
            Expanded(
              child: _buildSecondaryButton(
                onTap: () => _copyToClipboard(context),
                icon: Icons.copy_all,
                label: 'Copy',
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _buildSecondaryButton(
                onTap: () => _shareContent(context),
                icon: Icons.share,
                label: 'Share',
              ),
            ),
          ],
        ),

        if (!isFromHistory) ...[
          const SizedBox(height: 12),
          _buildSecondaryButton(
            onTap: () {
              // TODO: Save to history
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Saved to history', style: GoogleFonts.inter()),
                  backgroundColor: const Color(0xFF10B981),
                  behavior: SnackBarBehavior.floating,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              );
            },
            icon: Icons.bookmark_add,
            label: 'Save to History',
          ),
        ],
      ],
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
    return SizedBox(
      height: 56,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Material(
            color: Colors.white.withOpacity(0.1),
            child: InkWell(
              onTap: onTap,
              child: Center(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(icon, color: Colors.white, size: 20),
                    const SizedBox(width: 8),
                    Text(
                      label,
                      style: GoogleFonts.inter(
                        fontSize: 14,
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
      ),
    );
  }

  Widget _buildGlassButton({
    required VoidCallback onTap,
    required Widget child,
  }) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(18),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Material(
          color: Colors.white.withOpacity(0.1),
          child: InkWell(
            onTap: onTap,
            child: Container(
              width: 40,
              height: 40,
              alignment: Alignment.center,
              child: child,
            ),
          ),
        ),
      ),
    );
  }

  // Action handlers
  Future<void> _openInBrowser(BuildContext context) async {
    try {
      final uri = Uri.parse(scannedData);
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      } else {
        _showError(context, 'Could not open URL');
      }
    } catch (e) {
      _showError(context, 'Invalid URL');
    }
  }

  Future<void> _copyToClipboard(BuildContext context) async {
    await Clipboard.setData(ClipboardData(text: scannedData));
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Copied to clipboard', style: GoogleFonts.inter()),
          backgroundColor: const Color(0xFF8B5CF6),
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          duration: const Duration(seconds: 2),
        ),
      );
    }
  }

  Future<void> _shareContent(BuildContext context) async {
    // TODO: Implement share using share_plus package
    _showError(context, 'Share feature coming soon');
  }

  void _showError(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message, style: GoogleFonts.inter()),
        backgroundColor: const Color(0xFFEF4444),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }
}
