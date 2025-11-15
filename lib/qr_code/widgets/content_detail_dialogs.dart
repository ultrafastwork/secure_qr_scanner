import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:secure_qr_scanner/qr_code/dto/detected_content.dart';

/// Dialog to show Wi-Fi network details
class WifiDetailDialog extends StatelessWidget {
  final DetectedContent content;

  const WifiDetailDialog({super.key, required this.content});

  @override
  Widget build(BuildContext context) {
    final ssid = content.getField('ssid') ?? 'Unknown';
    final password = content.getField('password') ?? '';
    final security = content.getField('security') ?? 'Unknown';
    final hidden = content.getField('hidden') == 'true';

    return _buildDialog(
      context,
      title: 'Wi-Fi Network',
      icon: Icons.wifi,
      children: [
        _buildDetailRow('Network Name', ssid, context),
        if (password.isNotEmpty) _buildPasswordRow(password, context),
        _buildDetailRow('Security', security, context),
        if (hidden) _buildDetailRow('Hidden', 'Yes', context),
      ],
    );
  }
}

/// Dialog to show contact (vCard) details
class VCardDetailDialog extends StatelessWidget {
  final DetectedContent content;

  const VCardDetailDialog({super.key, required this.content});

  @override
  Widget build(BuildContext context) {
    final name = content.getField('name');
    final phone = content.getField('phone');
    final email = content.getField('email');
    final organization = content.getField('organization');
    final title = content.getField('title');
    final url = content.getField('url');
    final note = content.getField('note');

    return _buildDialog(
      context,
      title: 'Contact',
      icon: Icons.contact_page,
      children: [
        if (name != null) _buildDetailRow('Name', name, context),
        if (phone != null) _buildDetailRow('Phone', phone, context),
        if (email != null) _buildDetailRow('Email', email, context),
        if (organization != null)
          _buildDetailRow('Organization', organization, context),
        if (title != null) _buildDetailRow('Title', title, context),
        if (url != null) _buildDetailRow('Website', url, context),
        if (note != null) _buildDetailRow('Note', note, context),
      ],
    );
  }
}

/// Dialog to show calendar event details
class CalendarDetailDialog extends StatelessWidget {
  final DetectedContent content;

  const CalendarDetailDialog({super.key, required this.content});

  @override
  Widget build(BuildContext context) {
    final summary = content.getField('summary');
    final start = content.getField('start');
    final end = content.getField('end');
    final location = content.getField('location');
    final description = content.getField('description');

    return _buildDialog(
      context,
      title: 'Event',
      icon: Icons.event,
      children: [
        if (summary != null) _buildDetailRow('Summary', summary, context),
        if (start != null) _buildDetailRow('Start', start, context),
        if (end != null) _buildDetailRow('End', end, context),
        if (location != null) _buildDetailRow('Location', location, context),
        if (description != null)
          _buildDetailRow('Description', description, context),
      ],
    );
  }
}

// ===== Helper Methods =====

Widget _buildDialog(
  BuildContext context, {
  required String title,
  required IconData icon,
  required List<Widget> children,
}) {
  return Dialog(
    backgroundColor: Colors.transparent,
    child: ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
        child: Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: const Color(0xFF1F1F1F).withValues(alpha: 0.95),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: Colors.white.withValues(alpha: 0.1),
              width: 1,
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Header
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xFF8B5CF6), Color(0xFFD946EF)],
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(icon, color: Colors.white, size: 24),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Text(
                      title,
                      style: GoogleFonts.inter(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: const Icon(Icons.close, color: Colors.white),
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // Content
              ...children,

              const SizedBox(height: 16),

              // Close button
              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  onPressed: () => Navigator.of(context).pop(),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white.withValues(alpha: 0.1),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(
                    'Close',
                    style: GoogleFonts.inter(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

Widget _buildDetailRow(String label, String value, BuildContext context) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.inter(
            fontSize: 12,
            color: Colors.white.withValues(alpha: 0.6),
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 6),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.05),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: Colors.white.withValues(alpha: 0.1),
              width: 1,
            ),
          ),
          child: SelectableText(
            value,
            style: GoogleFonts.inter(fontSize: 14, color: Colors.white),
          ),
        ),
      ],
    ),
  );
}

Widget _buildPasswordRow(String password, BuildContext context) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Password',
          style: GoogleFonts.inter(
            fontSize: 12,
            color: Colors.white.withValues(alpha: 0.6),
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 6),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.05),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: Colors.white.withValues(alpha: 0.1),
              width: 1,
            ),
          ),
          child: Row(
            children: [
              Expanded(
                child: SelectableText(
                  password,
                  style: GoogleFonts.inter(fontSize: 14, color: Colors.white),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.copy, size: 18),
                color: const Color(0xFF8B5CF6),
                onPressed: () {
                  Clipboard.setData(ClipboardData(text: password));
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        'Password copied',
                        style: GoogleFonts.inter(),
                      ),
                      backgroundColor: const Color(0xFF10B981),
                      behavior: SnackBarBehavior.floating,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      duration: const Duration(seconds: 1),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
