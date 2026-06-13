import 'package:flutter/material.dart';
import 'package:edufocus/core/themes/app_theme.dart';
import 'package:edufocus/core/caching/app_shared_pref.dart';
import 'package:edufocus/core/caching/app_shared_pref_key.dart';
import 'package:edufocus/core/routes/app_routes.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:edufocus/features/auth/data/cubit/auth_cubit.dart';
import 'package:edufocus/features/auth/data/cubit/auth_state.dart';
import 'package:edufocus/generated/l10n.dart';

import 'widgets/onboarding_background.dart';
import 'widgets/onboarding_header.dart';
import 'widgets/onboarding_slide_card.dart';
import 'widgets/onboarding_navigation.dart';

class OnboardingTutorialScreen extends StatefulWidget {
  const OnboardingTutorialScreen({super.key});

  @override
  State<OnboardingTutorialScreen> createState() =>
      _OnboardingTutorialScreenState();
}

class _OnboardingTutorialScreenState extends State<OnboardingTutorialScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<OnboardingSlideData> _slides = [
    OnboardingSlideData(
      title: "",
      description: "",
      emoji: "🌟",
      colorName: "brandYellow",
    ),
    OnboardingSlideData(
      title: "",
      description: "",
      emoji: "🎒",
      colorName: "brandCyan",
    ),
    OnboardingSlideData(
      title: "",
      description: "",
      emoji: "🧩",
      colorName: "brandPurple",
    ),
    OnboardingSlideData(
      title: "",
      description: "",
      emoji: "👑",
      colorName: "brandGreen",
    ),
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _completeOnboarding() async {
    await AppSharedPref.setPref(
      value: true,
      key: AppSharedPrefKey.onboardingCompletedKey,
    );
    if (!mounted) return;
    final state = context.read<AuthCubit>().state;
    if (state is AuthSuccess) {
      if (state.hasChild) {
        Navigator.pushReplacementNamed(context, AppRoutes.subjectsGridView);
      } else {
        Navigator.pushReplacementNamed(context, AppRoutes.registration);
      }
    } else {
      Navigator.pushReplacementNamed(context, AppRoutes.parentAuth);
    }
  }

  void _onNextPage() {
    if (_currentPage < _slides.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    } else {
      _completeOnboarding();
    }
  }

  Color _getSlideColor(String name) {
    switch (name) {
      case "brandYellow":
        return context.colors.brandYellow;
      case "brandCyan":
        return context.colors.brandCyan;
      case "brandPurple":
        return context.colors.brandPurple;
      case "brandGreen":
        return context.colors.brandGreen;
      default:
        return context.colors.primary;
    }
  }

  String _getSlideTitle(BuildContext context, int index) {
    switch (index) {
      case 0:
        return S.of(context).onboardingHiChampTitle;
      case 1:
        return S.of(context).onboardingSubjectTitle;
      case 2:
        return S.of(context).onboardingGamesTitle;
      case 3:
        return S.of(context).onboardingStarsTitle;
      default:
        return "";
    }
  }

  String _getSlideDesc(BuildContext context, int index) {
    switch (index) {
      case 0:
        return S.of(context).onboardingHiChampDesc;
      case 1:
        return S.of(context).onboardingSubjectDesc;
      case 2:
        return S.of(context).onboardingGamesDesc;
      case 3:
        return S.of(context).onboardingStarsDesc;
      default:
        return "";
    }
  }

  @override
  Widget build(BuildContext context) {
    final activeColor = _getSlideColor(_slides[_currentPage].colorName);

    return Scaffold(
      backgroundColor: context.colors.background,
      body: Stack(
        children: [
          OnboardingBackground(slideColor: activeColor),
          SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                OnboardingHeader(onSkipPressed: _completeOnboarding),
                Expanded(
                  child: PageView.builder(
                    controller: _pageController,
                    itemCount: _slides.length,
                    onPageChanged: (index) {
                      setState(() {
                        _currentPage = index;
                      });
                    },
                    itemBuilder: (context, index) {
                      final slide = _slides[index];
                      final localizedSlide = OnboardingSlideData(
                        title: _getSlideTitle(context, index),
                        description: _getSlideDesc(context, index),
                        emoji: slide.emoji,
                        colorName: slide.colorName,
                      );
                      return OnboardingSlideCard(
                        slide: localizedSlide,
                        slideColor: _getSlideColor(slide.colorName),
                      );
                    },
                  ),
                ),
                OnboardingNavigation(
                  currentPage: _currentPage,
                  totalPages: _slides.length,
                  activeColor: activeColor,
                  onNextPressed: _onNextPage,
                  dotBuilder: _buildDot,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDot(int index) {
    final isSelected = _currentPage == index;
    final dotColor = _getSlideColor(_slides[_currentPage].colorName);
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      margin: const EdgeInsets.symmetric(horizontal: 4.0),
      height: 10,
      width: isSelected ? 24 : 10,
      decoration: BoxDecoration(
        color: isSelected ? dotColor : context.colors.border,
        borderRadius: BorderRadius.circular(5),
      ),
    );
  }
}

class OnboardingSlideData {
  final String title;
  final String description;
  final String emoji;
  final String colorName;

  OnboardingSlideData({
    required this.title,
    required this.description,
    required this.emoji,
    required this.colorName,
  });
}
