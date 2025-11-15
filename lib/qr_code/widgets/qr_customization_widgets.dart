import 'dart:io';

import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:secure_qr_scanner/qr_code/dto/qr_customization.dart';

/// Color picker widget for QR customization
class QrColorPicker extends StatelessWidget {
  final String label;
  final Color color;
  final ValueChanged<Color> onColorChanged;
  final bool isDark;

  const QrColorPicker({
    required this.label,
    required this.color,
    required this.onColorChanged,
    required this.isDark,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.inter(
            fontSize: 14,
            color: isDark
                ? Colors.white.withValues(alpha: 0.8)
                : Colors.black.withValues(alpha: 0.8),
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 8),
        InkWell(
          onTap: () => _showColorPickerDialog(context),
          borderRadius: BorderRadius.circular(12),
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: isDark
                  ? Colors.black.withValues(alpha: 0.3)
                  : Colors.black.withValues(alpha: 0.05),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: isDark
                    ? Colors.white.withValues(alpha: 0.1)
                    : Colors.black.withValues(alpha: 0.1),
              ),
            ),
            child: Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: color,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: isDark ? Colors.white : Colors.black,
                      width: 1,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    '#${color.toARGB32().toRadixString(16).substring(2).toUpperCase()}',
                    style: GoogleFonts.inter(
                      fontSize: 14,
                      color: isDark ? Colors.white : const Color(0xFF1F1F1F),
                    ),
                  ),
                ),
                Icon(
                  Icons.edit,
                  size: 20,
                  color: isDark
                      ? Colors.white.withValues(alpha: 0.6)
                      : Colors.black.withValues(alpha: 0.6),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Future<void> _showColorPickerDialog(BuildContext context) async {
    Color pickedColor = color;
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: isDark ? const Color(0xFF1F1F1F) : Colors.white,
        title: Text(
          'Pick a color',
          style: GoogleFonts.inter(
            color: isDark ? Colors.white : const Color(0xFF1F1F1F),
          ),
        ),
        content: SingleChildScrollView(
          child: ColorPicker(
            color: color,
            onColorChanged: (newColor) => pickedColor = newColor,
            width: 40,
            height: 40,
            borderRadius: 8,
            enableShadesSelection: true,
            pickersEnabled: const {
              ColorPickerType.primary: true,
              ColorPickerType.accent: true,
              ColorPickerType.wheel: true,
            },
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'Cancel',
              style: GoogleFonts.inter(
                color: isDark
                    ? Colors.white.withValues(alpha: 0.7)
                    : Colors.black.withValues(alpha: 0.7),
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              onColorChanged(pickedColor);
              Navigator.pop(context);
            },
            child: Text(
              'Select',
              style: GoogleFonts.inter(color: const Color(0xFF8B5CF6)),
            ),
          ),
        ],
      ),
    );
  }
}

/// Shape style selector for QR customization
class QrShapeSelector extends StatelessWidget {
  final QrShapeStyle selectedStyle;
  final ValueChanged<QrShapeStyle> onStyleChanged;
  final bool isDark;

  const QrShapeSelector({
    required this.selectedStyle,
    required this.onStyleChanged,
    required this.isDark,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: QrShapeStyle.values.map((style) {
        final isSelected = style == selectedStyle;
        return Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: InkWell(
              onTap: () => onStyleChanged(style),
              borderRadius: BorderRadius.circular(12),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                  color: isSelected
                      ? const Color(0xFF8B5CF6).withValues(alpha: 0.2)
                      : isDark
                      ? Colors.black.withValues(alpha: 0.3)
                      : Colors.black.withValues(alpha: 0.05),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: isSelected
                        ? const Color(0xFF8B5CF6)
                        : isDark
                        ? Colors.white.withValues(alpha: 0.1)
                        : Colors.black.withValues(alpha: 0.1),
                    width: isSelected ? 2 : 1,
                  ),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      style.icon,
                      color: isSelected
                          ? const Color(0xFF8B5CF6)
                          : isDark
                          ? Colors.white.withValues(alpha: 0.7)
                          : Colors.black.withValues(alpha: 0.7),
                      size: 24,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      style.displayName,
                      style: GoogleFonts.inter(
                        fontSize: 11,
                        color: isSelected
                            ? const Color(0xFF8B5CF6)
                            : isDark
                            ? Colors.white.withValues(alpha: 0.7)
                            : Colors.black.withValues(alpha: 0.7),
                        fontWeight: isSelected
                            ? FontWeight.w600
                            : FontWeight.normal,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}

/// Logo section widget
class QrLogoSection extends StatelessWidget {
  final File? logoFile;
  final VoidCallback onPickLogo;
  final VoidCallback onRemoveLogo;
  final bool isDark;

  const QrLogoSection({
    required this.logoFile,
    required this.onPickLogo,
    required this.onRemoveLogo,
    required this.isDark,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Logo (Optional)',
          style: GoogleFonts.inter(
            fontSize: 14,
            color: isDark
                ? Colors.white.withValues(alpha: 0.8)
                : Colors.black.withValues(alpha: 0.8),
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 8),
        if (logoFile != null) ...[
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: isDark
                  ? Colors.black.withValues(alpha: 0.3)
                  : Colors.black.withValues(alpha: 0.05),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: isDark
                    ? Colors.white.withValues(alpha: 0.1)
                    : Colors.black.withValues(alpha: 0.1),
              ),
            ),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.file(
                    logoFile!,
                    width: 60,
                    height: 60,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    'Logo selected',
                    style: GoogleFonts.inter(
                      fontSize: 14,
                      color: isDark ? Colors.white : const Color(0xFF1F1F1F),
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.close, size: 20),
                  onPressed: onRemoveLogo,
                  color: isDark
                      ? Colors.white.withValues(alpha: 0.7)
                      : Colors.black.withValues(alpha: 0.7),
                ),
              ],
            ),
          ),
        ] else ...[
          InkWell(
            onTap: onPickLogo,
            borderRadius: BorderRadius.circular(12),
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: isDark
                    ? Colors.black.withValues(alpha: 0.3)
                    : Colors.black.withValues(alpha: 0.05),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: isDark
                      ? Colors.white.withValues(alpha: 0.1)
                      : Colors.black.withValues(alpha: 0.1),
                  style: BorderStyle.solid,
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.add_photo_alternate,
                    color: isDark
                        ? Colors.white.withValues(alpha: 0.6)
                        : Colors.black.withValues(alpha: 0.6),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'Add Logo',
                    style: GoogleFonts.inter(
                      fontSize: 14,
                      color: isDark
                          ? Colors.white.withValues(alpha: 0.8)
                          : Colors.black.withValues(alpha: 0.8),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ],
    );
  }
}
