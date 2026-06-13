import 'package:flutter/material.dart';
import 'package:edufocus/core/routes/app_routes.dart';
import 'package:edufocus/features/auth/presentation/child/create_child_profile.dart';
import 'package:edufocus/features/auth/presentation/forgot%20password/forgot_password_screen.dart';
import 'package:edufocus/features/auth/otp_screen.dart';
import 'package:edufocus/features/lessons/lessons_path_screen.dart';
import 'package:edufocus/features/auth/presentation/parent/parent_auth_screen.dart';
import 'package:edufocus/features/splash_screen.dart';
import 'package:edufocus/features/units/units_screen.dart';
import 'package:edufocus/features/game_engine/presentation/screens/game_engine_screen.dart';
import 'package:edufocus/features/game_engine/presentation/screens/curriculum_player_screen.dart';
import 'package:edufocus/features/main_navigation_screen.dart';
import 'package:edufocus/features/profile/edit_profile_screen.dart';
import 'package:edufocus/features/onboarding/onboarding_tutorial_screen.dart';

class AppRouter {
  static Map<String, WidgetBuilder> get routes => {
        AppRoutes.splash: (context) => const SplashScreen(),
        AppRoutes.registration: (context) => const CreateChildProfile(),
        AppRoutes.parentAuth: (context) => const ParentAuthScreen(),
        AppRoutes.subjectsGridView: (context) =>
            const MainNavigationScreen(initialIndex: 0),
        AppRoutes.units: (context) => const UnitsScreen(),
        AppRoutes.lessonsPath: (context) => const LessonsPathScreen(),
        AppRoutes.gameEngine: (context) => const GameEngineScreen(),
        AppRoutes.curriculumPlayer: (context) => const CurriculumPlayerScreen(),
        AppRoutes.profile: (context) =>
            const MainNavigationScreen(initialIndex: 2),
        AppRoutes.progress: (context) =>
            const MainNavigationScreen(initialIndex: 1),
        AppRoutes.editProfile: (context) => const EditProfileScreen(),
        AppRoutes.forgotPassword: (context) => const ForgotPasswordScreen(),
        AppRoutes.resetPassword: (context) => const OtpScreen(),
        AppRoutes.onboardingTutorial: (context) =>
            const OnboardingTutorialScreen(),
      };
}
