import 'dart:io';

import 'package:cookjar/core/routes/app_router.dart';
import 'package:flutter/material.dart';
import 'package:cookjar/core/utils/themes/app_themes.dart';

class CookJar extends StatelessWidget {
  const CookJar({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: AppRouter.router,
      theme: AppThemes.lightTheme,
      themeMode: ThemeMode.light,
      builder: (context, child) {
        return MediaQuery(
          data: MediaQuery.of(
            context,
          ).copyWith(textScaler: const TextScaler.linear(1.0)),
          child: SafeArea(
            top: false,
            bottom: Platform.isAndroid,
            child: child!,
          ),
        );
      },
    );
  }
}
