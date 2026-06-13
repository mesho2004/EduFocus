import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:edufocus/core/themes/app_theme.dart';
import 'package:edufocus/core/themes/app_colors.dart';
import 'package:edufocus/core/bloc/curriculum_cubit.dart';
import 'package:edufocus/core/bloc/curriculum_state.dart';
import 'package:edufocus/core/utils/lego_character_helper.dart';
import 'package:edufocus/core/utils/widgets/lego_character_widget.dart';
import 'package:edufocus/generated/l10n.dart';

class ProfileUserCard extends StatelessWidget {
  const ProfileUserCard({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CurriculumCubit, CurriculumState>(
      builder: (context, state) {
        final profile = state is CurriculumLoaded ? state.childProfile : null;
        final name = profile?.name ?? 'Champ';
        final age = profile?.age ?? 5;

        return FutureBuilder<Map<String, dynamic>>(
          future: LegoCharacterHelper.loadConfig(),
          builder: (context, legoSnapshot) {
            final config = legoSnapshot.data;
            final headIndex = profile?.equippedAvatar?.headIndex ?? config?['headIndex'] ?? 1;
            final hairIndex = profile?.equippedAvatar?.hairIndex ?? config?['hairIndex'] ?? 1;
            final bodyIndex = profile?.equippedAvatar?.bodyIndex ?? config?['bodyIndex'] ?? 1;
            final legIndex = profile?.equippedAvatar?.legIndex ?? config?['legIndex'] ?? 1;
            final hatIndex = profile?.equippedAvatar?.hatIndex ?? config?['hatIndex'] ?? 0;

            return Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [context.colors.brandBlue, const Color(0xFF5B9BD5)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    color: context.colors.brandBlue.withOpacity(0.3),
                    blurRadius: 16,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Container(
                    height: 120,
                    alignment: Alignment.center,
                    child: LegoCharacterWidget(
                      headIndex: headIndex,
                      hairIndex: hairIndex,
                      bodyIndex: bodyIndex,
                      legIndex: legIndex,
                      hatIndex: hatIndex,
                      size: 64,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    name,
                    style: const TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.w900,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: context.colors.brandYellow,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      '${S.of(context).profileUserAge(age)} · ${S.of(context).profileHeroTitle}',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w800,
                        color: AppColors.slate900,
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
