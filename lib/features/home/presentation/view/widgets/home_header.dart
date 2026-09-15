import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cookjar/core/utils/colors/app_colors.dart';
import 'package:cookjar/core/utils/styles/app_styles.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      return _buildHeader(userName: 'Chef', avatarUrl: null);
    }

    return StreamBuilder<DocumentSnapshot>(
      stream: FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .snapshots(),
      builder: (context, snapshot) {
        String userName = 'Chef';
        String? avatarUrl;

        if (snapshot.hasData && snapshot.data!.exists) {
          final data = snapshot.data!.data() as Map<String, dynamic>?;
          if (data != null) {
            userName = data['name'] as String? ?? 'Chef';
            avatarUrl = data['profileImageUrl'] as String?;
          }
        }

        return _buildHeader(userName: userName, avatarUrl: avatarUrl);
      },
    );
  }

  Widget _buildHeader({required String userName, String? avatarUrl}) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [AppColors.goldenHoney, AppColors.warmCoral],
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                'Hi, $userName! 👋',
                style: AppStyles.bold24.copyWith(color: AppColors.white),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: AppColors.white, width: 2),
              ),
              child: CircleAvatar(
                radius: 24,
                backgroundColor: AppColors.lightHoney,
                backgroundImage:
                    (avatarUrl != null && avatarUrl.trim().isNotEmpty)
                    ? NetworkImage(avatarUrl)
                    : null,
                child: (avatarUrl == null || avatarUrl.trim().isEmpty)
                    ? const Icon(
                        Icons.person,
                        size: 28,
                        color: AppColors.warmCoral,
                      )
                    : null,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
