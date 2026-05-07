import 'package:flutter/material.dart';
import 'package:edufocus/core/themes/app_colors.dart';
import 'package:edufocus/widgets/custom_bottom_nav_bar.dart';

class ParentDashboardScreen extends StatelessWidget {
  const ParentDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Container(
              color: Colors.white.withOpacity(0.8),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24.0,
                  vertical: 16.0,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: AppColors.slate100,
                        shape: BoxShape.circle,
                      ),
                      child: IconButton(
                        icon: const Icon(Icons.menu, color: AppColors.slate600),
                        onPressed: () {},
                      ),
                    ),
                    const Text(
                      'Parent Dashboard',
                      style: TextStyle(
                        color: AppColors.slate900,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        letterSpacing: -0.5,
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: AppColors.brandPurple.withOpacity(0.1),
                        shape: BoxShape.circle,
                      ),
                      child: IconButton(
                        icon: const Icon(
                          Icons.account_circle,
                          color: AppColors.brandPurple,
                        ),
                        onPressed: () {},
                      ),
                    ),
                  ],
                ),
              ),
            ),

            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.only(
                  bottom: 96,
                ), // room for bottom nav
                child: Column(
                  children: [
                    // Profile Section
                    Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Column(
                        children: [
                          Stack(
                            alignment: Alignment.bottomRight,
                            children: [
                              Container(
                                width: 128,
                                height: 128,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: AppColors.brandPurple,
                                    width: 4,
                                  ),
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.1),
                                      blurRadius: 20,
                                      offset: const Offset(0, 4),
                                    ),
                                  ],
                                  image: const DecorationImage(
                                    image: NetworkImage(
                                      'https://lh3.googleusercontent.com/aida-public/AB6AXuCs531yP9w-5Sgm9sWWVAIdd-swnbjFVoVqUA2VuE-8kpa9tdQwLeTfGTTo_C5PHDIupgKxMSgNqlzG8GBNJ8KwNj5z5NeEE9rMwinDF3BOJmSROaVLbKMxuQRVPRqtkUNPL6RuoGLDKpvzC6MBv_na7lasOLYtqAuqcrTyrUMG3YTgH-KTYYOFk-Lor6U7M34Aq9Tx6YfE5ey50yedxsWUXqd9bNkjFsprGCoe4ccILhDblW2Z9Fb1N3Q-UpoUi4PdgDBGgm0P2oA',
                                    ),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              Container(
                                width: 24,
                                height: 24,
                                margin: const EdgeInsets.only(
                                  right: 4,
                                  bottom: 4,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.green.shade500,
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: Colors.white,
                                    width: 4,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          const Text(
                            "Alex's Progress",
                            style: TextStyle(
                              color: AppColors.slate900,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 4),
                          const Text(
                            'Keep up the great work! 🚀',
                            style: TextStyle(
                              color: AppColors.slate500,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Main Stats Grid
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: _buildStatCard(
                              title: 'Daily Streak',
                              value: '5 Days',
                              icon: Icons.local_fire_department,
                              progress: 0.6,
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: _buildStatCard(
                              title: 'Total Time',
                              value: '4.5 hrs',
                              icon: Icons.schedule,
                              progress: 0.4,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24.0),
                      child: Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(24),
                          border: Border.all(color: AppColors.slate100),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.02),
                              blurRadius: 4,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'Lessons Completed',
                                      style: TextStyle(
                                        color: AppColors.slate500,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 14,
                                      ),
                                    ),
                                    RichText(
                                      text: const TextSpan(
                                        style: TextStyle(fontFamily: 'Lexend'),
                                        children: [
                                          TextSpan(
                                            text: '12 ',
                                            style: TextStyle(
                                              color: AppColors.slate900,
                                              fontSize: 24,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          TextSpan(
                                            text: '/ 20',
                                            style: TextStyle(
                                              color: AppColors.slate400,
                                              fontSize: 14,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 8,
                                    vertical: 4,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.green.shade50,
                                    borderRadius: BorderRadius.circular(9999),
                                  ),
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.trending_up,
                                        size: 14,
                                        color: Colors.green.shade600,
                                      ),
                                      const SizedBox(width: 4),
                                      Text(
                                        '20%',
                                        style: TextStyle(
                                          color: Colors.green.shade600,
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),
                            Container(
                              height: 12,
                              decoration: BoxDecoration(
                                color: AppColors.slate100,
                                borderRadius: BorderRadius.circular(9999),
                              ),
                              child: FractionallySizedBox(
                                alignment: Alignment.centerLeft,
                                widthFactor: 0.6,
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: AppColors.brandGreen,
                                    borderRadius: BorderRadius.circular(9999),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    // Weekly Activity
                    Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Weekly Activity',
                                style: TextStyle(
                                  color: AppColors.slate900,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              TextButton(
                                style: TextButton.styleFrom(
                                  foregroundColor: AppColors.brandBlue,
                                  padding: EdgeInsets.zero,
                                  minimumSize: Size.zero,
                                  tapTargetSize:
                                      MaterialTapTargetSize.shrinkWrap,
                                ),
                                onPressed: () {},
                                child: const Text(
                                  'View History',
                                  style: TextStyle(fontWeight: FontWeight.w600),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          Container(
                            padding: const EdgeInsets.all(24),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(24),
                              border: Border.all(color: AppColors.slate100),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.02),
                                  blurRadius: 4,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                _buildBarChartCol('MON', 0.4, false),
                                _buildBarChartCol('TUE', 0.65, false),
                                _buildBarChartCol('WED', 0.55, false),
                                _buildBarChartCol('THU', 0.9, true),
                                _buildBarChartCol('FRI', 0.3, false),
                                _buildBarChartCol('SAT', 0.2, false),
                                _buildBarChartCol('SUN', 0.15, false),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Recent Achievements
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Recent Achievements',
                            style: TextStyle(
                              color: AppColors.slate900,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 16),
                          _buildAchievementCard(
                            title: 'Vocabulary Master',
                            desc: 'Completed 5 word puzzles perfectly',
                            time: '2h ago',
                            icon: Icons.emoji_events,
                            iconColor: Colors.amber.shade600,
                            iconBgColor: Colors.amber.shade100,
                          ),
                          const SizedBox(height: 12),
                          _buildAchievementCard(
                            title: 'Speed Reader',
                            desc: 'Read 3 stories in under 10 minutes',
                            time: 'Yesterday',
                            icon: Icons.auto_stories,
                            iconColor: Colors.blue.shade600,
                            iconBgColor: Colors.blue.shade100,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomSheet: CustomBottomNavBar(
        currentIndex: 0,
        onTap: (index) {
          if (index == 1) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Progress coming soon!')),
            );
          } else if (index == 2) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Profile coming soon!')),
            );
          }
        },
      ),
    );
  }

  Widget _buildStatCard({
    required String title,
    required String value,
    required IconData icon,
    required double progress,
  }) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: AppColors.slate100),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                width: 80,
                height: 80,
                child: CircularProgressIndicator(
                  value: progress,
                  strokeWidth: 6,
                  backgroundColor: AppColors.slate100,
                  valueColor: const AlwaysStoppedAnimation<Color>(
                    AppColors.brandGreen,
                  ),
                  strokeCap: StrokeCap.round,
                ),
              ),
              Icon(icon, color: AppColors.brandPurple, size: 32),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            title,
            style: const TextStyle(
              color: AppColors.slate500,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              color: AppColors.slate900,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBarChartCol(String label, double fillPct, bool isToday) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          width: 32,
          height: 128 * fillPct,
          decoration: BoxDecoration(
            color: isToday
                ? AppColors.brandGreen
                : AppColors.brandGreen.withOpacity(0.2),
            borderRadius: const BorderRadius.vertical(top: Radius.circular(6)),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: TextStyle(
            color: isToday ? AppColors.slate900 : AppColors.slate400,
            fontSize: 10,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _buildAchievementCard({
    required String title,
    required String desc,
    required String time,
    required IconData icon,
    required Color iconColor,
    required Color iconBgColor,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: AppColors.slate100),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: iconBgColor,
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: iconColor),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: AppColors.slate900,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  desc,
                  style: const TextStyle(
                    color: AppColors.slate500,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          Text(
            time,
            style: const TextStyle(color: AppColors.slate400, fontSize: 12),
          ),
        ],
      ),
    );
  }
}
