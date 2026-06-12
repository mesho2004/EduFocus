import 'package:flutter/material.dart';
import 'package:edufocus/core/themes/app_theme.dart';

enum AuthMode { login, signUp }

class AuthModeToggle extends StatelessWidget {
  final AuthMode current;
  final ValueChanged<AuthMode> onChanged;

  const AuthModeToggle({
    super.key,
    required this.current,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48,
      decoration: BoxDecoration(
        color: context.colors.border,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          _AuthTab(
            label: 'Login',
            selected: current == AuthMode.login,
            onTap: () => onChanged(AuthMode.login),
          ),
          _AuthTab(
            label: 'Sign Up',
            selected: current == AuthMode.signUp,
            onTap: () => onChanged(AuthMode.signUp),
          ),
        ],
      ),
    );
  }
}

class _AuthTab extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const _AuthTab({
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
                  ? context.colors.brandGreen
                  : context.colors.cardBackground.withOpacity(0.4),
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
                color: selected ? Colors.white : context.colors.textSecondary,
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
