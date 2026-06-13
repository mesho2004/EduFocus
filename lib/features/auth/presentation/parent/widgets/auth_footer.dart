import 'package:flutter/material.dart';
import 'package:edufocus/core/themes/app_theme.dart';
import 'package:edufocus/generated/l10n.dart';

class AuthFooter extends StatelessWidget {
  const AuthFooter({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      S.of(context).parentPortalFooter,
      textAlign: TextAlign.center,
      style: TextStyle(
        color: context.colors.textTertiary,
        fontSize: 12,
        height: 1.5,
      ),
    );
  }
}
