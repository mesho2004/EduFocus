import 'package:flutter/material.dart';
import 'package:edufocus/features/auth/presentation/parent/widgets/auth_field_label.dart';
import 'package:edufocus/core/utils/widgets/custom_text_field.dart';

class AuthSignupFields extends StatelessWidget {
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;

  const AuthSignupFields({
    super.key,
    required this.emailController,
    required this.passwordController,
    required this.confirmPasswordController,
  });

  String? _validateEmail(String? v) {
    if (v == null || v.trim().isEmpty) return 'Email is required';
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(v.trim())) return 'Enter a valid email address';
    return null;
  }

  String? _validatePassword(String? v) {
    if (v == null || v.isEmpty) return 'Password is required';
    if (v.length < 6) return 'Password must be at least 6 characters';
    return null;
  }

  String? _validateConfirmPassword(String? v) {
    if (v == null || v.isEmpty) return 'Please confirm your password';
    if (v != passwordController.text) return 'Passwords do not match';
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const AuthFieldLabel(text: "Parent's Email"),
        const SizedBox(height: 8),
        CustomTextFormField(
          key: const ValueKey('signup_email'),
          controller: emailController,
          hintText: 'Email',
          keyboardType: TextInputType.emailAddress,
          validator: _validateEmail,
        ),
        const SizedBox(height: 20),

        const AuthFieldLabel(text: 'Password'),
        const SizedBox(height: 8),
        CustomTextFormField(
          key: const ValueKey('signup_password'),
          controller: passwordController,
          hintText: 'Password',
          obscureText: true,
          isPassword: true,
          validator: _validatePassword,
        ),
        const SizedBox(height: 20),

        const AuthFieldLabel(text: 'Confirm Password'),
        const SizedBox(height: 8),
        CustomTextFormField(
          key: const ValueKey('signup_confirm_password'),
          controller: confirmPasswordController,
          hintText: 'Re-enter your password',
          obscureText: true,
          isPassword: true,
          validator: _validateConfirmPassword,
        ),
      ],
    );
  }
}
