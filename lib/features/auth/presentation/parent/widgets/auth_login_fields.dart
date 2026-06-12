import 'package:flutter/material.dart';
import 'package:edufocus/core/themes/app_theme.dart';
import 'package:edufocus/features/auth/presentation/parent/widgets/auth_field_label.dart';
import 'package:edufocus/core/utils/widgets/custom_text_field.dart';
import 'package:edufocus/core/routes/app_routes.dart';

class AuthLoginFields extends StatelessWidget {
  final TextEditingController emailController;
  final TextEditingController passwordController;

  const AuthLoginFields({
    super.key,
    required this.emailController,
    required this.passwordController,
  });

  String? _validateEmail(String? v) {
    if (v == null || v.trim().isEmpty) return 'Email is required';
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(v.trim())) return 'Enter a valid email address';
    return null;
  }

  String? _validatePassword(String? v) {
    if (v == null || v.isEmpty) return 'Password is required';
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
          key: const ValueKey('login_email'),
          controller: emailController,
          hintText: 'Email',
          keyboardType: TextInputType.emailAddress,
          validator: _validateEmail,
        ),
        const SizedBox(height: 20),

        const AuthFieldLabel(text: 'Password'),
        const SizedBox(height: 8),
        CustomTextFormField(
          key: const ValueKey('login_password'),
          controller: passwordController,
          hintText: 'Password',
          obscureText: true,
          isPassword: true,
          validator: _validatePassword,
        ),

        Align(
          alignment: Alignment.centerRight,
          child: TextButton(
            onPressed: () => Navigator.pushNamed(context, AppRoutes.forgotPassword),
            style: TextButton.styleFrom(
              foregroundColor: context.colors.brandBlue,
              padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
            ),
            child: const Text(
              'Forgot Password?',
              style: TextStyle(fontSize: 13),
            ),
          ),
        ),
      ],
    );
  }
}
