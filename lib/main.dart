import 'package:edufocus/core/themes/app_colors.dart';
import 'package:edufocus/features/auth/registration_screen.dart';
import 'package:edufocus/features/lessons/lessons_path_screen.dart';
import 'package:edufocus/features/dashboard/parent_dashboard_screen.dart';
import 'package:edufocus/features/auth/parent_auth_screen.dart';
import 'package:edufocus/features/auth/parent_pin_creation_screen.dart';
import 'package:edufocus/features/splash_screen.dart';
import 'package:edufocus/features/subjects/subjects_grid_view_screen.dart';
import 'package:edufocus/features/units/units_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'features/game_engine/presentation/screens/game_engine_screen.dart';
import 'features/game_engine/presentation/screens/curriculum_player_screen.dart';
import 'features/profile/profile_screen.dart';
import 'features/progress/progress_screen.dart';
void main() {
  runApp(const EdufocusApp());
}

class EdufocusApp extends StatelessWidget {
  const EdufocusApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        primaryColor: AppColors.primary,
        scaffoldBackgroundColor: AppColors.backgroundLight,
        textTheme: GoogleFonts.lexendTextTheme(),
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.primary,
          surface: AppColors.backgroundLight,
        ),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashScreen(),
        '/registration': (context) => const RegistrationScreen(),
        '/parent_auth': (context) => const ParentAuthScreen(),
        '/parent_pin_creation': (context) => const ParentPinCreationScreen(),
        '/parent_dashboard': (context) => const ParentDashboardScreen(),
        '/subjects_grid_view': (context) => const SubjectsGridViewScreen(),
        '/units': (context) => const UnitsScreen(),
        '/lessons_path': (context) => const LessonsPathScreen(),
        '/game_engine': (context) => const GameEngineScreen(),
        '/curriculum_player': (context) => const CurriculumPlayerScreen(),
        '/profile': (context) => const ProfileScreen(),
        '/progress': (context) => const ProgressScreen(),
      },
    );
  }
}
