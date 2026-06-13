import 'package:edufocus/core/themes/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:edufocus/core/bloc/stars_cubit.dart';
import 'package:edufocus/core/bloc/curriculum_cubit.dart';
import 'package:edufocus/core/bloc/curriculum_state.dart';

import 'package:edufocus/generated/l10n.dart';

class SubjectScreenHeader extends StatelessWidget {
  const SubjectScreenHeader({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
      decoration: BoxDecoration(
        color: context.colors.cardBackground,
        border: Border(
          bottom: BorderSide(color: context.colors.border, width: 1),
        ),
      ),
      child: Row(
        children: [
          const SizedBox(width: 12),
          Expanded(
            child: BlocBuilder<CurriculumCubit, CurriculumState>(
              builder: (context, state) {
                String name = 'champ';
                if (state is CurriculumLoaded && state.childProfile != null) {
                  name = state.childProfile!.name;
                }
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      S.of(context).hiName(name),
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w900,
                        color: context.colors.textPrimary,
                      ),
                    ),
                    Text(
                      S.of(context).homeDescription,
                      style: TextStyle(
                        fontSize: 12,
                        color: context.colors.textTertiary,
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
          BlocBuilder<StarsCubit, int>(
            builder: (context, stars) {
              return Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: context.colors.brandYellow.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: context.colors.brandYellow.withOpacity(0.3),
                    width: 1.5,
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text('🪙', style: TextStyle(fontSize: 18)),
                    const SizedBox(width: 6),
                    Text(
                      '$stars',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w900,
                        color: context.colors.textPrimary,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
