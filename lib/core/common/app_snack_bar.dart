import 'dart:async';

import 'package:cookjar/core/utils/colors/app_colors.dart';
import 'package:flutter/material.dart';

/// Available SnackBar message types.
/// Each type controls the color and icon.
enum SnackBarType { success, error, warning, info }

/// AppSnackBar
///
/// Utility class for showing styled SnackBars consistently
/// across the application.
class AppSnackBar {
  AppSnackBar._(); // Private constructor to prevent instantiation

  ///* Shows a SnackBar with a given message and type.
  ///
  /// - [context]: Required BuildContext
  /// - [text]: Message to display
  /// - [type]: Visual style (default: success)
  /// - [duration]: Display duration

  static Future<void> show(
    BuildContext context,
    String text, {
    SnackBarType type = SnackBarType.success,
    Duration duration = const Duration(seconds: 2),
  }) {
    Color color;
    IconData icon;

    ///* Resolve style based on SnackBar type
    switch (type) {
      case SnackBarType.error:
        color = AppColors.error;
        icon = Icons.error_outline;
        break;
      case SnackBarType.warning:
        color = AppColors.warning;
        icon = Icons.warning_amber_rounded;
        break;
      case SnackBarType.info:
        color = AppColors.info;
        icon = Icons.info_outline;
        break;
      case SnackBarType.success:
        color = AppColors.success;
        icon = Icons.check_circle_outline;
        break;
    }

    final overlay = Overlay.of(context);

    final completer = Completer<void>();

    late OverlayEntry entry;

    entry = OverlayEntry(
      builder: (ctx) {
        return Positioned(
          left: 16,
          right: 16,
          bottom: 12 + MediaQuery.of(ctx).viewInsets.bottom,
          child: TweenAnimationBuilder<double>(
            tween: Tween(begin: 0.0, end: 1.0),
            duration: const Duration(milliseconds: 240),
            builder: (context, value, child) {
              return Opacity(
                opacity: value,
                child: Transform.translate(
                  offset: Offset(0, (1 - value) * 8),
                  child: child,
                ),
              );
            },
            child: Material(
              color: Colors.transparent,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 14,
                ),
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    Icon(icon, color: Colors.white),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        text,
                        style: Theme.of(
                          context,
                        ).textTheme.bodyMedium?.copyWith(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );

    // insert and schedule removal
    overlay.insert(entry);

    Future.delayed(duration, () async {
      entry.remove();
      if (!completer.isCompleted) completer.complete();
    });

    return completer.future;
  }

  ///* Shows a success SnackBar
  static Future<void> success(
    BuildContext context,
    String message, {
    Duration duration = const Duration(seconds: 2),
  }) => show(context, message, type: SnackBarType.success, duration: duration);

  ///* Shows an error SnackBar
  static Future<void> error(
    BuildContext context,
    String message, {
    Duration duration = const Duration(seconds: 4),
  }) => show(context, message, type: SnackBarType.error, duration: duration);

  ///* Shows a warning SnackBar
  static Future<void> warning(
    BuildContext context,
    String message, {
    Duration duration = const Duration(seconds: 2),
  }) => show(context, message, type: SnackBarType.warning, duration: duration);

  ///* Shows an info SnackBar
  static Future<void> info(
    BuildContext context,
    String message, {
    Duration duration = const Duration(seconds: 2),
  }) => show(context, message, type: SnackBarType.info, duration: duration);
}

/*
Usage:

AppSnackBar.success(context, "your Success message");
AppSnackBar.error(context, "your Error message");
AppSnackBar.warning(context, "your Warning message");
AppSnackBar.info(context, "your Info message");

OR

AppSnackBar.show(context, "Custom message", type: SnackBarType.info);
*/
