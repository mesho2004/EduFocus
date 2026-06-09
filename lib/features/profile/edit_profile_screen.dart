import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:edufocus/core/themes/app_theme.dart';
import 'package:edufocus/core/bloc/curriculum_cubit.dart';
import 'package:edufocus/core/bloc/curriculum_state.dart';
import 'package:edufocus/core/utils/lego_character_helper.dart';
import 'package:edufocus/core/utils/widgets/lego_character_widget.dart';
import 'package:edufocus/features/profile/widgets/lego_avatar_editor_dialog.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _nameCtrl;
  late final TextEditingController _ageCtrl;
  bool _isSaving = false;
  bool _isInitialized = false;
  LegoConfig? _legoConfig;

  @override
  void initState() {
    super.initState();
    _nameCtrl = TextEditingController();
    _ageCtrl = TextEditingController();
    _loadLegoConfig();
  }

  Future<void> _loadLegoConfig() async {
    final map = await LegoCharacterHelper.loadConfig();
    setState(() {
      _legoConfig = LegoConfig(
        headIndex: map['headIndex'] ?? 1,
        hairIndex: map['hairIndex'] ?? 1,
        bodyIndex: map['bodyIndex'] ?? 1,
        legIndex: map['legIndex'] ?? 1,
        hatIndex: map['hatIndex'] ?? 0,
        torsoColor: map['torsoColor'],
        pantsColor: map['pantsColor'],
        hairColor: map['hairColor'],
      );
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_isInitialized) {
      final state = context.read<CurriculumCubit>().state;
      if (state is CurriculumLoaded && state.childProfile != null) {
        _nameCtrl.text = state.childProfile!.name;
        _ageCtrl.text = state.childProfile!.age.toString();
      }
      _isInitialized = true;
    }
  }

  @override
  void dispose() {
    _nameCtrl.dispose();
    _ageCtrl.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isSaving = true);
    try {
      final name = _nameCtrl.text.trim();
      final age = int.parse(_ageCtrl.text.trim());

      await context.read<CurriculumCubit>().updateChildProfile(
            name: name,
            age: age,
          );

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('Profile updated successfully! ✨'),
            backgroundColor: context.colors.brandGreen,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          ),
        );
        Navigator.pop(context);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error updating profile: $e 😢'),
            backgroundColor: context.colors.brandRed,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isSaving = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colors.background,
      appBar: AppBar(
        backgroundColor: context.colors.background,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new_rounded, color: context.colors.textPrimary),
          onPressed: () => Navigator.pop(context),
        ),
        centerTitle: true,
        title: Text(
          'Edit Profile',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w900,
            color: context.colors.textPrimary,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Fun Avatar Display
                GestureDetector(
                  onTap: () async {
                    if (_legoConfig == null) return;
                    final newConfig = await Navigator.push<LegoConfig>(
                      context,
                      MaterialPageRoute(
                        fullscreenDialog: true,
                        builder: (context) => LegoAvatarEditorDialog(
                          initialConfig: _legoConfig!,
                        ),
                      ),
                    );
                    if (newConfig != null) {
                      setState(() {
                        _legoConfig = newConfig;
                      });
                    }
                  },
                  child: Center(
                    child: Stack(
                      alignment: Alignment.bottomRight,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withValues(alpha: 0.1),
                                blurRadius: 12,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: CircleAvatar(
                            radius: 54,
                            backgroundColor: context.colors.brandBlue.withValues(alpha: 0.1),
                            child: _legoConfig == null
                                ? const Center(child: CircularProgressIndicator())
                                : LegoCharacterWidget(
                                    headIndex: _legoConfig!.headIndex,
                                    hairIndex: _legoConfig!.hairIndex,
                                    bodyIndex: _legoConfig!.bodyIndex,
                                    legIndex: _legoConfig!.legIndex,
                                    hatIndex: _legoConfig!.hatIndex,
                                    torsoColor: _legoConfig!.torsoColor,
                                    pantsColor: _legoConfig!.pantsColor,
                                    hairColor: _legoConfig!.hairColor,
                                    size: 56,
                                  ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: context.colors.brandBlue,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(Icons.edit_rounded, color: Colors.white, size: 18),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 36),

                // Name Input
                Text(
                  "Child's Name",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: context.colors.textSecondary,
                  ),
                ),
                const SizedBox(height: 8),
                TextFormField(
                  controller: _nameCtrl,
                  style: TextStyle(color: context.colors.textPrimary, fontSize: 16),
                  decoration: InputDecoration(
                    hintText: 'Enter name',
                    hintStyle: TextStyle(color: context.colors.textTertiary),
                    filled: true,
                    fillColor: context.colors.cardBackground,
                    contentPadding: const EdgeInsets.all(16),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: BorderSide(color: context.colors.border, width: 1.5),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: BorderSide(color: context.colors.brandBlue, width: 2),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: BorderSide(color: context.colors.brandRed, width: 1.5),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: BorderSide(color: context.colors.brandRed, width: 2),
                    ),
                  ),
                  validator: (v) {
                    if (v == null || v.trim().isEmpty) return 'Name cannot be empty';
                    return null;
                  },
                ),
                const SizedBox(height: 24),

                // Age Input
                Text(
                  "Child's Age",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: context.colors.textSecondary,
                  ),
                ),
                const SizedBox(height: 8),
                TextFormField(
                  controller: _ageCtrl,
                  keyboardType: TextInputType.number,
                  style: TextStyle(color: context.colors.textPrimary, fontSize: 16),
                  decoration: InputDecoration(
                    hintText: 'Enter age',
                    hintStyle: TextStyle(color: context.colors.textTertiary),
                    filled: true,
                    fillColor: context.colors.cardBackground,
                    contentPadding: const EdgeInsets.all(16),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: BorderSide(color: context.colors.border, width: 1.5),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: BorderSide(color: context.colors.brandBlue, width: 2),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: BorderSide(color: context.colors.brandRed, width: 1.5),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: BorderSide(color: context.colors.brandRed, width: 2),
                    ),
                  ),
                  validator: (v) {
                    if (v == null || v.trim().isEmpty) return 'Age cannot be empty';
                    final age = int.tryParse(v.trim());
                    if (age == null || age <= 0) return 'Enter a valid positive age';
                    return null;
                  },
                ),
                const SizedBox(height: 48),

                // Save button
                SizedBox(
                  height: 56,
                  child: ElevatedButton(
                    onPressed: _isSaving ? null : _save,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: context.colors.brandBlue,
                      foregroundColor: Colors.white,
                      elevation: 4,
                      shadowColor: context.colors.brandBlue.withValues(alpha: 0.35),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18),
                      ),
                    ),
                    child: _isSaving
                        ? const SizedBox(
                            width: 24,
                            height: 24,
                            child: CircularProgressIndicator(color: Colors.white, strokeWidth: 3),
                          )
                        : const Text(
                            'Save Changes',
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800),
                          ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
