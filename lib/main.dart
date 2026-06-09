import 'package:edufocus/core/themes/app_theme.dart';
import 'package:edufocus/core/caching/app_shared_pref.dart';
import 'package:edufocus/core/caching/app_shared_pref_get.dart';

import 'package:edufocus/features/auth/registration_screen.dart';
import 'package:edufocus/features/lessons/lessons_path_screen.dart';
import 'package:edufocus/features/dashboard/parent_dashboard_screen.dart';
import 'package:edufocus/features/auth/parent_auth_screen.dart';
import 'package:edufocus/features/auth/parent_pin_creation_screen.dart';
import 'package:edufocus/features/splash_screen.dart';
import 'package:edufocus/features/units/units_screen.dart';
import 'package:flutter/material.dart';
import 'features/game_engine/presentation/screens/game_engine_screen.dart';
import 'features/game_engine/presentation/screens/curriculum_player_screen.dart';
import 'features/main_navigation_screen.dart';
import 'core/bloc/stars_cubit.dart';
import 'core/bloc/curriculum_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'core/di/di.dart';
import 'core/network/api_services.dart';
import 'features/auth/cubit/auth_cubit.dart';
import 'package:edufocus/features/profile/edit_profile_screen.dart';

final ValueNotifier<bool> isDark = ValueNotifier<bool>(false);
final ValueNotifier<bool> isArabic = ValueNotifier<bool>(false);

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppSharedPref.init();
  isDark.value = AppSharedPrefGet.getTheme();
  isArabic.value = AppSharedPrefGet.getLang();
  setupGetIt();
  runApp(const EdufocusApp());
}

class EdufocusApp extends StatelessWidget {
  const EdufocusApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<StarsCubit>(
          create: (context) => StarsCubit(),
        ),
        BlocProvider<AuthCubit>(
          create: (context) => AuthCubit(apiServices: getIt<ApiServices>()),
        ),
      ],
      child: BlocProvider<CurriculumCubit>(
        create: (context) => CurriculumCubit(
          apiServices: getIt<ApiServices>(),
          starsCubit: context.read<StarsCubit>(),
        )..loadCurriculum(),
        child: ValueListenableBuilder<bool>(
          valueListenable: isDark,
          builder: (context, darkEnabled, _) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: AppTheme.lightTheme,
              darkTheme: AppTheme.darkTheme,
              themeMode: darkEnabled ? ThemeMode.dark : ThemeMode.light,
              initialRoute: '/',
              // builder: (context, child) => GazeWrapper(child: child!),
              routes: {
                '/': (context) => const SplashScreen(),
                '/registration': (context) => const RegistrationScreen(),
                '/parent_auth': (context) => const ParentAuthScreen(),
                '/parent_pin_creation': (context) => const ParentPinCreationScreen(),
                '/parent_dashboard': (context) => const ParentDashboardScreen(),
                '/subjects_grid_view': (context) => const MainNavigationScreen(initialIndex: 0),
                '/units': (context) => const UnitsScreen(),
                '/lessons_path': (context) => const LessonsPathScreen(),
                '/game_engine': (context) => const GameEngineScreen(),
                '/curriculum_player': (context) => const CurriculumPlayerScreen(),
                '/profile': (context) => const MainNavigationScreen(initialIndex: 2),
                '/progress': (context) => const MainNavigationScreen(initialIndex: 1),
                '/edit_profile': (context) => const EditProfileScreen(),
              },
            );
          },
        ),
      ),
    );
  }
}

