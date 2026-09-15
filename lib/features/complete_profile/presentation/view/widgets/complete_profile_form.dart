import 'dart:io';

import 'package:cookjar/core/common/app_snack_bar.dart';
import 'package:cookjar/core/routes/routes.dart';
import 'package:cookjar/core/utils/enums/favorite_meal.dart';
import 'package:cookjar/core/utils/styles/app_styles.dart';
import 'package:cookjar/core/widgets/buttons/main_button.dart';
import 'package:cookjar/core/widgets/inputs/app_text_form_field.dart';
import 'package:cookjar/features/complete_profile/presentation/view/widgets/favorite_meal_grid.dart';
import 'package:cookjar/features/complete_profile/presentation/view/widgets/profile_avatar_picker.dart';
import 'package:cookjar/features/complete_profile/presentation/view_model/complete_profile_cubit.dart';
import 'package:cookjar/features/complete_profile/presentation/view_model/complete_profile_state.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class CompleteProfileForm extends StatefulWidget {
  final String name;

  const CompleteProfileForm({super.key, required this.name});

  @override
  State<CompleteProfileForm> createState() => _CompleteProfileFormState();
}

class _CompleteProfileFormState extends State<CompleteProfileForm> {
  late final TextEditingController _nameController;
  FavoriteMeal? _selectedMeal = FavoriteMeal.dinner;
  File? _selectedImage;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.name);
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  void _onCompleteProfilePressed() {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      AppSnackBar.error(context, 'User not authenticated.');
      return;
    }

    if (_selectedImage == null) {
      AppSnackBar.error(context, 'Please select a profile image.');
      return;
    }

    if (_selectedMeal == null) {
      AppSnackBar.error(context, 'Please select your favorite meal.');
      return;
    }

    context.read<CompleteProfileCubit>().completeProfile(
      name: _nameController.text.trim(),
      email: user.email ?? '',
      favoriteMeal: _selectedMeal!.label,
      imageFile: _selectedImage!,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CompleteProfileCubit, CompleteProfileState>(
      listener: (context, state) {
        if (state is CompleteProfileSuccess) {
          AppSnackBar.success(context, 'Profile completed successfully!');
          context.go(Routes.main);
        } else if (state is CompleteProfileError) {
          AppSnackBar.error(context, state.errorMessage);
        }
      },
      builder: (context, state) {
        final isLoading = state is CompleteProfileLoading;

        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Complete Your Profile', style: AppStyles.bold28),
              const Gap(6),
              Text("Let's make it personal!", style: AppStyles.regular16),
              const Gap(24),
              Center(
                child: ProfileAvatarPicker(
                  selectedImage: _selectedImage,
                  onImageSelected: (image) {
                    setState(() {
                      _selectedImage = image;
                    });
                  },
                ),
              ),
              const Gap(28),
              Text('Name', style: AppStyles.medium16),
              const Gap(8),
              AppTextFormField(
                controller: _nameController,
                hintText: 'Your name',
                readOnly:
                    true, // Name comes from Register, shouldn't be edited here
              ),
              const Gap(24),
              Text('Favorite Meal', style: AppStyles.medium16),
              const Gap(12),
              FavoriteMealGrid(
                selectedMeal: _selectedMeal,
                onSelect: (meal) => setState(() => _selectedMeal = meal),
              ),
              const Gap(32),
              MainButton(
                text: 'Complete Profile',
                isLoading: isLoading,
                onPressed: _onCompleteProfilePressed,
              ),
              const Gap(24),
            ],
          ),
        );
      },
    );
  }
}
