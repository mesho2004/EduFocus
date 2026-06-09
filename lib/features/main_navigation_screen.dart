import 'package:edufocus/features/profile/profile_screen.dart';
import 'package:edufocus/features/progress/progress_screen.dart';
import 'package:edufocus/features/subjects/subjects_grid_view_screen.dart';
import 'package:edufocus/widgets/custom_bottom_nav_bar.dart';
import 'package:flutter/material.dart';

class MainNavigationScreen extends StatefulWidget {
  final int initialIndex;

  const MainNavigationScreen({
    super.key,
    this.initialIndex = 0,
  });

  @override
  State<MainNavigationScreen> createState() => MainNavigationScreenState();
}

class MainNavigationScreenState extends State<MainNavigationScreen> {
  late int _currentIndex;

  final List<Widget> _screens = const [
    SubjectsGridViewScreen(),
    ProgressScreen(),
    ProfileScreen(),
  ];

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;
  }

  void setIndex(int index) {
    if (index >= 0 && index < _screens.length) {
      setState(() {
        _currentIndex = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _screens,
      ),
      bottomSheet: CustomBottomNavBar(
        currentIndex: _currentIndex,
        onTap: setIndex,
      ),
    );
  }
}
