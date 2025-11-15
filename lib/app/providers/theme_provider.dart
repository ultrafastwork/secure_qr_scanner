import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';

/// Notifier for managing theme mode state with persistence
class ThemeNotifier extends Notifier<ThemeMode> {
  @override
  ThemeMode build() {
    _loadTheme();
    return ThemeMode.dark; // Default theme
  }

  /// Load saved theme preference from Hive storage
  Future<void> _loadTheme() async {
    try {
      final box = await Hive.openBox('settings');
      final savedMode = box.get('theme_mode', defaultValue: 'dark') as String;

      // Parse saved theme mode
      switch (savedMode) {
        case 'light':
          state = ThemeMode.light;
          break;
        case 'dark':
          state = ThemeMode.dark;
          break;
        case 'system':
          state = ThemeMode.system;
          break;
        default:
          state = ThemeMode.dark;
      }
    } catch (e) {
      // Default to dark mode if loading fails
      state = ThemeMode.dark;
    }
  }

  /// Set theme mode and persist to storage
  Future<void> setTheme(ThemeMode mode) async {
    state = mode;

    try {
      final box = await Hive.openBox('settings');
      await box.put('theme_mode', mode.name);
    } catch (e) {
      // Silently fail - theme will still work for current session
    }
  }
}

/// Provider for theme mode state
final themeProvider = NotifierProvider<ThemeNotifier, ThemeMode>(
  ThemeNotifier.new,
);
