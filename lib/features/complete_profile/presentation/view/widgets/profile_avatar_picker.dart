import 'package:cookjar/core/utils/colors/app_colors.dart';
import 'package:flutter/material.dart';

class ProfileAvatarPicker extends StatelessWidget {
  const ProfileAvatarPicker({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 120,
      height: 120,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          const CircleAvatar(
            radius: 60,
            backgroundColor: AppColors.borderGray,
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: InkWell(
              onTap: () {
                // TODO: hook up image_picker once logic is added
              },
              borderRadius: BorderRadius.circular(20),
              child: Container(
                width: 36,
                height: 36,
                decoration: const BoxDecoration(
                  color: AppColors.warmCoral,
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.camera_alt, color: AppColors.white, size: 18),
              ),
            ),
          ),
        ],
      ),
    );
  }
}