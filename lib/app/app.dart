import 'dart:io';
import 'package:cookjar/core/routes/app_router.dart';
import 'package:cookjar/core/utils/themes/app_themes.dart';
import 'package:flutter/foundation.dart'; // 1. Add foundation import
import 'package:flutter/material.dart';

class CookJar extends StatelessWidget {
  const CookJar({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: AppRouter.router,
      theme: AppTheme.lightTheme,
      themeMode: ThemeMode.light,
      builder: (context, child) {
        return MediaQuery(
          data: MediaQuery.of(
            context,
          ).copyWith(textScaler: const TextScaler.linear(1.0)),
          child: SafeArea(
            top: false,
            // 2. Check kIsWeb first to avoid throwing UnsupportedError on Web platform
            bottom: !kIsWeb && Platform.isAndroid,
            child: child!,
          ),
        );
      },
    );
  }
}