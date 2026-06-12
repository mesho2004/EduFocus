import 'package:edufocus/features/auth/presentation/parent/widgets/auth_field_label.dart';
import 'package:flutter/material.dart';
import 'package:edufocus/core/utils/widgets/custom_text_field.dart';

class ForgotPasswordForm extends StatelessWidget {
  const ForgotPasswordForm({
    super.key,
    required this.controller,
    required this.validator,
  });

  final TextEditingController controller;
  final String? Function(String?) validator;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const AuthFieldLabel(text: "Parent's Email"),

        const SizedBox(height: 8),

        CustomTextFormField(
          controller: controller,
          hintText: 'Email',
          keyboardType: TextInputType.emailAddress,
          validator: validator,
        ),
      ],
    );
  }
}
