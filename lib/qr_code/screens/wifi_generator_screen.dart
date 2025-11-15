import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:gal/gal.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';
import 'package:share_plus/share_plus.dart';

/// Wi-Fi QR Code Generator screen
class WifiGeneratorScreen extends StatefulWidget {
  const WifiGeneratorScreen({super.key});

  @override
  State<WifiGeneratorScreen> createState() => _WifiGeneratorScreenState();
}

class _WifiGeneratorScreenState extends State<WifiGeneratorScreen> {
  final TextEditingController _ssidController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey _qrKey = GlobalKey();

  String _securityType = 'WPA'; // WPA, WEP, nopass
  bool _isHidden = false;
  QrCode? _qrCode;
  QrImage? _qrImage;
  bool _hasGenerated = false;

  @override
  void dispose() {
    _ssidController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _generateWifiQR() {
    final ssid = _ssidController.text.trim();
    if (ssid.isEmpty) {
      _showError('Please enter network name (SSID)');
      return;
    }

    final password = _passwordController.text.trim();
    if (_securityType != 'nopass' && password.isEmpty) {
      _showError('Password required for secured networks');
      return;
    }

    // Build Wi-Fi QR format: WIFI:T:WPA;S:NetworkName;P:password;H:false;;
    final wifiString = _buildWifiString(
      ssid,
      password,
      _securityType,
      _isHidden,
    );

    setState(() {
      _qrCode = QrCode.fromData(
        data: wifiString,
        errorCorrectLevel: QrErrorCorrectLevel.H,
      );
      _qrImage = QrImage(_qrCode!);
      _hasGenerated = true;
    });

    // Hide keyboard after generation
    FocusScope.of(context).unfocus();
  }

  String _buildWifiString(
    String ssid,
    String password,
    String security,
    bool hidden,
  ) {
    final sb = StringBuffer('WIFI:');
    sb.write('T:$security;');
    sb.write('S:$ssid;');
    if (security != 'nopass' && password.isNotEmpty) {
      sb.write('P:$password;');
    }
    if (hidden) {
      sb.write('H:true;');
    }
    sb.write(';');
    return sb.toString();
  }

  void _clearInput() {
    setState(() {
      _ssidController.clear();
      _passwordController.clear();
      _securityType = 'WPA';
      _isHidden = false;
      _qrCode = null;
      _qrImage = null;
      _hasGenerated = false;
    });
  }

  Future<void> _copyWifiString() async {
    final wifiString = _buildWifiString(
      _ssidController.text.trim(),
      _passwordController.text.trim(),
      _securityType,
      _isHidden,
    );
    await Clipboard.setData(ClipboardData(text: wifiString));
    if (mounted) {
      _showSuccess('Wi-Fi data copied to clipboard');
    }
  }

  Future<void> _shareQR() async {
    final ssid = _ssidController.text.trim();
    if (ssid.isEmpty) {
      _showError('No content to share');
      return;
    }

    try {
      final wifiString = _buildWifiString(
        ssid,
        _passwordController.text.trim(),
        _securityType,
        _isHidden,
      );
      await SharePlus.instance.share(ShareParams(text: wifiString));
    } catch (e) {
      if (mounted) {
        _showError('Failed to share content');
      }
    }
  }

  Future<void> _saveQR() async {
    if (_qrImage == null) {
      _showError('No QR code to save');
      return;
    }

    try {
      // Check and request permission
      final hasAccess = await Gal.hasAccess();
      if (!hasAccess) {
        final granted = await Gal.requestAccess();
        if (!granted) {
          if (mounted) {
            _showError('Storage permission denied');
          }
          return;
        }
      }

      // Capture the QR code widget as image
      final boundary =
          _qrKey.currentContext?.findRenderObject() as RenderRepaintBoundary?;
      if (boundary == null) {
        if (mounted) {
          _showError('Failed to capture QR code');
        }
        return;
      }

      final image = await boundary.toImage(pixelRatio: 3.0);
      final byteData = await image.toByteData(format: ImageByteFormat.png);
      if (byteData == null) {
        if (mounted) {
          _showError('Failed to convert QR code');
        }
        return;
      }

      final pngBytes = byteData.buffer.asUint8List();

      // Save to temporary file
      final tempDir = await getTemporaryDirectory();
      final fileName = 'wifi_qr_${DateTime.now().millisecondsSinceEpoch}.png';
      final file = File('${tempDir.path}/$fileName');
      await file.writeAsBytes(pngBytes);

      // Save to gallery
      await Gal.putImage(file.path);

      // Clean up temp file
      await file.delete();

      if (mounted) {
        _showSuccess('Wi-Fi QR code saved to gallery');
      }
    } catch (e) {
      if (mounted) {
        _showError('Failed to save QR code');
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
      ),
    );
  }

  void _showSuccess(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message, style: GoogleFonts.inter()),
        backgroundColor: const Color(0xFF8B5CF6),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
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
                _buildTopBar(),
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        const SizedBox(height: 20),

                        // Input section
                        _buildInputSection(),

                        const SizedBox(height: 32),

                        // Generated QR display or placeholder
                        _hasGenerated ? _buildQRDisplay() : _buildPlaceholder(),

                        if (_hasGenerated) ...[
                          const SizedBox(height: 32),
                          _buildActionButtons(),
                        ],

                        const SizedBox(height: 20),
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

  Widget _buildTopBar() {
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
            'Wi-Fi QR Generator',
            style: GoogleFonts.inter(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const Spacer(),
          if (_hasGenerated)
            _buildGlassButton(
              onTap: _clearInput,
              child: const Icon(Icons.refresh, color: Colors.white, size: 20),
            ),
        ],
      ),
    );
  }

  Widget _buildInputSection() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
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
                'Network Details',
                style: GoogleFonts.inter(
                  fontSize: 14,
                  color: Colors.white.withValues(alpha: 0.8),
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 16),

              // SSID input
              _buildTextField(
                controller: _ssidController,
                label: 'Network Name (SSID)',
                hint: 'e.g., MyHomeWiFi',
                icon: Icons.wifi,
              ),

              const SizedBox(height: 16),

              // Security type dropdown
              _buildSecurityDropdown(),

              const SizedBox(height: 16),

              // Password input (only show if not open network)
              if (_securityType != 'nopass') ...[
                _buildTextField(
                  controller: _passwordController,
                  label: 'Password',
                  hint: 'Enter network password',
                  icon: Icons.lock,
                  obscureText: true,
                ),
                const SizedBox(height: 16),
              ],

              // Hidden network toggle
              _buildHiddenToggle(),

              const SizedBox(height: 20),

              // Generate button
              _buildPrimaryButton(
                onTap: _generateWifiQR,
                icon: Icons.wifi_tethering,
                label: _hasGenerated ? 'Regenerate' : 'Generate Wi-Fi QR',
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required IconData icon,
    bool obscureText = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.inter(
            fontSize: 12,
            color: Colors.white.withValues(alpha: 0.7),
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          obscureText: obscureText,
          style: GoogleFonts.inter(fontSize: 16, color: Colors.white),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: GoogleFonts.inter(
              color: Colors.white.withValues(alpha: 0.4),
            ),
            prefixIcon: Icon(
              icon,
              color: Colors.white.withValues(alpha: 0.6),
              size: 20,
            ),
            filled: true,
            fillColor: Colors.black.withValues(alpha: 0.3),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: Colors.white.withValues(alpha: 0.1),
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: Colors.white.withValues(alpha: 0.1),
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Color(0xFF8B5CF6), width: 2),
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 14,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSecurityDropdown() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Security Type',
          style: GoogleFonts.inter(
            fontSize: 12,
            color: Colors.white.withValues(alpha: 0.7),
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            color: Colors.black.withValues(alpha: 0.3),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
          ),
          child: DropdownButtonFormField<String>(
            initialValue: _securityType,
            dropdownColor: const Color(0xFF1F1F1F),
            decoration: InputDecoration(
              prefixIcon: Icon(
                Icons.security,
                color: Colors.white.withValues(alpha: 0.6),
                size: 20,
              ),
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 14,
              ),
            ),
            style: GoogleFonts.inter(fontSize: 16, color: Colors.white),
            items: [
              DropdownMenuItem(
                value: 'WPA',
                child: Text(
                  'WPA/WPA2',
                  style: GoogleFonts.inter(color: Colors.white),
                ),
              ),
              DropdownMenuItem(
                value: 'WEP',
                child: Text(
                  'WEP',
                  style: GoogleFonts.inter(color: Colors.white),
                ),
              ),
              DropdownMenuItem(
                value: 'nopass',
                child: Text(
                  'None (Open Network)',
                  style: GoogleFonts.inter(color: Colors.white),
                ),
              ),
            ],
            onChanged: (value) {
              setState(() {
                _securityType = value!;
              });
            },
          ),
        ),
      ],
    );
  }

  Widget _buildHiddenToggle() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.05),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
          ),
          child: Row(
            children: [
              Icon(
                Icons.visibility_off,
                color: Colors.white.withValues(alpha: 0.6),
                size: 20,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  'Hidden Network',
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    color: Colors.white.withValues(alpha: 0.8),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Switch(
                value: _isHidden,
                onChanged: (value) {
                  setState(() {
                    _isHidden = value;
                  });
                },
                activeThumbColor: const Color(0xFF8B5CF6),
                activeTrackColor: const Color(
                  0xFF8B5CF6,
                ).withValues(alpha: 0.5),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildQRDisplay() {
    return Column(
      children: [
        // QR code with glow effect
        Stack(
          alignment: Alignment.center,
          children: [
            // Glow layer
            Container(
              width: 280,
              height: 280,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24),
                gradient: const LinearGradient(
                  colors: [Color(0xFF8B5CF6), Color(0xFFD946EF)],
                ),
              ),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 30, sigmaY: 30),
                child: Container(color: Colors.transparent),
              ),
            ),

            // QR Code container
            RepaintBoundary(
              key: _qrKey,
              child: Container(
                width: 280,
                height: 280,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF8B5CF6).withValues(alpha: 0.5),
                      blurRadius: 24,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: _qrImage != null
                    ? PrettyQrView(
                        qrImage: _qrImage!,
                        decoration: const PrettyQrDecoration(
                          shape: PrettyQrSmoothSymbol(color: Colors.black),
                        ),
                      )
                    : const Center(
                        child: CircularProgressIndicator(
                          color: Color(0xFF8B5CF6),
                        ),
                      ),
              ),
            ),
          ],
        ),

        const SizedBox(height: 16),

        // Network info preview
        ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.check_circle,
                        color: const Color(0xFF10B981),
                        size: 16,
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          'SSID: ${_ssidController.text}',
                          style: GoogleFonts.inter(
                            fontSize: 12,
                            color: Colors.white.withValues(alpha: 0.8),
                            fontWeight: FontWeight.w500,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Icon(
                        Icons.security,
                        color: Colors.white.withValues(alpha: 0.6),
                        size: 16,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'Security: ${_securityType == 'nopass' ? 'Open' : _securityType}',
                        style: GoogleFonts.inter(
                          fontSize: 11,
                          color: Colors.white.withValues(alpha: 0.6),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPlaceholder() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(24),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          width: 280,
          height: 280,
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.05),
            borderRadius: BorderRadius.circular(24),
            border: Border.all(
              color: Colors.white.withValues(alpha: 0.1),
              width: 2,
              strokeAlign: BorderSide.strokeAlignInside,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.wifi_tethering,
                size: 80,
                color: Colors.white.withValues(alpha: 0.2),
              ),
              const SizedBox(height: 16),
              Text(
                'Wi-Fi QR code will appear here',
                style: GoogleFonts.inter(
                  fontSize: 14,
                  color: Colors.white.withValues(alpha: 0.6),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildActionButtons() {
    return Column(
      children: [
        // Primary action - Copy Wi-Fi string
        _buildPrimaryButton(
          onTap: _copyWifiString,
          icon: Icons.content_copy,
          label: 'Copy Wi-Fi Data',
        ),

        const SizedBox(height: 12),

        // Secondary actions
        Row(
          children: [
            Expanded(
              child: _buildSecondaryButton(
                onTap: _shareQR,
                icon: Icons.share,
                label: 'Share',
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _buildSecondaryButton(
                onTap: _saveQR,
                icon: Icons.download,
                label: 'Save',
              ),
            ),
          ],
        ),
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
}
