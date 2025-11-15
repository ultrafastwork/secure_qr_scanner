import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:secure_qr_scanner/history/providers/history_provider.dart';
import 'package:secure_qr_scanner/qr_code/dto/content_type.dart';
import 'package:secure_qr_scanner/qr_code/dto/detected_content.dart';
import 'package:secure_qr_scanner/qr_code/services/content_action_service.dart';
import 'package:secure_qr_scanner/qr_code/services/content_detector_service.dart';
import 'package:secure_qr_scanner/qr_code/widgets/content_detail_dialogs.dart';
import 'package:share_plus/share_plus.dart';

/// Screen to display scanned QR code result with actions
class QRResultScreen extends ConsumerWidget {
  final String scannedData;
  final bool isFromHistory;

  const QRResultScreen({
    super.key,
    required this.scannedData,
    this.isFromHistory = false,
  });

  DetectedContent get _detectedContent {
    return ContentDetectorService.detect(scannedData);
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
                child: Container(color: Colors.black.withValues(alpha: 0.8)),
              ),
            ),
          ),

          // Content
          SafeArea(
            child: Column(
              children: [
                _buildTopBar(context),
                Expanded(child: _buildContent(context, ref)),
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

  Widget _buildContent(BuildContext context, WidgetRef ref) {
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
          _buildActionButtons(context, ref),

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
                color: const Color(0xFF10B981).withValues(alpha: 0.5),
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
    final content = _detectedContent;
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: Colors.white.withValues(alpha: 0.2),
              width: 1,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                ContentActionService.getIcon(content.type),
                color: const Color(0xFFA78BFA),
                size: 16,
              ),
              const SizedBox(width: 8),
              Text(
                content.type.displayName,
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
            color: Colors.white.withValues(alpha: 0.05),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: Colors.white.withValues(alpha: 0.1),
              width: 1,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Content',
                style: GoogleFonts.inter(
                  fontSize: 12,
                  color: Colors.white.withValues(alpha: 0.6),
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

  Widget _buildActionButtons(BuildContext context, WidgetRef ref) {
    final content = _detectedContent;
    final primaryAction = ContentActionService.getPrimaryAction(content);
    final secondaryActions = ContentActionService.getSecondaryActions(content);

    return Column(
      children: [
        // Primary action based on content type
        if (primaryAction != null)
          _buildPrimaryButton(
            onTap: () => _handleAction(context, primaryAction, content),
            icon: primaryAction.icon,
            label: primaryAction.label,
          )
        else
          _buildPrimaryButton(
            onTap: () => _copyToClipboard(context),
            icon: Icons.content_copy,
            label: 'Copy to Clipboard',
          ),

        const SizedBox(height: 12),

        // Type-specific secondary actions
        if (secondaryActions.isNotEmpty) ...[
          ...secondaryActions.map(
            (action) => Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: _buildSecondaryButton(
                onTap: () => _handleAction(context, action, content),
                icon: action.icon,
                label: action.label,
              ),
            ),
          ),
        ],

        // Always available actions
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
            onTap: () async {
              final service = ref.read(historyServiceProvider);
              await service.addScan(scannedData);
              if (context.mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      'Saved to history',
                      style: GoogleFonts.inter(),
                    ),
                    backgroundColor: const Color(0xFF10B981),
                    behavior: SnackBarBehavior.floating,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                );
              }
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
            color: Colors.white.withValues(alpha: 0.1),
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
          color: Colors.white.withValues(alpha: 0.1),
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
  Future<void> _handleAction(
    BuildContext context,
    ContentAction action,
    DetectedContent content,
  ) async {
    // Handle actions that need dialogs
    if (action.handler == null) {
      switch (content.type) {
        case ContentType.wifi:
          if (context.mounted) {
            showDialog(
              context: context,
              builder: (ctx) => WifiDetailDialog(content: content),
            );
          }
          break;
        case ContentType.vcard:
          if (context.mounted) {
            showDialog(
              context: context,
              builder: (ctx) => VCardDetailDialog(content: content),
            );
          }
          break;
        case ContentType.calendar:
          if (context.mounted) {
            showDialog(
              context: context,
              builder: (ctx) => CalendarDetailDialog(content: content),
            );
          }
          break;
        default:
          break;
      }
      return;
    }

    // Handle actions with handlers
    try {
      await action.handler!();
    } catch (e) {
      if (context.mounted) {
        _showError(context, e.toString().replaceAll('Exception: ', ''));
      }
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
    try {
      await SharePlus.instance.share(ShareParams(text: scannedData));
    } catch (e) {
      if (context.mounted) {
        _showError(context, 'Failed to share content');
      }
    }
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
