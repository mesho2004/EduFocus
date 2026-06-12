import 'package:flutter/material.dart';
import 'package:edufocus/core/themes/app_theme.dart';
import 'package:edufocus/core/caching/app_shared_pref.dart';
import 'package:edufocus/core/caching/app_shared_pref_key.dart';
import 'package:edufocus/core/routes/app_routes.dart';

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
      title: "Hi Champ! 🚀",
      description:
          "Welcome to EduFocus! We're super excited to have you here. Let's start a fun learning adventure together!",
      emoji: "🌟",
      colorName: "brandYellow",
    ),
    OnboardingSlideData(
      title: "Choose a Subject 📚",
      description:
          "Select from English, Math, Arabic, and more. Tap on any subject to see all its units and lessons!",
      emoji: "🎒",
      colorName: "brandCyan",
    ),
    OnboardingSlideData(
      title: "Play Fun Games 🎮",
      description:
          "Complete your path by playing games like bubble popping, word matching, letter connecting, and sound puzzles!",
      emoji: "🧩",
      colorName: "brandPurple",
    ),
    OnboardingSlideData(
      title: "Stars & Customization 🪙",
      description:
          "Earn stars to purchase cool outfits for your custom Lego character. You can also enable eye-tracking in your profile!",
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
    if (mounted) {
      Navigator.pushReplacementNamed(context, AppRoutes.subjectsGridView);
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colors.background,
      body: Stack(
        children: [
          Positioned(
            top: -40,
            right: -40,
            child: _buildFloatingCircle(
              size: 200,
              color: _getSlideColor(
                _slides[_currentPage].colorName,
              ).withOpacity(0.12),
            ),
          ),
          Positioned(
            bottom: -50,
            left: -50,
            child: _buildFloatingCircle(
              size: 250,
              color: _getSlideColor(
                _slides[_currentPage].colorName,
              ).withOpacity(0.08),
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height * 0.45,
            right: 30,
            child: _buildFloatingCircle(
              size: 50,
              color: _getSlideColor(
                _slides[_currentPage].colorName,
              ).withOpacity(0.15),
            ),
          ),

          // Main Layout
          SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16.0,
                    vertical: 8.0,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: _completeOnboarding,
                        style: TextButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 8,
                          ),
                          backgroundColor: context.colors.cardBackground
                              .withOpacity(0.5),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                            side: BorderSide(color: context.colors.border),
                          ),
                        ),
                        child: Text(
                          "Skip",
                          style: TextStyle(
                            color: context.colors.textSecondary,
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

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
                      final slideColor = _getSlideColor(slide.colorName);
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 32.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: 160,
                              height: 160,
                              decoration: BoxDecoration(
                                color: slideColor.withOpacity(0.15),
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: slideColor.withOpacity(0.3),
                                  width: 4,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: slideColor.withOpacity(0.1),
                                    blurRadius: 20,
                                    offset: const Offset(0, 10),
                                  ),
                                ],
                              ),
                              child: Center(
                                child: Text(
                                  slide.emoji,
                                  style: const TextStyle(fontSize: 80),
                                ),
                              ),
                            ),
                            const SizedBox(height: 48),

                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 24,
                                vertical: 32,
                              ),
                              decoration: BoxDecoration(
                                color: context.colors.cardBackground,
                                borderRadius: BorderRadius.circular(32),
                                border: Border.all(
                                  color: context.colors.border,
                                  width: 1.5,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.04),
                                    blurRadius: 16,
                                    offset: const Offset(0, 8),
                                  ),
                                ],
                              ),
                              child: Column(
                                children: [
                                  Text(
                                    slide.title,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 26,
                                      fontWeight: FontWeight.w900,
                                      color: context.colors.textPrimary,
                                      letterSpacing: -0.5,
                                    ),
                                  ),
                                  const SizedBox(height: 16),
                                  Text(
                                    slide.description,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 16,
                                      height: 1.5,
                                      color: context.colors.textSecondary,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(32.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(
                          _slides.length,
                          (index) => _buildDot(index),
                        ),
                      ),
                      const SizedBox(height: 32),

                      GestureDetector(
                        onTap: _onNextPage,
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          padding: const EdgeInsets.symmetric(vertical: 18),
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: _getSlideColor(
                              _slides[_currentPage].colorName,
                            ),
                            borderRadius: BorderRadius.circular(24),
                            boxShadow: [
                              BoxShadow(
                                color: _getSlideColor(
                                  _slides[_currentPage].colorName,
                                ).withOpacity(0.4),
                                blurRadius: 12,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Center(
                            child: Text(
                              _currentPage == _slides.length - 1
                                  ? "Let's Play! 🚀"
                                  : "Next",
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
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

  Widget _buildFloatingCircle({required double size, required Color color}) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 500),
      width: size,
      height: size,
      decoration: BoxDecoration(shape: BoxShape.circle, color: color),
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
