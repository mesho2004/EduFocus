import 'package:edufocus/features/auth/presentation/parent/widgets/auth_field_label.dart';
import 'package:flutter/material.dart';
import 'package:edufocus/core/utils/widgets/custom_text_field.dart';

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
        const AuthFieldLabel(text: 'Email'),
        const SizedBox(height: 8),

        CustomTextFormField(
          controller: emailController,
          hintText: 'Email',
          keyboardType: TextInputType.emailAddress,
          validator: emailValidator,
        ),

        const SizedBox(height: 16),

        const AuthFieldLabel(text: 'Reset Code / OTP'),

        const SizedBox(height: 8),

        CustomTextFormField(
          controller: codeController,
          hintText: 'Enter 6-digit code',
          keyboardType: TextInputType.number,
          validator: codeValidator,
        ),

        const SizedBox(height: 16),

        const AuthFieldLabel(text: 'New Password'),

        const SizedBox(height: 8),

        CustomTextFormField(
          controller: passwordController,
          hintText: 'Choose a new password',
          obscureText: true,
          isPassword: true,
          validator: passwordValidator,
        ),

        const SizedBox(height: 16),

        const AuthFieldLabel(text: 'Confirm New Password'),

        const SizedBox(height: 8),

        CustomTextFormField(
          controller: confirmPasswordController,
          hintText: 'Re-enter new password',
          obscureText: true,
          isPassword: true,
          validator: confirmPasswordValidator,
        ),
      ],
    );
  }
}
