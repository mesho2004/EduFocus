import 'package:edufocus/features/auth/presentation/child/widgets/child_footer.dart';
import 'package:edufocus/features/auth/presentation/child/widgets/create_child_primary_button.dart';
import 'package:flutter/material.dart';
import 'package:edufocus/generated/l10n.dart';

class CreateChildProfileBottomSection extends StatelessWidget {
  const CreateChildProfileBottomSection({
    super.key,
    required this.isLoading,
    required this.onPressed,
  });

  final bool isLoading;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 16),
      child: Column(
        children: [
          CreateChildPrimaryButton(
            text: S.of(context).startLearning,
            onPressed: onPressed,
            trailingIcon: Icons.play_circle_fill_rounded,
            height: 64,
            isLoading: isLoading,
          ),
          const SizedBox(height: 8),
          ChildFooter(
            text: S.of(context).heroFooter,
          ),
        ],
      ),
    );
  }
}
