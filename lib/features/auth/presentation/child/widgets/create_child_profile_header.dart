import 'package:edufocus/core/themes/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:edufocus/generated/l10n.dart';

class CreateChildProfileHeader extends StatelessWidget {
  const CreateChildProfileHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        S.of(context).profileSetupTitle,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: context.colors.textPrimary,
          fontSize: 26,
          fontWeight: FontWeight.bold,
          letterSpacing: -0.5,
        ),
      ),
    );
  }
}
