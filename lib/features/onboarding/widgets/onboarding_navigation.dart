import 'package:flutter/material.dart';
import 'package:edufocus/generated/l10n.dart';

class OnboardingNavigation extends StatelessWidget {
  final int currentPage;
  final int totalPages;
  final Color activeColor;
  final VoidCallback onNextPressed;
  final Widget Function(int index) dotBuilder;

  const OnboardingNavigation({
    super.key,
    required this.currentPage,
    required this.totalPages,
    required this.activeColor,
    required this.onNextPressed,
    required this.dotBuilder,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(32.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              totalPages,
              (index) => dotBuilder(index),
            ),
          ),
          const SizedBox(height: 32),

          GestureDetector(
            onTap: onNextPressed,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              padding: const EdgeInsets.symmetric(vertical: 18),
              width: double.infinity,
              decoration: BoxDecoration(
                color: activeColor,
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    color: activeColor.withOpacity(0.4),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Center(
                child: Text(
                  currentPage == totalPages - 1 ? S.of(context).letsPlay : S.of(context).next,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
