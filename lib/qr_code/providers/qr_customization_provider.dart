import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';
import 'package:secure_qr_scanner/qr_code/dto/qr_customization.dart';

/// State for QR customization
class QrCustomizationState {
  final QrCustomization currentCustomization;
  final List<QrPreset> presets;

  QrCustomizationState({
    required this.currentCustomization,
    required this.presets,
  });

  QrCustomizationState copyWith({
    QrCustomization? currentCustomization,
    List<QrPreset>? presets,
  }) {
    return QrCustomizationState(
      currentCustomization: currentCustomization ?? this.currentCustomization,
      presets: presets ?? this.presets,
    );
  }
}

/// Notifier for managing QR customization state with persistence
class QrCustomizationNotifier extends Notifier<QrCustomizationState> {
  @override
  QrCustomizationState build() {
    _loadCustomization();
    return QrCustomizationState(
      currentCustomization: QrCustomization.defaultCustomization,
      presets: [],
    );
  }

  /// Load saved customization and presets from Hive
  Future<void> _loadCustomization() async {
    try {
      final box = await Hive.openBox('qr_customization');

      // Load current customization
      final customizationMap = box.get('current_customization');
      QrCustomization currentCustomization =
          QrCustomization.defaultCustomization;
      if (customizationMap != null) {
        currentCustomization = QrCustomization.fromMap(
          Map<String, dynamic>.from(customizationMap as Map),
        );
      }

      // Load presets
      final presetsJson = box.get('presets', defaultValue: '[]') as String;
      final List<dynamic> presetsData = jsonDecode(presetsJson);
      final presets = presetsData
          .map(
            (data) => QrPreset.fromMap(Map<String, dynamic>.from(data as Map)),
          )
          .toList();

      state = QrCustomizationState(
        currentCustomization: currentCustomization,
        presets: presets,
      );
    } catch (e) {
      // Default state on error
      state = QrCustomizationState(
        currentCustomization: QrCustomization.defaultCustomization,
        presets: [],
      );
    }
  }

  /// Update current customization
  Future<void> updateCustomization(QrCustomization customization) async {
    state = state.copyWith(currentCustomization: customization);

    try {
      final box = await Hive.openBox('qr_customization');
      await box.put('current_customization', customization.toMap());
    } catch (e) {
      // Silently fail - customization will still work for current session
    }
  }

  /// Reset to default customization
  Future<void> resetToDefault() async {
    await updateCustomization(QrCustomization.defaultCustomization);
  }

  /// Save current customization as a preset
  Future<void> saveAsPreset(String name) async {
    final preset = QrPreset(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      name: name,
      customization: state.currentCustomization,
      createdAt: DateTime.now(),
    );

    final updatedPresets = [...state.presets, preset];
    state = state.copyWith(presets: updatedPresets);

    try {
      final box = await Hive.openBox('qr_customization');
      final presetsJson = jsonEncode(
        updatedPresets.map((p) => p.toMap()).toList(),
      );
      await box.put('presets', presetsJson);
    } catch (e) {
      // Silently fail
    }
  }

  /// Load a preset
  Future<void> loadPreset(QrPreset preset) async {
    await updateCustomization(preset.customization);
  }

  /// Delete a preset
  Future<void> deletePreset(String presetId) async {
    final updatedPresets = state.presets
        .where((p) => p.id != presetId)
        .toList();
    state = state.copyWith(presets: updatedPresets);

    try {
      final box = await Hive.openBox('qr_customization');
      final presetsJson = jsonEncode(
        updatedPresets.map((p) => p.toMap()).toList(),
      );
      await box.put('presets', presetsJson);
    } catch (e) {
      // Silently fail
    }
  }
}

/// Provider for QR customization state
final qrCustomizationProvider =
    NotifierProvider<QrCustomizationNotifier, QrCustomizationState>(
      QrCustomizationNotifier.new,
    );
