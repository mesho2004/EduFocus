import 'package:edufocus/core/utils/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:edufocus/core/themes/app_colors.dart';
import 'package:edufocus/features/auth/widgets/auth_primary_button.dart';
import 'package:edufocus/features/auth/widgets/auth_footer_note.dart';

// // ─────────────────────────────────────────────────────────────────────────────
// // Avatar data: emoji + background colour pairs
// // ─────────────────────────────────────────────────────────────────────────────
// const _kAvatars = [
//   (emoji: '🦁', bg: Color(0xFFFFF0C8)),
//   (emoji: '🐸', bg: Color(0xFFD4F4DD)),
//   (emoji: '🦄', bg: Color(0xFFF3E5FF)),
//   (emoji: '🐼', bg: Color(0xFFE0F0FF)),
// ];

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
    Navigator.pushReplacementNamed(context, '/parent_pin_creation');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      appBar: AppBar(
        backgroundColor: AppColors.backgroundLight,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'New Explorer',
          style: TextStyle(
            color: AppColors.slate900,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: Navigator.canPop(context)
            ? IconButton(
                icon: const Icon(
                  Icons.arrow_back_ios_new_rounded,
                  color: AppColors.slate700,
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

                    // ── Avatar row ─────────────────────────────────────────
                    // Center(
                    //   child: Row(
                    //     mainAxisAlignment: MainAxisAlignment.center,
                    //     children: List.generate(
                    //       _kAvatars.length,
                    //       (i) => _AvatarBubble(
                    //         emoji: _kAvatars[i].emoji,
                    //         bgColor: _kAvatars[i].bg,
                    //         isSelected: i == _selectedAvatarIndex,
                    //         onTap: () =>
                    //             setState(() => _selectedAvatarIndex = i),
                    //       ),
                    //     ),
                    //   ),
                    // ),
                    // const SizedBox(height: 20),

                    // ── Heading ────────────────────────────────────────────
                    const Center(
                      child: Text(
                        "Let's set up your profile!",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: AppColors.slate900,
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                          letterSpacing: -0.5,
                        ),
                      ),
                    ),
                    const SizedBox(height: 28),

                    // ── Name field ─────────────────────────────────────────
                    const Text(
                      "What is your hero's name?",
                      style: TextStyle(
                        color: AppColors.slate700,
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
                    const Text(
                      'How old are you?',
                      style: TextStyle(
                        color: AppColors.slate700,
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
                    const Text(
                      'Control Method',
                      style: TextStyle(
                        color: AppColors.slate700,
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
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// _AvatarBubble
// ─────────────────────────────────────────────────────────────────────────────
// class _AvatarBubble extends StatelessWidget {
//   final String emoji;
//   final Color bgColor;
//   final bool isSelected;
//   final VoidCallback onTap;

//   const _AvatarBubble({
//     required this.emoji,
//     required this.bgColor,
//     required this.isSelected,
//     required this.onTap,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: onTap,
//       child: AnimatedContainer(
//         duration: const Duration(milliseconds: 200),
//         margin: const EdgeInsets.symmetric(horizontal: 8),
//         width: 64,
//         height: 64,
//         decoration: BoxDecoration(
//           color: bgColor,
//           shape: BoxShape.circle,
//           border: Border.all(
//             color: isSelected ? AppColors.brandBlue : Colors.transparent,
//             width: 3,
//           ),
//           boxShadow: isSelected
//               ? [
//                   BoxShadow(
//                     color: AppColors.brandBlue.withOpacity(0.3),
//                     blurRadius: 10,
//                     offset: const Offset(0, 4),
//                   ),
//                 ]
//               : [],
//         ),
//         alignment: Alignment.center,
//         child: Text(
//           emoji,
//           style: const TextStyle(fontSize: 30),
//         ),
//       ),
//     );
//   }
// }

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
              color: isSelected ? Colors.white : AppColors.slate600,
              fontWeight: FontWeight.bold,
              fontSize: 15,
            ),
          ),
          selected: isSelected,
          onSelected: (_) => onSelected(a.value),
          selectedColor: AppColors.brandGreen,
          backgroundColor: AppColors.slate100.withValues(alpha: 0.3),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: BorderSide(
              color: isSelected ? AppColors.brandGreen : AppColors.slate200,
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
        color: AppColors.slate100.withValues(alpha: 0.3),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.slate200),
      ),
      child: SwitchListTile.adaptive(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        title: const Text(
          'Enable Eye Control',
          style: TextStyle(
            color: AppColors.slate900,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        subtitle: const Padding(
          padding: EdgeInsets.only(top: 4),
          child: Text(
            'For heroes with motor challenges. Uses camera to play games via eye movement.',
            style: TextStyle(
              color: AppColors.slate500,
              fontSize: 12,
              height: 1.4,
            ),
          ),
        ),
        value: value,
        onChanged: onChanged,
        activeColor: AppColors.brandGreen,
        secondary: Container(
          width: 42,
          height: 42,
          decoration: BoxDecoration(
            color: value
                ? AppColors.brandBlue.withOpacity(0.12)
                : AppColors.slate200,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(
            Icons.remove_red_eye_outlined,
            color: value ? AppColors.brandGreen : AppColors.slate400,
            size: 22,
          ),
        ),
      ),
    );
  }
}
