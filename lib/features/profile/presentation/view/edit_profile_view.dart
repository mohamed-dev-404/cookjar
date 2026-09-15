import 'dart:io';

import 'package:cookjar/core/common/app_snack_bar.dart';
import 'package:cookjar/core/utils/colors/app_colors.dart';
import 'package:cookjar/core/utils/enums/favorite_meal.dart';
import 'package:cookjar/core/utils/styles/app_styles.dart';
import 'package:cookjar/core/widgets/buttons/main_button.dart';
import 'package:cookjar/core/widgets/inputs/app_text_form_field.dart';
import 'package:cookjar/features/complete_profile/presentation/view/widgets/favorite_meal_grid.dart';
import 'package:cookjar/features/profile/data/models/profile_model.dart';
import 'package:cookjar/features/profile/presentation/view_model/profile_cubit.dart';
import 'package:cookjar/features/profile/presentation/view_model/profile_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';

class EditProfileView extends StatefulWidget {
  final ProfileModel profile;

  const EditProfileView({super.key, required this.profile});

  @override
  State<EditProfileView> createState() => _EditProfileViewState();
}

class _EditProfileViewState extends State<EditProfileView> {
  late final TextEditingController _nameController;
  late final TextEditingController _emailController;
  FavoriteMeal? _selectedMeal;
  File? _selectedImage;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.profile.name);
    _emailController = TextEditingController(text: widget.profile.email);

    // Find matching favorite meal from enum
    try {
      _selectedMeal = FavoriteMeal.values.firstWhere(
        (meal) => meal.label == widget.profile.favoriteMeal,
      );
    } catch (_) {
      _selectedMeal = FavoriteMeal.dinner;
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
      });
    }
  }

  void _onSavePressed() {
    if (_nameController.text.trim().isEmpty) {
      AppSnackBar.error(context, 'Name cannot be empty.');
      return;
    }

    if (_selectedMeal == null) {
      AppSnackBar.error(context, 'Please select your favorite meal.');
      return;
    }

    context.read<ProfileCubit>().updateProfile(
      name: _nameController.text.trim(),
      favoriteMeal: _selectedMeal!.label,
      newImage: _selectedImage,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Profile', style: AppStyles.bold24),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: SafeArea(
        child: BlocConsumer<ProfileCubit, ProfileState>(
          listener: (context, state) {
            if (state is ProfileUpdateSuccess) {
              AppSnackBar.success(context, 'Profile updated successfully!');
              context.pop();
            } else if (state is ProfileUpdateError) {
              AppSnackBar.error(context, state.errorMessage);
            }
          },
          builder: (context, state) {
            final isLoading = state is ProfileUpdating;

            return SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: SizedBox(
                      width: 120,
                      height: 120,
                      child: Stack(
                        clipBehavior: Clip.none,
                        children: [
                          CircleAvatar(
                            radius: 60,
                            backgroundColor: AppColors.borderGray,
                            backgroundImage: _selectedImage != null
                                ? FileImage(_selectedImage!)
                                : (widget.profile.profileImage.isNotEmpty
                                          ? NetworkImage(
                                              widget.profile.profileImage,
                                            )
                                          : null)
                                      as ImageProvider?,
                            child:
                                (_selectedImage == null &&
                                    widget.profile.profileImage.isEmpty)
                                ? const Icon(
                                    Icons.person,
                                    size: 60,
                                    color: AppColors.white,
                                  )
                                : null,
                          ),
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: InkWell(
                              onTap: _pickImage,
                              borderRadius: BorderRadius.circular(20),
                              child: Container(
                                width: 36,
                                height: 36,
                                decoration: const BoxDecoration(
                                  color: AppColors.warmCoral,
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(
                                  Icons.camera_alt,
                                  color: AppColors.white,
                                  size: 18,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const Gap(32),
                  Text('Name', style: AppStyles.medium16),
                  const Gap(8),
                  AppTextFormField(
                    controller: _nameController,
                    hintText: 'Your name',
                  ),
                  const Gap(16),
                  Text('Email', style: AppStyles.medium16),
                  const Gap(8),
                  AppTextFormField(
                    controller: _emailController,
                    hintText: 'Your email',
                    readOnly: true,
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
                    text: 'Save Changes',
                    isLoading: isLoading,
                    onPressed: _onSavePressed,
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
