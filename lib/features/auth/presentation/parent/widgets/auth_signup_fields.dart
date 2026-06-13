import 'package:flutter/material.dart';
import 'package:edufocus/features/auth/presentation/parent/widgets/auth_field_label.dart';
import 'package:edufocus/core/utils/widgets/custom_text_field.dart';
import 'package:edufocus/generated/l10n.dart';

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

  @override
  Widget build(BuildContext context) {
    String? validateEmail(String? v) {
      if (v == null || v.trim().isEmpty) return S.of(context).emailRequired;
      final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
      if (!emailRegex.hasMatch(v.trim())) return S.of(context).emailInvalid;
      return null;
    }

    String? validatePassword(String? v) {
      if (v == null || v.isEmpty) return S.of(context).passwordRequired;
      if (v.length < 6) return S.of(context).passwordTooShort;
      return null;
    }

    String? validateConfirmPassword(String? v) {
      if (v == null || v.isEmpty) return S.of(context).confirmPasswordRequired;
      if (v != passwordController.text) return S.of(context).passwordsDoNotMatch;
      return null;
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AuthFieldLabel(text: S.of(context).parentEmailLabel),
        const SizedBox(height: 8),
        CustomTextFormField(
          key: const ValueKey('signup_email'),
          controller: emailController,
          hintText: S.of(context).emailHint,
          keyboardType: TextInputType.emailAddress,
          validator: validateEmail,
        ),
        const SizedBox(height: 20),

        AuthFieldLabel(text: S.of(context).passwordHint),
        const SizedBox(height: 8),
        CustomTextFormField(
          key: const ValueKey('signup_password'),
          controller: passwordController,
          hintText: S.of(context).passwordHint,
          obscureText: true,
          isPassword: true,
          validator: validatePassword,
        ),
        const SizedBox(height: 20),

        AuthFieldLabel(text: S.of(context).confirmPassword),
        const SizedBox(height: 8),
        CustomTextFormField(
          key: const ValueKey('signup_confirm_password'),
          controller: confirmPasswordController,
          hintText: S.of(context).confirmPasswordHint,
          obscureText: true,
          isPassword: true,
          validator: validateConfirmPassword,
        ),
      ],
    );
  }
}
