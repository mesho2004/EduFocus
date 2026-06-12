import 'package:edufocus/features/units/widgets/subject_sliver_header.dart';
import 'package:edufocus/features/units/widgets/unit_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:edufocus/core/themes/app_theme.dart';
import 'package:edufocus/core/data/curriculum_data.dart';
import 'package:edufocus/core/bloc/curriculum_cubit.dart';
import 'package:edufocus/core/bloc/curriculum_state.dart';
import 'package:edufocus/core/routes/app_routes.dart';

class UnitsScreen extends StatelessWidget {
  const UnitsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final initialSubject =
        ModalRoute.of(context)!.settings.arguments as SubjectData;

    return BlocBuilder<CurriculumCubit, CurriculumState>(
      builder: (context, state) {
        final subject = state is CurriculumLoaded
            ? state.subjects.firstWhere(
                (s) => s.id == initialSubject.id,
                orElse: () => initialSubject,
              )
            : initialSubject;

        return Directionality(
          textDirection: subject.isRtl ? TextDirection.rtl : TextDirection.ltr,
          child: Scaffold(
            backgroundColor: context.colors.background,
            body: CustomScrollView(
              slivers: [
                SubjectSliverHeader(subject: subject),

                SliverPadding(
                  padding: const EdgeInsets.fromLTRB(20, 16, 20, 40),
                  sliver: SliverList(
                    delegate: SliverChildBuilderDelegate((context, i) {
                      final unit = subject.units[i];
                      final isLast = i == subject.units.length - 1;
                      return Padding(
                        padding: EdgeInsets.only(bottom: isLast ? 0 : 16),
                        child: UnitCard(
                          unit: unit,
                          index: i,
                          subject: subject,
                          onTap: () => Navigator.pushNamed(
                            context,
                            AppRoutes.lessonsPath,
                            arguments: {'subject': subject, 'unit': unit},
                          ),
                        ),
                      );
                    }, childCount: subject.units.length),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
