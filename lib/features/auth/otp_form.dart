import 'package:edufocus/features/auth/presentation/parent/widgets/auth_field_label.dart';
import 'package:flutter/material.dart';
import 'package:edufocus/core/utils/widgets/custom_text_field.dart';
import 'package:edufocus/generated/l10n.dart';

class OtpForm extends StatelessWidget {
  const OtpForm({
    super.key,
    required this.emailController,
    required this.codeController,
    required this.passwordController,
    required this.confirmPasswordController,
    required this.emailValidator,
    required this.codeValidator,
    required this.passwordValidator,
    required this.confirmPasswordValidator,
  });

  final TextEditingController emailController;
  final TextEditingController codeController;
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;

  final String? Function(String?) emailValidator;
  final String? Function(String?) codeValidator;
  final String? Function(String?) passwordValidator;
  final String? Function(String?) confirmPasswordValidator;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AuthFieldLabel(text: S.of(context).email),
        const SizedBox(height: 8),

        CustomTextFormField(
          controller: emailController,
          hintText: S.of(context).emailHint,
          keyboardType: TextInputType.emailAddress,
          validator: emailValidator,
        ),

        const SizedBox(height: 16),

        AuthFieldLabel(text: S.of(context).resetCodeLabel),

        const SizedBox(height: 8),

        CustomTextFormField(
          controller: codeController,
          hintText: S.of(context).resetCodeHint,
          keyboardType: TextInputType.number,
          validator: codeValidator,
        ),

        const SizedBox(height: 16),

        AuthFieldLabel(text: S.of(context).newPasswordLabel),

        const SizedBox(height: 8),

        CustomTextFormField(
          controller: passwordController,
          hintText: S.of(context).newPasswordHint,
          obscureText: true,
          isPassword: true,
          validator: passwordValidator,
        ),

        const SizedBox(height: 16),

        AuthFieldLabel(text: S.of(context).confirmNewPasswordLabel),

        const SizedBox(height: 8),

        CustomTextFormField(
          controller: confirmPasswordController,
          hintText: S.of(context).confirmNewPasswordHint,
          obscureText: true,
          isPassword: true,
          validator: confirmPasswordValidator,
        ),
      ],
    );
  }
}
