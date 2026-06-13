import 'package:flutter/material.dart';
import 'package:edufocus/core/themes/app_theme.dart';
import 'package:edufocus/features/auth/presentation/parent/widgets/auth_field_label.dart';
import 'package:edufocus/core/utils/widgets/custom_text_field.dart';
import 'package:edufocus/core/routes/app_routes.dart';
import 'package:edufocus/generated/l10n.dart';

class AuthLoginFields extends StatelessWidget {
  final TextEditingController emailController;
  final TextEditingController passwordController;

  const AuthLoginFields({
    super.key,
    required this.emailController,
    required this.passwordController,
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
      return null;
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AuthFieldLabel(text: S.of(context).parentEmailLabel),
        const SizedBox(height: 8),
        CustomTextFormField(
          key: const ValueKey('login_email'),
          controller: emailController,
          hintText: S.of(context).emailHint,
          keyboardType: TextInputType.emailAddress,
          validator: validateEmail,
        ),
        const SizedBox(height: 20),

        AuthFieldLabel(text: S.of(context).passwordHint),
        const SizedBox(height: 8),
        CustomTextFormField(
          key: const ValueKey('login_password'),
          controller: passwordController,
          hintText: S.of(context).passwordHint,
          obscureText: true,
          isPassword: true,
          validator: validatePassword,
        ),

        Align(
          alignment: Alignment.centerRight,
          child: TextButton(
            onPressed: () => Navigator.pushNamed(context, AppRoutes.forgotPassword),
            style: TextButton.styleFrom(
              foregroundColor: context.colors.brandBlue,
              padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
            ),
            child: Text(
              S.of(context).forgotPassword,
              style: const TextStyle(fontSize: 13),
            ),
          ),
        ),
      ],
    );
  }
}
