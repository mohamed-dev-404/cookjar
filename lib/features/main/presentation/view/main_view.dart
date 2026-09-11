import 'dart:ui' show ImageFilter;

import 'package:cookjar/core/utils/assets/app_icons.dart';
import 'package:cookjar/core/utils/colors/app_colors.dart';
import 'package:cookjar/core/utils/styles/app_styles.dart';
import 'package:cookjar/features/home/presentation/view/home_view.dart';
import 'package:cookjar/features/profile/presentation/view/profile_view.dart';
import 'package:cookjar/features/saved/presentation/view/saved_view.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class MainAppView extends StatefulWidget {
  const MainAppView({super.key});

  @override
  State<MainAppView> createState() => _MainAppViewState();
}

class _MainAppViewState extends State<MainAppView> {
  int currentIndex = 0;

  late final List<Widget> screens;

  @override
  void initState() {
    super.initState();

    screens = const [HomeView(), SavedView(), ProfileView()];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: currentIndex, children: screens),

      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
        child: DecoratedBox(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            boxShadow: [
              BoxShadow(
                blurRadius: 24,
                offset: const Offset(0, 8),
                color: AppColors.warmCoral.withValues(alpha: 0.14),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(24),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 28, sigmaY: 28),
              child: DecoratedBox(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24),
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      AppColors.white.withValues(alpha: 0.80),
                      AppColors.white.withValues(alpha: 0.60),
                    ],
                  ),
                  border: Border.all(
                    color: Colors.white.withValues(alpha: 0.60),
                    width: 1.2,
                  ),
                ),
                child: SafeArea(
                  top: false,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 10,
                    ),
                    child: GNav(
                      selectedIndex: currentIndex,

                      gap: 8,
                      iconSize: 22,

                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 10,
                      ),

                      duration: const Duration(milliseconds: 400),

                      color: AppColors.darkBrown,

                      activeColor: Colors.white,

                      tabBackgroundColor: AppColors.warmCoral,

                      textStyle: AppStyles.medium14.copyWith(
                        color: Colors.white,
                      ),

                      tabs: const [
                        GButton(icon: AppIcons.homeOutlinedIcon, text: 'Home'),
                        GButton(
                          icon: AppIcons.bookmarkBorderIcon,
                          text: 'Saved',
                        ),
                        GButton(
                          icon: AppIcons.personOutlinedIcon,
                          text: 'Profile',
                        ),
                      ],

                      onTabChange: (index) {
                        setState(() {
                          currentIndex = index;
                        });
                      },
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
