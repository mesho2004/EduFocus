import 'package:edufocus/core/themes/app_theme.dart';
import 'package:edufocus/core/utils/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:edufocus/core/themes/app_colors.dart';
import 'package:edufocus/features/auth/widgets/auth_primary_button.dart';
import 'package:edufocus/features/auth/widgets/auth_footer_note.dart';
import 'package:edufocus/features/auth/cubit/auth_cubit.dart';
import 'package:edufocus/features/auth/cubit/auth_state.dart';
import 'package:edufocus/core/bloc/curriculum_cubit.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final TextEditingController _nameController = TextEditingController();

  int _selectedAvatarIndex = 0;
  int? _selectedAge = 6;
  bool _eyeControlEnabled = false;

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  void _onStartLearning() {
    final name = _nameController.text.trim();
    if (name.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Please enter your name'),
          backgroundColor: context.colors.brandRed,
        ),
      );
      return;
    }
    context.read<AuthCubit>().addChildProfile(
      name: name,
      age: _selectedAge ?? 6,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is ChildCreateSuccess) {
          context.read<CurriculumCubit>().loadCurriculum();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Welcome, ${state.child.name}! Let\'s start learning! 🚀'),
              backgroundColor: context.colors.brandGreen,
            ),
          );
          Navigator.pushReplacementNamed(context, '/parent_pin_creation');
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
          appBar: AppBar(
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
          ),
          body: SafeArea(
            child: Column(
              children: [
                // ── Scrollable content ──────────────────────────────────────────
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 20),

                        // ── Heading ────────────────────────────────────────────
                        Center(
                          child: Text(
                            "Let's set up your profile!",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: context.colors.textPrimary,
                              fontSize: 26,
                              fontWeight: FontWeight.bold,
                              letterSpacing: -0.5,
                            ),
                          ),
                        ),
                        const SizedBox(height: 28),

                        // ── Name field ─────────────────────────────────────────
                        Text(
                          "What is your hero's name?",
                          style: TextStyle(
                            color: context.colors.textSecondary,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 10),
                        CustomTextFormField(
                          hintText: 'Type your name here...',
                          controller: _nameController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your name';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 28),

                        // ── Age selection ──────────────────────────────────────
                        Text(
                          'How old are you?',
                          style: TextStyle(
                            color: context.colors.textSecondary,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 12),
                        _AgeChipRow(
                          selectedAge: _selectedAge,
                          onSelected: (age) => setState(() => _selectedAge = age),
                        ),
                        const SizedBox(height: 28),

                        // ── Control Method section ─────────────────────────────
                        Text(
                          'Control Method',
                          style: TextStyle(
                            color: context.colors.textSecondary,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 12),
                        _EyeControlTile(
                          value: _eyeControlEnabled,
                          onChanged: (v) => setState(() => _eyeControlEnabled = v),
                        ),
                        const SizedBox(height: 28),
                      ],
                    ),
                  ),
                ),

                // ── Bottom action ───────────────────────────────────────────────
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 16),
                  child: Column(
                    children: [
                      AuthPrimaryButton(
                        text: 'Start Learning',
                        onPressed: _onStartLearning,
                        trailingIcon: Icons.play_circle_fill_rounded,
                        height: 64,
                        isLoading: isLoading,
                      ),
                      const SizedBox(height: 8),
                      const AuthFooterNote(
                        text: 'Parents: You can change these later in settings',
                      ),
                    ],
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

// ─────────────────────────────────────────────────────────────────────────────
// _AgeChipRow  –  Wrap of ChoiceChips for ages 4–9+
// ─────────────────────────────────────────────────────────────────────────────
class _AgeChipRow extends StatelessWidget {
  final int? selectedAge;
  final ValueChanged<int> onSelected;

  const _AgeChipRow({required this.selectedAge, required this.onSelected});

  static const _ages = [
    (value: 4, label: '4'),
    (value: 5, label: '5'),
    (value: 6, label: '6'),
    (value: 7, label: '7'),
    (value: 8, label: '8'),
    (value: 9, label: '9+'),
  ];

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 10,
      runSpacing: 8,
      children: _ages.map((a) {
        final isSelected = a.value == selectedAge;
        return ChoiceChip(
          label: Text(
            a.label,
            style: TextStyle(
              color: isSelected ? Colors.white : context.colors.textSecondary,
              fontWeight: FontWeight.bold,
              fontSize: 15,
            ),
          ),
          selected: isSelected,
          onSelected: (_) => onSelected(a.value),
          selectedColor: context.colors.brandGreen,
          backgroundColor: context.colors.border.withOpacity(0.3),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: BorderSide(
              color: isSelected ? context.colors.brandGreen : context.colors.border,
            ),
          ),
          showCheckmark: false,
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        );
      }).toList(),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// _EyeControlTile  –  ListTile with Switch
// ─────────────────────────────────────────────────────────────────────────────
class _EyeControlTile extends StatelessWidget {
  final bool value;
  final ValueChanged<bool> onChanged;

  const _EyeControlTile({required this.value, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: context.colors.border.withOpacity(0.3),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: context.colors.border),
      ),
      child: SwitchListTile.adaptive(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        title: Text(
          'Enable Eye Control',
          style: TextStyle(
            color: context.colors.textPrimary,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 4),
          child: Text(
            'For heroes with motor challenges. Uses camera to play games via eye movement.',
            style: TextStyle(
              color: context.colors.textSecondary,
              fontSize: 12,
              height: 1.4,
            ),
          ),
        ),
        value: value,
        onChanged: onChanged,
        activeColor: context.colors.brandGreen,
        secondary: Container(
          width: 42,
          height: 42,
          decoration: BoxDecoration(
            color: value
                ? context.colors.brandBlue.withOpacity(0.12)
                : context.colors.border,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(
            Icons.remove_red_eye_outlined,
            color: value ? context.colors.brandGreen : context.colors.textTertiary,
            size: 22,
          ),
        ),
      ),
    );
  }
}
