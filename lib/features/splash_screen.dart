import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:edufocus/core/themes/app_theme.dart';
import 'package:edufocus/core/widgets/edufocus_logo.dart';
import 'package:edufocus/features/auth/cubit/auth_cubit.dart';
import 'package:edufocus/features/auth/cubit/auth_state.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool _timerFinished = false;
  bool _navigationHandled = false;

  @override
  void initState() {
    super.initState();
    context.read<AuthCubit>().checkAuthStatus();
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        setState(() {
          _timerFinished = true;
        });
        _tryNavigating();
      }
    });
  }

  void _tryNavigating() {
    if (_navigationHandled) return;
    final state = context.read<AuthCubit>().state;
    if (state is! AuthInitial && state is! AuthLoading && _timerFinished) {
      _navigationHandled = true;
      if (state is AuthSuccess) {
        if (state.hasChild) {
          Navigator.pushReplacementNamed(context, '/subjects_grid_view');
        } else {
          Navigator.pushReplacementNamed(context, '/registration');
        }
      } else {
        Navigator.pushReplacementNamed(context, '/parent_auth');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        _tryNavigating();
      },
      child: Scaffold(
        backgroundColor: context.colors.background,
        body: Stack(
          children: [
            // Background Decorative Elements
            Positioned(
              top: 50,
              left: -40,
              child: _buildFloatingCircle(
                size: 150,
                color: context.colors.brandYellow.withOpacity(0.2),
              ),
            ),
            Positioned(
              bottom: 100,
              right: -60,
              child: _buildFloatingCircle(
                size: 200,
                color: context.colors.brandCyan.withOpacity(0.2),
              ),
            ),
            Positioned(
              top: MediaQuery.of(context).size.height * 0.4,
              left: 30,
              child: _buildFloatingCircle(
                size: 40,
                color: context.colors.brandRed.withOpacity(0.3),
              ),
            ),
            Positioned(
              top: MediaQuery.of(context).size.height * 0.2,
              right: 80,
              child: _buildFloatingCircle(
                size: 20,
                color: context.colors.brandGreen.withOpacity(0.4),
              ),
            ),
            Positioned(
              bottom: MediaQuery.of(context).size.height * 0.3,
              right: 40,
              child: _buildFloatingCircle(
                size: 60,
                color: context.colors.brandPurple.withOpacity(0.2),
              ),
            ),

            // Main Content
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const EduFocusLogo(fontSize: 48),
                  const SizedBox(height: 16),
                  Text(
                    'Learning that feels like playing.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: context.colors.textSecondary,
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }


  Widget _buildFloatingCircle({required double size, required Color color}) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(shape: BoxShape.circle, color: color),
    );
  }
}
