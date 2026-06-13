import 'package:edufocus/core/themes/app_theme.dart';
import 'package:edufocus/features/auth/presentation/child/widgets/age_chip_row.dart';
import 'package:edufocus/features/auth/presentation/child/widgets/create_child_profike_appbar.dart';
import 'package:edufocus/features/auth/presentation/child/widgets/create_child_profile_button.dart';
import 'package:edufocus/features/auth/presentation/child/widgets/create_child_profile_form.dart';
import 'package:edufocus/features/auth/presentation/child/widgets/create_child_profile_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:edufocus/features/auth/data/cubit/auth_cubit.dart';
import 'package:edufocus/features/auth/data/cubit/auth_state.dart';
import 'package:edufocus/core/bloc/curriculum_cubit.dart';
import 'package:edufocus/core/caching/app_shared_pref.dart';
import 'package:edufocus/core/caching/app_shared_pref_key.dart';
import 'package:edufocus/main.dart';
import 'package:edufocus/core/routes/app_routes.dart';
import 'package:edufocus/generated/l10n.dart';

class CreateChildProfile extends StatefulWidget {
  const CreateChildProfile({super.key});

  @override
  State<CreateChildProfile> createState() => _CreateChildProfileState();
}

class _CreateChildProfileState extends State<CreateChildProfile> {
  final TextEditingController _nameController = TextEditingController();

  int? selectedAge = 6;

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  void _onStartLearning() async {
    final name = _nameController.text.trim();
    if (name.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(S.of(context).enterNameError),
          backgroundColor: context.colors.brandRed,
        ),
      );
      return;
    }

    isEyeTrackingEnabled.value = false;
    await AppSharedPref.setPref(
      value: false,
      key: AppSharedPrefKey.eyeTrackingKey,
    );

    if (mounted) {
      context.read<AuthCubit>().addChildProfile(
        name: name,
        age: selectedAge ?? 6,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is ChildCreateSuccess) {
          context.read<CurriculumCubit>().loadCurriculum();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                S.of(context).welcomeHero(state.child.name),
              ),
              backgroundColor: context.colors.brandGreen,
            ),
          );
          Navigator.pushReplacementNamed(context, AppRoutes.subjectsGridView);
        } else if (state is ChildCreateFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.errorMessage),
              backgroundColor: context.colors.brandRed,
            ),
          );
        }
      },
      builder: (context, state) {
        final isLoading = state is ChildCreateLoading;
        return Scaffold(
          backgroundColor: context.colors.background,
          appBar: CreateChildProfileAppBar(),
          body: SafeArea(
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 20),
                        CreateChildProfileHeader(),
                        const SizedBox(height: 28),
                        CreateChildProfileForm(controller: _nameController),
                        const SizedBox(height: 28),
                        Text(
                          S.of(context).howOldAreYou,
                          style: TextStyle(
                            color: context.colors.textSecondary,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 12),
                        AgeChipRow(
                          selectedAge: selectedAge,
                          onSelected: (age) =>
                              setState(() => selectedAge = age),
                        ),
                        const SizedBox(height: 28),
                      ],
                    ),
                  ),
                ),
                CreateChildProfileBottomSection(
                  isLoading: isLoading,
                  onPressed: _onStartLearning,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
