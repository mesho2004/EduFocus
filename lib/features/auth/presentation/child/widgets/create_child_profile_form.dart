import 'package:edufocus/core/themes/app_theme.dart';
import 'package:edufocus/core/utils/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:edufocus/generated/l10n.dart';

class CreateChildProfileForm extends StatelessWidget {
  const CreateChildProfileForm({super.key, required this.controller});

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          S.of(context).heroName,
          style: TextStyle(
            color: context.colors.textSecondary,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 10),
        CustomTextFormField(
          hintText: S.of(context).typeYourNameHint,
          controller: controller,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return S.of(context).enterNameError;
            }
            return null;
          },
        ),
      ],
    );
  }
}
