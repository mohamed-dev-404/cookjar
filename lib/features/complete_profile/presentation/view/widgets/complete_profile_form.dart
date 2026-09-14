import 'package:cookjar/core/utils/enums/favorite_meal.dart';
import 'package:cookjar/core/utils/styles/app_styles.dart';
import 'package:cookjar/core/widgets/buttons/main_button.dart';
import 'package:cookjar/core/widgets/inputs/app_text_form_field.dart';
import 'package:cookjar/features/complete_profile/presentation/view/widgets/favorite_meal_grid.dart';
import 'package:cookjar/features/complete_profile/presentation/view/widgets/profile_avatar_picker.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class CompleteProfileForm extends StatefulWidget {
  const CompleteProfileForm({super.key});

  @override
  State<CompleteProfileForm> createState() => _CompleteProfileFormState();
}

class _CompleteProfileFormState extends State<CompleteProfileForm> {
  final _nameController = TextEditingController();
  FavoriteMeal? _selectedMeal = FavoriteMeal.dinner; // matches mockup default

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Complete Your Profile', style: AppStyles.bold28),
          const Gap(6),
          Text("Let's make it personal!", style: AppStyles.regular16),
          const Gap(24),
          const Center(child: ProfileAvatarPicker()),
          const Gap(28),
          Text('Name', style: AppStyles.medium16),
          const Gap(8),
          AppTextFormField(
            controller: _nameController,
            hintText: 'Your name',
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
          isLoading: false,
          onPressed: () {
            // TODO: wire to cubit once logic is added
          },
        ),
                  const Gap(24),
        ],
      ),
    );
  }
}