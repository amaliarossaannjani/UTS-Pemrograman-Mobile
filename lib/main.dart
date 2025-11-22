import 'package:flutter/material.dart';
import 'dashboard.dart';
import 'app_theme.dart';
import 'theme_controller.dart';
import 'makanan_minuman.dart';
import 'elektronik.dart';
import 'fashion.dart';
import 'toys.dart';
import 'jawaban no4.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: ThemeController.themeNotifier,
      builder: (_, themeMode, __) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: themeMode,
          home: Dashboard(),
        );
      },
    );
  }
}
