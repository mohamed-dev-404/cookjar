import 'package:cookjar/core/di/service_locator.dart';
import 'package:cookjar/core/utils/colors/app_colors.dart';
import 'package:cookjar/core/widgets/animated_loading_widget.dart';
import 'package:cookjar/core/widgets/empty_state_widget.dart';
import 'package:cookjar/features/profile/presentation/view/widgets/profile_action_tile.dart';
import 'package:cookjar/features/profile/presentation/view/widgets/profile_header.dart';
import 'package:cookjar/features/profile/presentation/view/widgets/profile_logout_dialog.dart';
import 'package:cookjar/features/profile/presentation/view/widgets/profile_stats_section.dart';
import 'package:cookjar/features/profile/presentation/view_model/profile_cubit.dart';
import 'package:cookjar/features/profile/presentation/view_model/profile_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ProfileCubit>(
      create: (context) => getIt<ProfileCubit>()..fetchProfile(),
      child: const _ProfileViewContent(),
    );
  }
}

class _ProfileViewContent extends StatelessWidget {
  const _ProfileViewContent();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        top: false,
        child: BlocConsumer<ProfileCubit, ProfileState>(
          listener: (context, state) {
            if (state is ProfileLoggedOut) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Logged out successfully'),
                  behavior: SnackBarBehavior.floating,
                ),
              );
            }
          },
          builder: (context, state) {
            if (state is ProfileLoading || state is ProfileInitial) {
              return const Center(child: AnimatedLoadingWidget(height: 100));
            }

            if (state is ProfileError) {
              return Center(
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      EmptyStateWidget(
                        title: 'Error Loading Profile',
                        subtitle: state.errorMessage,
                      ),
                      const Gap(16),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.warmCoral,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        onPressed: () {
                          context.read<ProfileCubit>().fetchProfile();
                        },
                        child: const Text(
                          'Retry',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }

            if (state is ProfileSuccess) {
              final profile = state.profile;

              return SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    // Profile Header (Avatar, Name & Email)
                    ProfileHeader(
                      name: profile.name,
                      email: profile.email,
                      imageUrl: profile.profileImage,
                      onCameraTap: () {
                        // Image picker trigger point
                      },
                    ),

                    const Gap(24),

                    // Stats Section (Favorite Meal & Loved Recipes)
                    ProfileStatsSection(
                      favoriteMeal: profile.favoriteMeal,
                      savedRecipesCount: profile.savedRecipesCount,
                    ),

                    const Gap(20),

                    // Action Buttons (Edit Profile & Logout)
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: Column(
                        children: [
                          ProfileActionTile(
                            icon: Icons.person_outline_rounded,
                            title: "Edit Profile",
                            onTap: () {
                              // Edit Profile action
                            },
                          ),
                          const Gap(16),
                          ProfileActionTile(
                            icon: Icons.logout_rounded,
                            title: "Logout",
                            textColor: const Color(0xFFFF5252),
                            iconColor: const Color(0xFFFF5252),
                            onTap: () {
                              ProfileLogoutDialog.show(
                                context,
                                onConfirm: () {
                                  context.read<ProfileCubit>().logout();
                                },
                              );
                            },
                          ),
                        ],
                      ),
                    ),

                    const Gap(32),
                  ],
                ),
              );
            }

            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
