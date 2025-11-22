import 'package:flutter/material.dart';

class ThemeController {
  // Notifier global untuk menyimpan mode saat ini
  static final ValueNotifier<ThemeMode> themeNotifier = ValueNotifier(
    ThemeMode.light,
  );

  // === Fungsi untuk toggle dark ↔ light ===
  static void toggleTheme() {
    themeNotifier.value = themeNotifier.value == ThemeMode.light
        ? ThemeMode.dark
        : ThemeMode.light;
  }
}
