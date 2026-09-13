import 'package:cookjar/core/utils/colors/app_colors.dart';
import 'package:cookjar/core/utils/styles/app_styles.dart';
import 'package:flutter/material.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key, this.userName = 'Unknown', this.avatarUrl});

  /// User display name
  final String userName;

  /// Optional profile image URL
  final String? avatarUrl;

  static const String _defaultAvatarUrl = 'https://i.pravatar.cc/300?img=47';

  @override
  Widget build(BuildContext context) {
    final effectiveAvatarUrl =
        (avatarUrl != null && avatarUrl!.trim().isNotEmpty)
        ? avatarUrl!
        : _defaultAvatarUrl;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Hi, $userName! 👋',
            style: AppStyles.bold24.copyWith(color: AppColors.white),
          ),
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: AppColors.white, width: 2),
            ),
            child: CircleAvatar(
              radius: 24,
              backgroundColor: AppColors.lightHoney,
              backgroundImage: NetworkImage(effectiveAvatarUrl),
            ),
          ),
        ],
      ),
    );
  }
}
