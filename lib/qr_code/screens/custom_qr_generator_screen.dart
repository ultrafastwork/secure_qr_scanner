import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gal/gal.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';
import 'package:secure_qr_scanner/qr_code/dto/qr_customization.dart';
import 'package:secure_qr_scanner/qr_code/providers/qr_customization_provider.dart';
import 'package:secure_qr_scanner/qr_code/utils/qr_button_builders.dart';
import 'package:secure_qr_scanner/qr_code/widgets/qr_customization_widgets.dart';
import 'package:share_plus/share_plus.dart';

/// Custom QR Code Generator screen with appearance customization
class CustomQrGeneratorScreen extends ConsumerStatefulWidget {
  const CustomQrGeneratorScreen({super.key});

  @override
  ConsumerState<CustomQrGeneratorScreen> createState() =>
      _CustomQrGeneratorScreenState();
}

class _CustomQrGeneratorScreenState
    extends ConsumerState<CustomQrGeneratorScreen> {
  final TextEditingController _textController = TextEditingController();
  final GlobalKey _qrKey = GlobalKey();
  QrCode? _qrCode;
  QrImage? _qrImage;
  bool _hasGenerated = false;
  File? _logoFile;

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final customizationState = ref.watch(qrCustomizationProvider);

    return Scaffold(
      backgroundColor: isDark ? Colors.black : const Color(0xFFFAFAFA),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: isDark
                ? const [
                    Color(0xFF7C3AED),
                    Color(0xFFC026D3),
                    Color(0xFF7E22CE),
                  ]
                : const [
                    Color(0xFFE9D5FF),
                    Color(0xFFFAE8FF),
                    Color(0xFFDDD6FE),
                  ],
          ),
        ),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 40, sigmaY: 40),
          child: Container(
            color: isDark
                ? Colors.black.withValues(alpha: 0.8)
                : Colors.white.withValues(alpha: 0.7),
            child: SafeArea(
              child: Column(
                children: [
                  _buildTopBar(isDark),
                  Expanded(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        children: [
                          const SizedBox(height: 20),
                          _buildInputSection(isDark),
                          const SizedBox(height: 32),
                          _hasGenerated
                              ? _buildQRDisplay(isDark, customizationState)
                              : _buildPlaceholder(isDark),
                          if (_hasGenerated) ...[
                            const SizedBox(height: 32),
                            _buildCustomizationControls(
                              isDark,
                              customizationState,
                            ),
                            const SizedBox(height: 32),
                            _buildActions(isDark),
                          ],
                          const SizedBox(height: 20),
                        ],
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

  Widget _buildTopBar(bool isDark) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Row(
        children: [
          buildGlassButton(
            onTap: () => Navigator.pop(context),
            isDark: isDark,
            child: Icon(
              Icons.arrow_back,
              color: isDark ? Colors.white : const Color(0xFF1F1F1F),
              size: 20,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              'Custom QR Generator',
              style: GoogleFonts.inter(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: isDark ? Colors.white : const Color(0xFF1F1F1F),
              ),
            ),
          ),
          if (_hasGenerated)
            buildGlassButton(
              onTap: () => setState(() {
                _textController.clear();
                _qrCode = null;
                _qrImage = null;
                _hasGenerated = false;
                _logoFile = null;
              }),
              isDark: isDark,
              child: Icon(
                Icons.refresh,
                color: isDark ? Colors.white : const Color(0xFF1F1F1F),
                size: 20,
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildInputSection(bool isDark) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: isDark
                ? Colors.white.withValues(alpha: 0.05)
                : Colors.white.withValues(alpha: 0.8),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: (isDark ? Colors.white : Colors.black).withValues(
                alpha: 0.1,
              ),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Enter Text or URL',
                style: GoogleFonts.inter(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: (isDark ? Colors.white : Colors.black).withValues(
                    alpha: 0.8,
                  ),
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: _textController,
                maxLines: 4,
                style: GoogleFonts.inter(
                  fontSize: 16,
                  color: isDark ? Colors.white : const Color(0xFF1F1F1F),
                ),
                decoration: InputDecoration(
                  hintText: 'e.g., https://example.com',
                  hintStyle: GoogleFonts.inter(
                    color: (isDark ? Colors.white : Colors.black).withValues(
                      alpha: 0.6,
                    ),
                  ),
                  filled: true,
                  fillColor: Colors.black.withValues(
                    alpha: isDark ? 0.3 : 0.05,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(
                      color: Color(0xFF8B5CF6),
                      width: 2,
                    ),
                  ),
                ),
                onSubmitted: (_) => _generate(),
              ),
              const SizedBox(height: 16),
              buildPrimaryButton(
                onTap: _generate,
                icon: Icons.qr_code_2,
                label: _hasGenerated ? 'Regenerate' : 'Generate QR Code',
                isDark: isDark,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildQRDisplay(bool isDark, QrCustomizationState state) {
    final custom = state.currentCustomization;
    return RepaintBoundary(
      key: _qrKey,
      child: Container(
        width: 280,
        height: 280,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: custom.backgroundColor,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: custom.foregroundColor.withValues(alpha: 0.5),
              blurRadius: 24,
            ),
          ],
        ),
        child: _qrImage != null
            ? Stack(
                children: [
                  PrettyQrView(
                    qrImage: _qrImage!,
                    decoration: PrettyQrDecoration(
                      shape: PrettyQrSmoothSymbol(
                        color: custom.foregroundColor,
                        roundFactor: custom.shapeStyle == QrShapeStyle.square
                            ? 0.0
                            : 1.0,
                      ),
                    ),
                  ),
                  if (_logoFile != null)
                    Center(
                      child: Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          color: custom.backgroundColor,
                          shape: BoxShape.circle,
                        ),
                        child: ClipOval(
                          child: Image.file(_logoFile!, fit: BoxFit.cover),
                        ),
                      ),
                    ),
                ],
              )
            : const Center(child: CircularProgressIndicator()),
      ),
    );
  }

  Widget _buildPlaceholder(bool isDark) {
    return Container(
      width: 280,
      height: 280,
      decoration: BoxDecoration(
        color: isDark
            ? Colors.white.withValues(alpha: 0.05)
            : Colors.white.withValues(alpha: 0.8),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: (isDark ? Colors.white : Colors.black).withValues(alpha: 0.1),
          width: 2,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.qr_code_2_outlined,
            size: 80,
            color: (isDark ? Colors.white : Colors.black).withValues(
              alpha: 0.2,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'QR code preview',
            style: GoogleFonts.inter(
              fontSize: 14,
              color: (isDark ? Colors.white : Colors.black).withValues(
                alpha: 0.6,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCustomizationControls(bool isDark, QrCustomizationState state) {
    final custom = state.currentCustomization;
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: isDark
                ? Colors.white.withValues(alpha: 0.05)
                : Colors.white.withValues(alpha: 0.8),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: (isDark ? Colors.white : Colors.black).withValues(
                alpha: 0.1,
              ),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Customize',
                    style: GoogleFonts.inter(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: isDark ? Colors.white : const Color(0xFF1F1F1F),
                    ),
                  ),
                  TextButton.icon(
                    onPressed: () {
                      ref
                          .read(qrCustomizationProvider.notifier)
                          .resetToDefault();
                      setState(() => _logoFile = null);
                      _showSnack('Reset to default');
                    },
                    icon: const Icon(Icons.restart_alt, size: 18),
                    label: Text('Reset', style: GoogleFonts.inter()),
                    style: TextButton.styleFrom(
                      foregroundColor: const Color(0xFF8B5CF6),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              QrColorPicker(
                label: 'Foreground',
                color: custom.foregroundColor,
                onColorChanged: (c) {
                  ref
                      .read(qrCustomizationProvider.notifier)
                      .updateCustomization(custom.copyWith(foregroundColor: c));
                  _generate();
                },
                isDark: isDark,
              ),
              const SizedBox(height: 16),
              QrColorPicker(
                label: 'Background',
                color: custom.backgroundColor,
                onColorChanged: (c) {
                  ref
                      .read(qrCustomizationProvider.notifier)
                      .updateCustomization(custom.copyWith(backgroundColor: c));
                  _generate();
                },
                isDark: isDark,
              ),
              const SizedBox(height: 20),
              QrShapeSelector(
                selectedStyle: custom.shapeStyle,
                onStyleChanged: (s) {
                  ref
                      .read(qrCustomizationProvider.notifier)
                      .updateCustomization(custom.copyWith(shapeStyle: s));
                  _generate();
                },
                isDark: isDark,
              ),
              const SizedBox(height: 20),
              QrLogoSection(
                logoFile: _logoFile,
                onPickLogo: _pickLogo,
                onRemoveLogo: () => setState(() => _logoFile = null),
                isDark: isDark,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildActions(bool isDark) {
    return Column(
      children: [
        buildPrimaryButton(
          onTap: () async {
            await Clipboard.setData(ClipboardData(text: _textController.text));
            _showSnack('Copied');
          },
          icon: Icons.content_copy,
          label: 'Copy Text',
          isDark: isDark,
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: buildSecondaryButton(
                onTap: _share,
                icon: Icons.share,
                label: 'Share',
                isDark: isDark,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: buildSecondaryButton(
                onTap: _save,
                icon: Icons.download,
                label: 'Save',
                isDark: isDark,
              ),
            ),
          ],
        ),
      ],
    );
  }

  void _generate() {
    if (_textController.text.trim().isEmpty) {
      _showSnack('Enter text', isError: true);
      return;
    }
    setState(() {
      _qrCode = QrCode.fromData(
        data: _textController.text.trim(),
        errorCorrectLevel: QrErrorCorrectLevel.H,
      );
      _qrImage = QrImage(_qrCode!);
      _hasGenerated = true;
    });
    FocusScope.of(context).unfocus();
  }

  Future<void> _pickLogo() async {
    try {
      final img = await ImagePicker().pickImage(
        source: ImageSource.gallery,
        maxWidth: 512,
        maxHeight: 512,
      );
      if (img != null) {
        setState(() => _logoFile = File(img.path));
        _showSnack('Logo selected');
      }
    } catch (e) {
      _showSnack('Failed to pick logo', isError: true);
    }
  }

  Future<void> _share() async {
    try {
      await SharePlus.instance.share(
        ShareParams(text: _textController.text.trim()),
      );
    } catch (e) {
      _showSnack('Failed to share', isError: true);
    }
  }

  Future<void> _save() async {
    if (_qrImage == null) return;
    try {
      if (!await Gal.hasAccess() && !await Gal.requestAccess()) {
        _showSnack('Permission denied', isError: true);
        return;
      }
      final boundary =
          _qrKey.currentContext?.findRenderObject() as RenderRepaintBoundary?;
      if (boundary == null) return;

      final image = await boundary.toImage(pixelRatio: 3.0);
      final bytes = await image.toByteData(format: ImageByteFormat.png);
      if (bytes == null) return;

      final temp = await getTemporaryDirectory();
      final file = File(
        '${temp.path}/qr_${DateTime.now().millisecondsSinceEpoch}.png',
      );
      await file.writeAsBytes(bytes.buffer.asUint8List());
      await Gal.putImage(file.path);
      await file.delete();
      if (mounted) _showSnack('Saved to gallery');
    } catch (e) {
      _showSnack('Failed to save', isError: true);
    }
  }

  void _showSnack(String msg, {bool isError = false}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(msg, style: GoogleFonts.inter()),
        backgroundColor: isError
            ? const Color(0xFFEF4444)
            : const Color(0xFF8B5CF6),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }
}
