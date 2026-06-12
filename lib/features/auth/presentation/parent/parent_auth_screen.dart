import 'package:edufocus/features/auth/presentation/parent/widgets/auth_footer.dart';
import 'package:edufocus/features/auth/presentation/parent/widgets/auth_header.dart';
import 'package:edufocus/features/auth/presentation/parent/widgets/auth_login_fields.dart';
import 'package:edufocus/features/auth/presentation/parent/widgets/auth_signup_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:edufocus/core/themes/app_theme.dart';
import 'package:edufocus/features/auth/data/cubit/auth_cubit.dart';
import 'package:edufocus/features/auth/data/cubit/auth_state.dart';
import 'package:edufocus/core/bloc/curriculum_cubit.dart';
import 'package:edufocus/features/auth/presentation/parent/widgets/auth_mode_toggle.dart';
import 'package:edufocus/features/auth/presentation/parent/widgets/auth_primary_button.dart';
import 'package:edufocus/core/routes/app_routes.dart';

class ParentAuthScreen extends StatefulWidget {
  const ParentAuthScreen({super.key});

  @override
  State<ParentAuthScreen> createState() => _ParentAuthScreenState();
}

class _ParentAuthScreenState extends State<ParentAuthScreen> {
  final _formKey = GlobalKey<FormState>();

  final _loginEmailController = TextEditingController();
  final _loginPasswordController = TextEditingController();

  final _signUpEmailController = TextEditingController();
  final _signUpPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  AuthMode _mode = AuthMode.login;

  @override
  void dispose() {
    _loginEmailController.dispose();
    _loginPasswordController.dispose();
    _signUpEmailController.dispose();
    _signUpPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _submit() {
    if (_formKey.currentState?.validate() ?? false) {
      if (_mode == AuthMode.login) {
        context.read<AuthCubit>().login(
          _loginEmailController.text.trim(),
          _loginPasswordController.text,
        );
      } else {
        context.read<AuthCubit>().register(
          _signUpEmailController.text.trim(),
          _signUpPasswordController.text,
          _confirmPasswordController.text,
        );
      }
    }
  }

  void _handleAuthSuccess(BuildContext context, AuthSuccess state) {
    context.read<CurriculumCubit>().loadCurriculum();
    Navigator.pushReplacementNamed(
      context,
      state.hasChild ? AppRoutes.subjectsGridView : AppRoutes.registration,
    );
  }

  void _handleAuthFailure(BuildContext context, AuthFailure state) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(state.errorMessage),
        backgroundColor: context.colors.brandRed,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isLogin = _mode == AuthMode.login;

    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthSuccess) _handleAuthSuccess(context, state);
        if (state is AuthFailure) _handleAuthFailure(context, state);
      },
      builder: (context, state) {
        final isLoading = state is AuthLoading;

        return Scaffold(
          backgroundColor: context.colors.background,
          body: SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 40),
                    const AuthHeader(),
                    const SizedBox(height: 32),

                    AuthModeToggle(
                      current: _mode,
                      onChanged: (m) => setState(() {
                        _mode = m;
                        _formKey.currentState?.reset();
                      }),
                    ),
                    const SizedBox(height: 28),
                    if (isLogin)
                      AuthLoginFields(
                        emailController: _loginEmailController,
                        passwordController: _loginPasswordController,
                      )
                    else
                      AuthSignupFields(
                        emailController: _signUpEmailController,
                        passwordController: _signUpPasswordController,
                        confirmPasswordController: _confirmPasswordController,
                      ),

                    const SizedBox(height: 24),
                    AuthPrimaryButton(
                      label: isLogin ? 'Sign In' : 'Create Account',
                      icon: isLogin
                          ? Icons.login_rounded
                          : Icons.person_add_alt_1_rounded,
                      isLoading: isLoading,
                      onPressed: _submit,
                    ),
                    const SizedBox(height: 36),

                    const AuthFooter(),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
