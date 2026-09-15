import 'package:cookjar/core/utils/colors/app_colors.dart';
import 'package:cookjar/core/utils/styles/app_styles.dart';
import 'package:flutter/material.dart';

/// Numbered instruction steps. Falls back to a friendly message if the
/// API returns an empty list.
class InstructionsList extends StatelessWidget {
  const InstructionsList({super.key, required this.instructions});

  final List<String> instructions;

  @override
  Widget build(BuildContext context) {
    if (instructions.isEmpty) {
      return Text(
        'No instructions listed for this recipe.',
        style: AppStyles.regular14.copyWith(
          color: AppColors.darkBrown.withValues(alpha: 0.6),
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: List.generate(instructions.length, (index) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${index + 1}. ',
                style: AppStyles.bold14.copyWith(color: AppColors.warmCoral),
              ),
              Expanded(
                child: Text(instructions[index], style: AppStyles.regular14),
              ),
            ],
          ),
        );
      }),
    );
  }
}
