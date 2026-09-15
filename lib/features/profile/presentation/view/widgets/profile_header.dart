import 'package:cookjar/core/utils/colors/app_colors.dart';
import 'package:cookjar/core/utils/helpers/image_helper.dart';
import 'package:cookjar/core/utils/styles/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class ProfileHeader extends StatelessWidget {
  final String name;
  final String email;
  final String? imageUrl;
  final VoidCallback? onCameraTap;

  const ProfileHeader({
    super.key,
    required this.name,
    required this.email,
    this.imageUrl,
    this.onCameraTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          clipBehavior: Clip.none,
          alignment: Alignment.center,
          children: [
            // Top Gradient Container Header
            Container(
              height: 180,
              width: double.infinity,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [AppColors.goldenHoney, AppColors.warmCoral],
                ),
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(36),
                ),
              ),
            ),

            // Avatar Positioned over the Banner
            Positioned(
              bottom: -50,
              child: Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: AppColors.white, width: 4),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.darkBrown.withValues(alpha: 0.12),
                          blurRadius: 16,
                          offset: const Offset(0, 6),
                        ),
                      ],
                    ),
                    child: CircleAvatar(
                      radius: 54,
                      backgroundColor: AppColors.borderGray,
                      backgroundImage: imageProviderFromUrl(imageUrl),
                      child: (imageUrl == null || imageUrl!.isEmpty)
                          ? const Icon(
                              Icons.person,
                              size: 54,
                              color: AppColors.white,
                            )
                          : null,
                    ),
                  ),
                  if (onCameraTap != null)
                    Positioned(
                      bottom: 4,
                      right: 4,
                      child: GestureDetector(
                        onTap: onCameraTap,
                        child: Container(
                          padding: const EdgeInsets.all(7),
                          decoration: BoxDecoration(
                            color: AppColors.warmCoral,
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: AppColors.white,
                              width: 2,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: AppColors.darkBrown.withValues(
                                  alpha: 0.15,
                                ),
                                blurRadius: 6,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: const Icon(
                            Icons.camera_alt_rounded,
                            size: 15,
                            color: AppColors.white,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
        const Gap(60),

        // User Full Name
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Text(
            name.isNotEmpty ? name : 'CookJar Chef',
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: AppStyles.bold24,
          ),
        ),
        const Gap(4),

        // User Email
        if (email.isNotEmpty)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Text(
              email,
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: AppStyles.medium14.copyWith(color: Colors.grey.shade600),
            ),
          ),
      ],
    );
  }
}
