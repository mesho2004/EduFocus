import 'package:edufocus/core/themes/app_colors.dart';
import 'package:edufocus/widgets/custom_bottom_nav_bar.dart';
import 'package:flutter/material.dart';

class ProgressScreen extends StatelessWidget {
  const ProgressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      appBar: AppBar(
        backgroundColor: AppColors.backgroundLight,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'My Progress',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w900,
            color: AppColors.slate900,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 16, 20, 100),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildHeroSection(),
              const SizedBox(height: 32),
              _buildSectionTitle('Learning Map', Icons.map_rounded, AppColors.brandBlue),
              const SizedBox(height: 16),
              _buildLearningMap(),
              const SizedBox(height: 32),
              _buildSectionTitle('Trophy Room', Icons.emoji_events_rounded, AppColors.brandYellow),
              const SizedBox(height: 16),
              _buildTrophyRoom(),
              const SizedBox(height: 32),
              _buildSectionTitle('Jump Back In', Icons.play_circle_fill_rounded, AppColors.brandRed),
              const SizedBox(height: 16),
              _buildJumpBackInCard(context),
            ],
          ),
        ),
      ),
      bottomSheet: CustomBottomNavBar(
        currentIndex: 1,
        onTap: (index) {
          if (index == 0) {
            Navigator.pushReplacementNamed(context, '/subjects_grid_view');
          } else if (index == 2) {
            Navigator.pushReplacementNamed(context, '/profile');
          }
        },
      ),
    );
  }

  Widget _buildSectionTitle(String title, IconData icon, Color color) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: color.withOpacity(0.15),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, color: color, size: 24),
        ),
        const SizedBox(width: 12),
        Text(
          title,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w800,
            color: AppColors.slate900,
          ),
        ),
      ],
    );
  }

  Widget _buildHeroSection() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF8B59A7), Color(0xFF6B4282)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF8B59A7).withOpacity(0.3),
            blurRadius: 16,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildHeroStat(
                icon: '🔥',
                label: 'Streak',
                value: '3 Days',
                color: AppColors.brandOrange,
              ),
              Container(
                width: 2,
                height: 50,
                color: Colors.white.withOpacity(0.2),
              ),
              _buildHeroStat(
                icon: '⭐',
                label: 'Coins',
                value: '1,250',
                color: AppColors.brandYellow,
              ),
            ],
          ),
          const SizedBox(height: 24),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text(
                    'Level 5 - Letter Hero',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    '80%',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w900,
                      color: AppColors.brandYellow,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: LinearProgressIndicator(
                  value: 0.8,
                  backgroundColor: Colors.white.withOpacity(0.2),
                  valueColor: const AlwaysStoppedAnimation<Color>(
                    AppColors.brandYellow,
                  ),
                  minHeight: 14,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildHeroStat({
    required String icon,
    required String label,
    required String value,
    required Color color,
  }) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.15),
            shape: BoxShape.circle,
          ),
          child: Text(icon, style: const TextStyle(fontSize: 28)),
        ),
        const SizedBox(height: 8),
        Text(
          value,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w900,
            color: Colors.white,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: Colors.white.withOpacity(0.8),
          ),
        ),
      ],
    );
  }

  Widget _buildLearningMap() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: AppColors.slate200, width: 2),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Path line
          Positioned.fill(
            child: Align(
              alignment: Alignment.center,
              child: Container(
                width: 8,
                decoration: BoxDecoration(
                  color: AppColors.slate200,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ),
          ),
          Positioned.fill(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: FractionallySizedBox(
                heightFactor: 0.65, // filled up to the current active node
                alignment: Alignment.bottomCenter,
                child: Container(
                  width: 8,
                  decoration: BoxDecoration(
                    color: AppColors.brandGreen,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
            ),
          ),
          // Nodes
          Column(
            children: [
              _buildMapNode(
                title: 'Sentences',
                isLocked: true,
                isActive: false,
                isCompleted: false,
                color: AppColors.slate300,
                icon: Icons.lock_rounded,
                alignment: Alignment.centerRight,
              ),
              const SizedBox(height: 32),
              _buildMapNode(
                title: 'Words II',
                isLocked: true,
                isActive: false,
                isCompleted: false,
                color: AppColors.slate300,
                icon: Icons.lock_rounded,
                alignment: Alignment.centerLeft,
              ),
              const SizedBox(height: 32),
              _buildMapNode(
                title: 'Words I',
                isLocked: false,
                isActive: true,
                isCompleted: false,
                color: AppColors.brandBlue,
                icon: Icons.play_arrow_rounded,
                alignment: Alignment.centerRight,
              ),
              const SizedBox(height: 32),
              _buildMapNode(
                title: 'Letters II',
                isLocked: false,
                isActive: false,
                isCompleted: true,
                color: AppColors.brandGreen,
                icon: Icons.check_rounded,
                alignment: Alignment.centerLeft,
              ),
              const SizedBox(height: 32),
              _buildMapNode(
                title: 'Letters I',
                isLocked: false,
                isActive: false,
                isCompleted: true,
                color: AppColors.brandGreen,
                icon: Icons.check_rounded,
                alignment: Alignment.centerRight,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMapNode({
    required String title,
    required bool isLocked,
    required bool isActive,
    required bool isCompleted,
    required Color color,
    required IconData icon,
    required Alignment alignment,
  }) {
    return Align(
      alignment: alignment,
      child: FractionallySizedBox(
        widthFactor: 0.6,
        child: Row(
          mainAxisAlignment: alignment == Alignment.centerLeft
              ? MainAxisAlignment.end
              : MainAxisAlignment.start,
          children: [
            if (alignment == Alignment.centerLeft) ...[
              _buildNodeLabel(title, isActive, color),
              const SizedBox(width: 16),
            ],
            Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                color: isLocked ? Colors.white : color,
                shape: BoxShape.circle,
                border: Border.all(
                  color: isLocked ? AppColors.slate300 : color,
                  width: 3,
                ),
                boxShadow: isActive
                    ? [
                        BoxShadow(
                          color: color.withOpacity(0.4),
                          blurRadius: 16,
                          spreadRadius: 4,
                        )
                      ]
                    : [],
              ),
              child: Center(
                child: Icon(
                  icon,
                  color: isLocked ? AppColors.slate400 : Colors.white,
                  size: 28,
                ),
              ),
            ),
            if (alignment == Alignment.centerRight) ...[
              const SizedBox(width: 16),
              _buildNodeLabel(title, isActive, color),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildNodeLabel(String title, bool isActive, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: isActive ? color.withOpacity(0.1) : Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isActive ? color : AppColors.slate200,
          width: 2,
        ),
      ),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w800,
          color: isActive ? color : AppColors.slate500,
        ),
      ),
    );
  }

  Widget _buildTrophyRoom() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: AppColors.slate200, width: 2),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: GridView.count(
        crossAxisCount: 3,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        mainAxisSpacing: 20,
        crossAxisSpacing: 16,
        childAspectRatio: 0.8,
        children: [
          _buildTrophyBadge('First Win', '🌟', true),
          _buildTrophyBadge('Speedy', '⚡', true),
          _buildTrophyBadge('Streak x3', '🔥', true),
          _buildTrophyBadge('Words', '📖', true),
          _buildTrophyBadge('Numbers', '🔢', false),
          _buildTrophyBadge('Master', '👑', false),
        ],
      ),
    );
  }

  Widget _buildTrophyBadge(String title, String emoji, bool unlocked) {
    return Column(
      children: [
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              color: unlocked
                  ? AppColors.brandYellow.withOpacity(0.2)
                  : AppColors.slate100,
              shape: BoxShape.circle,
              border: Border.all(
                color: unlocked ? AppColors.brandYellow : AppColors.slate200,
                width: 3,
              ),
              boxShadow: unlocked
                  ? [
                      BoxShadow(
                        color: AppColors.brandYellow.withOpacity(0.3),
                        blurRadius: 12,
                      )
                    ]
                  : [],
            ),
            child: Center(
              child: Opacity(
                opacity: unlocked ? 1.0 : 0.3,
                child: Text(emoji, style: const TextStyle(fontSize: 32)),
              ),
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          title,
          textAlign: TextAlign.center,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w700,
            color: unlocked ? AppColors.slate700 : AppColors.slate400,
          ),
        ),
      ],
    );
  }

  Widget _buildJumpBackInCard(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.brandRed.withOpacity(0.1),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: AppColors.brandRed.withOpacity(0.3), width: 2),
      ),
      child: Row(
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: AppColors.brandRed.withOpacity(0.2),
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: const Center(
              child: Text('🛒', style: TextStyle(fontSize: 40)),
            ),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Supermarket',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w900,
                    color: AppColors.slate900,
                  ),
                ),
                const SizedBox(height: 4),
                const Text(
                  'Continue your shopping adventure!',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: AppColors.slate600,
                  ),
                ),
                const SizedBox(height: 12),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      // Navigate back to home or the specific lesson
                      Navigator.pushReplacementNamed(context, '/subjects_grid_view');
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.brandRed,
                      foregroundColor: Colors.white,
                      elevation: 4,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    child: const Text(
                      'Play Again',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
