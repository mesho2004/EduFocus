import 'package:edufocus/core/themes/app_theme.dart';
import 'package:flutter/material.dart';

class CreateChildProfileAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  const CreateChildProfileAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: context.colors.background,
      elevation: 0,
      centerTitle: true,
      title: Text(
        'New Explorer',
        style: TextStyle(
          color: context.colors.textPrimary,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      leading: Navigator.canPop(context)
          ? IconButton(
              icon: Icon(
                Icons.arrow_back_ios_new_rounded,
                color: context.colors.textSecondary,
              ),
              onPressed: () => Navigator.maybePop(context),
            )
          : null,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
