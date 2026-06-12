import 'package:edufocus/core/themes/app_theme.dart';
import 'package:edufocus/core/caching/app_shared_pref.dart';
import 'package:edufocus/core/caching/app_shared_pref_get.dart';
import 'package:flutter/material.dart';
import 'core/bloc/stars_cubit.dart';
import 'core/bloc/curriculum_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'core/di/di.dart';
import 'core/network/api_services.dart';
import 'features/auth/data/cubit/auth_cubit.dart';
import 'package:edufocus/core/services/gaze_wrapper.dart';
import 'package:edufocus/core/routes/app_routes.dart';
import 'package:edufocus/core/routes/app_router.dart';


final ValueNotifier<bool> isDark = ValueNotifier<bool>(false);
final ValueNotifier<bool> isArabic = ValueNotifier<bool>(false);
final ValueNotifier<bool> isEyeTrackingEnabled = ValueNotifier<bool>(false);

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppSharedPref.init();
  isDark.value = AppSharedPrefGet.getTheme();
  isArabic.value = AppSharedPrefGet.getLang();
  isEyeTrackingEnabled.value = AppSharedPrefGet.getEyeTracking();
  setupGetIt();
  runApp(const EdufocusApp());
}

class EdufocusApp extends StatelessWidget {
  const EdufocusApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<StarsCubit>(create: (context) => StarsCubit()),
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
              initialRoute: AppRoutes.splash,
              builder: (context, child) => GazeWrapper(child: child!),
              routes: AppRouter.routes,
            );
          },
        ),
      ),
    );
  }
}
