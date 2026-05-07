import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:edufocus/core/themes/app_colors.dart';
import 'package:edufocus/core/widgets/edufocus_logo.dart';

// ─────────────────────────────────────────────────────────────────────────────
// ParentPinCreationScreen
//
// Onboarding step that lets a parent set a 4-digit PIN.
// Uses a fully custom numeric keypad so the system keyboard never appears.
// ─────────────────────────────────────────────────────────────────────────────
class ParentPinCreationScreen extends StatefulWidget {
  const ParentPinCreationScreen({super.key});

  @override
  State<ParentPinCreationScreen> createState() =>
      _ParentPinCreationScreenState();
}

class _ParentPinCreationScreenState extends State<ParentPinCreationScreen>
    with SingleTickerProviderStateMixin {
  // ── State ──────────────────────────────────────────────────────────────────
  String _pin = '';

  // Shake animation for wrong-length submission attempt
  late final AnimationController _shakeCtrl;
  late final Animation<double> _shakeAnim;


  @override
  void initState() {
    super.initState();
    _shakeCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );
    _shakeAnim = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _shakeCtrl, curve: Curves.elasticIn),
    );
  }

  @override
  void dispose() {
    _shakeCtrl.dispose();
    super.dispose();
  }

  // ── Logic ──────────────────────────────────────────────────────────────────
  void _onDigit(String digit) {
    if (_pin.length >= 4) return;
    HapticFeedback.lightImpact();
    setState(() => _pin += digit);

    if (_pin.length == 4) {
      _onPinComplete();
    }
  }

  void _onBackspace() {
    if (_pin.isEmpty) return;
    HapticFeedback.selectionClick();
    setState(() => _pin = _pin.substring(0, _pin.length - 1));
  }

  void _onPinComplete() {
    // TODO: Replace with secure_storage save logic (e.g. FlutterSecureStorage).
    // ignore: avoid_print
    print('PIN created: $_pin');

    // Brief delay so user sees 4 filled dots before navigation.
    Future.delayed(const Duration(milliseconds: 350), () {
      if (!mounted) return;
      // Navigate to next onboarding/dashboard step:
      Navigator.pushReplacementNamed(context, '/subjects_grid_view');
    });
  }

  // ─────────────────────────────────────────────────────────────────────────
  // Build
  // ─────────────────────────────────────────────────────────────────────────
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF8F0), // warm cream, child-friendly
      body: SafeArea(
        child: Column(
          children: [
            // ── Top section (logo + header) ──────────────────────────────
            Expanded(
              flex: 4,
              child: _HeaderSection(pin: _pin, shakeAnim: _shakeAnim),
            ),

            // ── Custom numpad ────────────────────────────────────────────
            Expanded(
              flex: 6,
              child: _NumPad(
                onDigit: _onDigit,
                onBackspace: _onBackspace,
              ),
            ),

            const SizedBox(height: 12),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// _HeaderSection  –  logo + title + subtitle + PIN dots
// ─────────────────────────────────────────────────────────────────────────────
class _HeaderSection extends StatelessWidget {
  final String pin;
  final Animation<double> shakeAnim;

  const _HeaderSection({required this.pin, required this.shakeAnim});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 28),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Logo (static variant)
          const EduFocusLogo(fontSize: 26, animate: false),
          const SizedBox(height: 20),

          // Shield icon badge
          Container(
            width: 64,
            height: 64,
            decoration: BoxDecoration(
              color: AppColors.brandBlue.withValues(alpha: 0.12),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.shield_rounded,
              size: 34,
              color: AppColors.brandBlue,
            ),
          ),
          const SizedBox(height: 16),

          // Title
          const Text(
            'Secure Parent Settings',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: AppColors.slate900,
              fontSize: 22,
              fontWeight: FontWeight.w800,
              letterSpacing: -0.3,
            ),
          ),
          const SizedBox(height: 8),

          // Subtitle
          const Text(
            'Create a 4-digit PIN to prevent your child\nfrom exiting the game or changing settings.',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: AppColors.slate500,
              fontSize: 13,
              height: 1.55,
            ),
          ),
          const SizedBox(height: 28),

          // PIN dots row (with shake on error)
          AnimatedBuilder(
            animation: shakeAnim,
            builder: (_, child) {
              final dx = shakeAnim.value == 0
                  ? 0.0
                  : 8.0 *
                      (0.5 - shakeAnim.value).abs() *
                      (shakeAnim.value < 0.5 ? 1 : -1);
              return Transform.translate(
                offset: Offset(dx, 0),
                child: child,
              );
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(4, (i) => _PinDot(filled: i < pin.length)),
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// _PinDot  –  single animated dot indicator
// ─────────────────────────────────────────────────────────────────────────────
class _PinDot extends StatelessWidget {
  final bool filled;

  const _PinDot({required this.filled});

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 220),
      curve: Curves.easeOutBack,
      margin: const EdgeInsets.symmetric(horizontal: 10),
      width: filled ? 20 : 18,
      height: filled ? 20 : 18,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: filled ? AppColors.brandBlue : Colors.transparent,
        border: Border.all(
          color: filled ? AppColors.brandBlue : AppColors.slate300,
          width: 2.2,
        ),
        boxShadow: filled
            ? [
                BoxShadow(
                  color: AppColors.brandBlue.withValues(alpha: 0.35),
                  blurRadius: 8,
                  spreadRadius: 1,
                ),
              ]
            : [],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// _NumPad  –  fully custom 3×4 numeric keypad
// Layout:
//   1  2  3
//   4  5  6
//   7  8  9
//   _  0  ⌫
// ─────────────────────────────────────────────────────────────────────────────
class _NumPad extends StatelessWidget {
  final ValueChanged<String> onDigit;
  final VoidCallback onBackspace;

  const _NumPad({required this.onDigit, required this.onBackspace});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          // Rows 1-9
          for (final row in [
            ['1', '2', '3'],
            ['4', '5', '6'],
            ['7', '8', '9'],
          ])
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: row
                  .map(
                    (d) => _DigitButton(
                      digit: d,
                      onTap: () => onDigit(d),
                    ),
                  )
                  .toList(),
            ),

          // Bottom row: empty | 0 | backspace
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // Empty placeholder (same size as a button, invisible)
              const SizedBox(width: 72, height: 72),

              _DigitButton(digit: '0', onTap: () => onDigit('0')),

              _BackspaceButton(onTap: onBackspace),
            ],
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// _DigitButton  –  large circular numpad key
// ─────────────────────────────────────────────────────────────────────────────
class _DigitButton extends StatefulWidget {
  final String digit;
  final VoidCallback onTap;

  const _DigitButton({required this.digit, required this.onTap});

  @override
  State<_DigitButton> createState() => _DigitButtonState();
}

class _DigitButtonState extends State<_DigitButton>
    with SingleTickerProviderStateMixin {
  late final AnimationController _scaleCtrl;
  late final Animation<double> _scaleAnim;

  @override
  void initState() {
    super.initState();
    _scaleCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 120),
      lowerBound: 0.88,
      upperBound: 1.0,
      value: 1.0,
    );
    _scaleAnim = _scaleCtrl;
  }

  @override
  void dispose() {
    _scaleCtrl.dispose();
    super.dispose();
  }

  Future<void> _onTapDown(_) async {
    await _scaleCtrl.reverse();
  }

  Future<void> _onTapUp(_) async {
    await _scaleCtrl.forward();
    widget.onTap();
  }

  void _onTapCancel() => _scaleCtrl.forward();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: _onTapDown,
      onTapUp: _onTapUp,
      onTapCancel: _onTapCancel,
      child: ScaleTransition(
        scale: _scaleAnim,
        child: Container(
          width: 72,
          height: 72,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: AppColors.slate300.withValues(alpha: 0.6),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          alignment: Alignment.center,
          child: Text(
            widget.digit,
            style: const TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.w700,
              color: AppColors.slate900,
            ),
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// _BackspaceButton  –  circular delete key
// ─────────────────────────────────────────────────────────────────────────────
class _BackspaceButton extends StatefulWidget {
  final VoidCallback onTap;

  const _BackspaceButton({required this.onTap});

  @override
  State<_BackspaceButton> createState() => _BackspaceButtonState();
}

class _BackspaceButtonState extends State<_BackspaceButton>
    with SingleTickerProviderStateMixin {
  late final AnimationController _scaleCtrl;

  @override
  void initState() {
    super.initState();
    _scaleCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 120),
      lowerBound: 0.88,
      upperBound: 1.0,
      value: 1.0,
    );
  }

  @override
  void dispose() {
    _scaleCtrl.dispose();
    super.dispose();
  }

  Future<void> _onTapDown(_) async => _scaleCtrl.reverse();
  Future<void> _onTapUp(_) async {
    await _scaleCtrl.forward();
    widget.onTap();
  }

  void _onTapCancel() => _scaleCtrl.forward();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: _onTapDown,
      onTapUp: _onTapUp,
      onTapCancel: _onTapCancel,
      child: ScaleTransition(
        scale: _scaleCtrl,
        child: Container(
          width: 72,
          height: 72,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.brandRed.withValues(alpha: 0.10),
            boxShadow: [
              BoxShadow(
                color: AppColors.brandRed.withValues(alpha: 0.12),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          alignment: Alignment.center,
          child: const Icon(
            Icons.backspace_rounded,
            size: 26,
            color: AppColors.brandRed,
          ),
        ),
      ),
    );
  }
}
