import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:cookjar/core/utils/assets/app_icons.dart';
import 'package:cookjar/core/utils/colors/app_colors.dart';
import 'package:cookjar/core/utils/styles/app_styles.dart';
import 'package:cookjar/core/widgets/custom_svg_picture.dart';

class PasswordTextFormField extends StatefulWidget {
  const PasswordTextFormField({
    super.key,
    this.label,
    this.hintText,
    this.controller,
    this.validator,
    this.prefixIcon,
  });

  /// Optional label displayed above the field.
  final String? label;
  final String? hintText;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final Widget? prefixIcon;

  @override
  State<PasswordTextFormField> createState() => _PasswordTextFormFieldState();
}

class _PasswordTextFormFieldState extends State<PasswordTextFormField> {
  bool obscureText = true;

  @override
  Widget build(BuildContext context) {
    final field = TextFormField(
      controller: widget.controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        hintText: widget.hintText,
        prefixIcon: widget.prefixIcon,
        suffixIcon: IconButton(
          onPressed: () {
            setState(() {
              obscureText = !obscureText;
            });
          },
          icon: CustomSvgPicture(
            path: obscureText ? AppIcons.eyeOffSvg : AppIcons.eyeSvg,
            width: 20,
            height: 20,
            color: AppColors.darkBrown,
          ),
        ),
      ),
      onTapOutside: (event) {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      validator: widget.validator,
    );

    if (widget.label == null) return field;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.label!,
          style: AppStyles.bold15.copyWith(color: AppColors.warmCoral),
        ),
        const Gap(8),
        field,
      ],
    );
  }
}
