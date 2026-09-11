import 'package:flutter/material.dart';
import 'package:cookjar/core/utils/colors/app_colors.dart';
import 'package:cookjar/core/widgets/custom_svg_picture.dart';

/// A 20x20 SVG icon for use as a TextFormField prefix icon.
///
/// The padding keeps the SVG at its intended size — without it the input
/// decorator's 48x48 minimum constraints stretch the SVG to fill the box.
class InputIcon extends StatelessWidget {
  const InputIcon({super.key, required this.path, this.color});

  final String path;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(14),
      child: CustomSvgPicture(
        path: path,
        width: 20,
        height: 20,
        color: color ?? AppColors.darkBrown,
      ),
    );
  }
}
