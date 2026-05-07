import 'package:flutter/material.dart';
import 'package:edufocus/core/themes/app_colors.dart';
import 'package:edufocus/core/utils/widgets/custom_text_field.dart';
import 'package:edufocus/core/widgets/edufocus_logo.dart';

// ─────────────────────────────────────────────────────────────────────────────
// ParentAuthScreen  –  Login / Sign-Up gateway for parents
// ─────────────────────────────────────────────────────────────────────────────
class ParentAuthScreen extends StatefulWidget {
  const ParentAuthScreen({super.key});

  @override
  State<ParentAuthScreen> createState() => _ParentAuthScreenState();
}

enum _AuthMode { login, signUp }

class _ParentAuthScreenState extends State<ParentAuthScreen> {
  final _formKey = GlobalKey<FormState>();

  // Controllers
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  _AuthMode _mode = _AuthMode.login;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  // ── Validation helpers ─────────────────────────────────────────────────────
  String? _validateEmail(String? v) {
    // if (v == null || v.trim().isEmpty) return 'Email is required';
    // final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    // if (!emailRegex.hasMatch(v.trim())) return 'Enter a valid email address';
    // return null;
  }

  String? _validatePassword(String? v) {
    // if (v == null || v.isEmpty) return 'Password is required';
    // if (v.length < 6) return 'Password must be at least 6 characters';
    // return null;
  }

  String? _validateConfirmPassword(String? v) {
    // if (v == null || v.isEmpty) return 'Please confirm your password';
    // if (v != _passwordController.text) return 'Passwords do not match';
    // return null;
  }

  // ── Action ─────────────────────────────────────────────────────────────────
  void _submit() {
    if (_formKey.currentState?.validate() ?? false) {
      Navigator.pushReplacementNamed(context, '/registration');
    }
  }

  void _handleGoogle() {}

  // ── Build ──────────────────────────────────────────────────────────────────
  @override
  Widget build(BuildContext context) {
    final isLogin = _mode == _AuthMode.login;

    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
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

                // ── Logo ──────────────────────────────────────────────────
                const EduFocusLogo(fontSize: 32, animate: false),
                const SizedBox(height: 28),

                // ── Title ──────────────────────────────────────────────────
                const Text(
                  'Parent Portal',
                  style: TextStyle(
                    color: AppColors.slate900,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    letterSpacing: -0.5,
                  ),
                ),
                const SizedBox(height: 8),

                // ── Subtitle ───────────────────────────────────────────────
                const Text(
                  'Sign in to set up a safe learning\nenvironment for your hero.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: AppColors.slate500,
                    fontSize: 14,
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 32),

                // ── Login / Sign Up tab toggle ─────────────────────────────
                _ModeToggle(
                  current: _mode,
                  onChanged: (m) => setState(() {
                    _mode = m;
                    _formKey.currentState?.reset();
                  }),
                ),
                const SizedBox(height: 28),

                // ── Email field ────────────────────────────────────────────
                _FieldLabel(text: "Parent's Email"),
                const SizedBox(height: 8),
                CustomTextFormField(
                  controller: _emailController,
                  hintText: 'Email',
                  keyboardType: TextInputType.emailAddress,
                  validator: _validateEmail,
                ),
                const SizedBox(height: 20),

                // ── Password field ─────────────────────────────────────────
                _FieldLabel(text: 'Password'),
                const SizedBox(height: 8),
                CustomTextFormField(
                  controller: _passwordController,
                  hintText: 'Password',
                  obscureText: true,
                  isPassword: true,
                  validator: _validatePassword,
                ),

                // ── Forgot password ────────────────────────────────────────
                if (isLogin) ...[
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {}, // TODO: forgot password flow
                      style: TextButton.styleFrom(
                        foregroundColor: AppColors.brandBlue,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 4,
                          vertical: 4,
                        ),
                      ),
                      child: const Text(
                        'Forgot Password?',
                        style: TextStyle(fontSize: 13),
                      ),
                    ),
                  ),
                ] else ...[
                  const SizedBox(height: 20),
                  // ── Confirm password (Sign Up only) ──────────────────────
                  _FieldLabel(text: 'Confirm Password'),
                  const SizedBox(height: 8),
                  CustomTextFormField(
                    controller: _confirmPasswordController,
                    hintText: 'Re-enter your password',
                    obscureText: true,
                    isPassword: true,
                    validator: _validateConfirmPassword,
                  ),
                  const SizedBox(height: 8),
                ],

                const SizedBox(height: 24),

                // ── Primary CTA button ─────────────────────────────────────
                _PrimaryButton(
                  label: isLogin ? 'Sign In' : 'Create Account',
                  icon: isLogin
                      ? Icons.login_rounded
                      : Icons.person_add_alt_1_rounded,
                  onPressed: _submit,
                ),
                const SizedBox(height: 24),

                // ── OR divider ─────────────────────────────────────────────
                const _OrDivider(),
                const SizedBox(height: 20),

                // ── Google button ──────────────────────────────────────────
                _GoogleButton(onPressed: _handleGoogle),
                const SizedBox(height: 36),

                // ── Footer note ────────────────────────────────────────────
                const Text(
                  'Once signed in, the child\'s world begins.\nThis screen will not appear again.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: AppColors.slate400,
                    fontSize: 12,
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// _ModeToggle  –  Login | Sign Up segmented row
// ─────────────────────────────────────────────────────────────────────────────
class _ModeToggle extends StatelessWidget {
  final _AuthMode current;
  final ValueChanged<_AuthMode> onChanged;

  const _ModeToggle({required this.current, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48,
      decoration: BoxDecoration(
        color: AppColors.slate100,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          _Tab(
            label: 'Login',
            selected: current == _AuthMode.login,
            onTap: () => onChanged(_AuthMode.login),
          ),
          _Tab(
            label: 'Sign Up',
            selected: current == _AuthMode.signUp,
            onTap: () => onChanged(_AuthMode.signUp),
          ),
        ],
      ),
    );
  }
}

class _Tab extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const _Tab({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        behavior: HitTestBehavior.opaque,
        child: Padding(
          padding: const EdgeInsets.all(4),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            decoration: BoxDecoration(
              color: selected
                  ? AppColors.brandGreen
                  : Colors.white.withValues(alpha: 0.4),
              borderRadius: BorderRadius.circular(10),
              boxShadow: selected
                  ? [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.08),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ]
                  : [],
            ),
            alignment: Alignment.center,
            child: AnimatedDefaultTextStyle(
              duration: const Duration(milliseconds: 200),
              style: TextStyle(
                color: selected
                    ? AppColors.backgroundLight
                    : AppColors.slate500,
                fontWeight: selected ? FontWeight.bold : FontWeight.w500,
                fontSize: 15,
              ),
              child: Text(label),
            ),
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// _FieldLabel
// ─────────────────────────────────────────────────────────────────────────────
class _FieldLabel extends StatelessWidget {
  final String text;
  const _FieldLabel({required this.text});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        text,
        style: const TextStyle(
          color: AppColors.slate700,
          fontSize: 14,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// _PrimaryButton
// ─────────────────────────────────────────────────────────────────────────────
class _PrimaryButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final VoidCallback onPressed;

  const _PrimaryButton({
    required this.label,
    required this.icon,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: ElevatedButton.icon(
        onPressed: onPressed,
        icon: Icon(icon, color: Colors.white, size: 20),
        label: Text(
          label,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 17,
            fontWeight: FontWeight.bold,
          ),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.brandGreen,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          elevation: 4,
          shadowColor: AppColors.brandGreen.withOpacity(0.35),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// _OrDivider
// ─────────────────────────────────────────────────────────────────────────────
class _OrDivider extends StatelessWidget {
  const _OrDivider();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Expanded(child: Divider(color: AppColors.slate200, thickness: 1)),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Text(
            'OR',
            style: TextStyle(
              color: AppColors.slate400,
              fontSize: 13,
              fontWeight: FontWeight.w600,
              letterSpacing: 1,
            ),
          ),
        ),
        const Expanded(child: Divider(color: AppColors.slate200, thickness: 1)),
      ],
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// _GoogleButton
// ─────────────────────────────────────────────────────────────────────────────
class _GoogleButton extends StatelessWidget {
  final VoidCallback onPressed;
  const _GoogleButton({required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 52,
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          side: const BorderSide(color: AppColors.slate200, width: 1.5),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          backgroundColor: Colors.white,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Google "G" logo placeholder
            Container(
              width: 24,
              height: 24,
              decoration: const BoxDecoration(shape: BoxShape.circle),
              child: const Text(
                'G',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF4285F4), // Google blue
                  height: 1.3,
                ),
              ),
            ),
            const SizedBox(width: 10),
            const Text(
              'Continue with Google',
              style: TextStyle(
                color: AppColors.slate700,
                fontSize: 15,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
