import 'package:edufocus/features/auth/presentation/forgot%20password/widgets/forgot_password_form.dart';
import 'package:edufocus/features/auth/presentation/forgot%20password/widgets/forgot_password_header.dart';
import 'package:edufocus/features/auth/presentation/forgot%20password/widgets/send_code_button.dart';
import 'package:edufocus/features/auth/presentation/forgot%20password/widgets/top_noftication.dart';
import 'package:flutter/material.dart';
import 'package:edufocus/core/themes/app_theme.dart';
import 'package:edufocus/core/network/api_services.dart';
import 'package:edufocus/core/di/di.dart';
import 'package:edufocus/core/routes/app_routes.dart';
import 'package:edufocus/generated/l10n.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();

  bool _isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  String? _validateEmail(String? value) {
    if (value == null || value.trim().isEmpty) {
      return S.of(context).emailRequired;
    }

    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

    if (!emailRegex.hasMatch(value.trim())) {
      return S.of(context).emailInvalid;
    }

    return null;
  }

  Future<void> _submit() async {
    if (!(_formKey.currentState?.validate() ?? false)) {
      return;
    }

    setState(() => _isLoading = true);

    final email = _emailController.text.trim();

    try {
      final apiService = getIt<ApiServices>();

      final result = await apiService.forgotPassword(email);

      final message =
          result['message']?.toString() ??
          'Password reset code created successfully';

      final resetCode = result['reset_code']?.toString() ?? '';

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: Colors.green.shade600,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      );

      if (resetCode.isNotEmpty) {
        showTopNotification(context, resetCode);
      }

      Navigator.pushNamed(context, AppRoutes.resetPassword, arguments: email);
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.toString()),
          backgroundColor: context.colors.brandRed,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      );
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colors.background,
      appBar: AppBar(
        backgroundColor: context.colors.background,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new_rounded,
            color: context.colors.textPrimary,
          ),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                const ForgotPasswordHeader(),

                ForgotPasswordForm(
                  controller: _emailController,
                  validator: _validateEmail,
                ),

                const SizedBox(height: 32),

                SendCodeButton(isLoading: _isLoading, onPressed: _submit),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
