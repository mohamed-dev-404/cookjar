import 'package:flutter/material.dart';
import 'package:cookjar/core/utils/assets/app_images.dart';

/// ─────────────────────────────────────────────────────────────────────────────
/// [AppScaffold] — A drop-in replacement for [Scaffold] that automatically
/// applies [AppImages.bg] as the full-screen background image.
///
/// **Why use it?**
/// Instead of wrapping every Scaffold body in a [DecoratedBox] with the bg
/// image, simply use [AppScaffold] and the background is handled for you.
///
/// **Usage — exactly like a normal Scaffold:**
///
/// ```dart
///? Basic usage:
/// AppScaffold(
///   appBar: AppBar(title: Text('Home')),
///   body: Center(child: Text('Hello')),
/// )
///
///? With bottom nav, FAB, drawer — everything works:
/// AppScaffold(
///   appBar: AppBar(title: Text('Dashboard')),
///   body: MyContent(),
///   bottomNavigationBar: MyBottomNav(),
///   floatingActionButton: FloatingActionButton(onPressed: () {}),
///   drawer: MyDrawer(),
/// )
///
///? Disable the background image (rare cases):
/// AppScaffold(
///   showBackground: false,
///   body: MyContent(),
/// )
/// ```
/// ─────────────────────────────────────────────────────────────────────────────
class AppScaffold extends StatelessWidget {
  const AppScaffold({
    super.key,
    this.appBar,
    this.body,
    this.bottomNavigationBar,
    this.floatingActionButton,
    this.floatingActionButtonLocation,
    this.drawer,
    this.endDrawer,
    this.bottomSheet,
    this.backgroundColor,
    this.resizeToAvoidBottomInset,
    this.extendBody = false,
    this.extendBodyBehindAppBar = false,
    this.showBackground = true,
  });

  /// Standard [Scaffold] properties — passed through directly.
  final PreferredSizeWidget? appBar;
  final Widget? body;
  final Widget? bottomNavigationBar;
  final Widget? floatingActionButton;
  final FloatingActionButtonLocation? floatingActionButtonLocation;
  final Widget? drawer;
  final Widget? endDrawer;
  final Widget? bottomSheet;
  final Color? backgroundColor;
  final bool? resizeToAvoidBottomInset;
  final bool extendBody;
  final bool extendBodyBehindAppBar;

  /// Set to `false` to disable the [AppImages.bg] background image.
  /// Defaults to `true`.
  final bool showBackground;

  @override
  Widget build(BuildContext context) {
    // When background is disabled, render a plain Scaffold.
    if (!showBackground) {
      return Scaffold(
        appBar: appBar,
        body: body,
        bottomNavigationBar: bottomNavigationBar,
        floatingActionButton: floatingActionButton,
        floatingActionButtonLocation: floatingActionButtonLocation,
        drawer: drawer,
        endDrawer: endDrawer,
        bottomSheet: bottomSheet,
        backgroundColor: backgroundColor,
        resizeToAvoidBottomInset: resizeToAvoidBottomInset,
        extendBody: extendBody,
        extendBodyBehindAppBar: extendBodyBehindAppBar,
      );
    }

    return Stack(
      children: [
        // 1. Ensure there is a base color behind the image if it has transparency.
        Positioned.fill(
          child: ColoredBox(
            color: backgroundColor ?? Theme.of(context).scaffoldBackgroundColor,
          ),
        ),

        // 2. The background image managed by Image.asset for reliable loading.
        if (showBackground)
          Positioned.fill(child: Image.asset(AppImages.bg, fit: BoxFit.cover)),

        // 3. The actual Scaffold on top with transparent background.
        Positioned.fill(
          child: Scaffold(
            backgroundColor: Colors.transparent,
            appBar: appBar,
            body: body,
            bottomNavigationBar:
                bottomNavigationBar, // Render natively to clip body above it
            floatingActionButton: floatingActionButton,
            floatingActionButtonLocation: floatingActionButtonLocation,
            drawer: drawer,
            endDrawer: endDrawer,
            bottomSheet: bottomSheet,
            resizeToAvoidBottomInset: resizeToAvoidBottomInset,
            extendBody: extendBody, // Respect original extendBody behavior
            extendBodyBehindAppBar: extendBodyBehindAppBar,
          ),
        ),
      ],
    );
  }
}
