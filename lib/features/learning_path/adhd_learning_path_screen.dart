// import 'package:edufocus/core/themes/app_colors.dart';
// import 'package:edufocus/features/game_engine/data/repositories/lesson_repository.dart';
// import 'package:edufocus/widgets/custom_bottom_nav_bar.dart';
// import 'package:flutter/material.dart';


// class AdhdLearningPathScreen extends StatelessWidget {
//   const AdhdLearningPathScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppColors.backgroundLight,
//       body: SafeArea(
//         child: Column(
//           children: [
//             // Top Header
//             Container(
//               color: AppColors.backgroundLight.withOpacity(0.9),
//               child: Column(
//                 children: [
//                   Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         IconButton(
//                           icon: const Icon(Icons.arrow_back, color: AppColors.primary),
//                           onPressed: () => Navigator.pop(context),
//                           style: IconButton.styleFrom(
//                             backgroundColor: AppColors.primary.withOpacity(0.1),
//                           ),
//                         ),
//                         const Text(
//                           'Executive Function',
//                           style: TextStyle(
//                             color: AppColors.slate900,
//                             fontSize: 18,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                         IconButton(
//                           icon: const Icon(Icons.emoji_events, color: Colors.white),
//                           onPressed: () {},
//                           style: IconButton.styleFrom(
//                             backgroundColor: AppColors.primary,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
//                     child: Container(
//                       padding: const EdgeInsets.all(16.0),
//                       decoration: BoxDecoration(
//                         color: Colors.white,
//                         borderRadius: BorderRadius.circular(16),
//                         border: Border.all(color: AppColors.slate200),
//                         boxShadow: [
//                           BoxShadow(
//                             color: Colors.black.withOpacity(0.02),
//                             blurRadius: 4,
//                             offset: const Offset(0, 2),
//                           ),
//                         ],
//                       ),
//                       child: Column(
//                         children: [
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: const [
//                               Text(
//                                 'UNIT 1: FOCUS MASTERY',
//                                 style: TextStyle(
//                                   color: AppColors.primary,
//                                   fontSize: 12,
//                                   fontWeight: FontWeight.bold,
//                                   letterSpacing: 1.0,
//                                 ),
//                               ),
//                               Text(
//                                 '65%',
//                                 style: TextStyle(
//                                   color: AppColors.primary,
//                                   fontSize: 14,
//                                   fontWeight: FontWeight.bold,
//                                 ),
//                               ),
//                             ],
//                           ),
//                           const SizedBox(height: 8),
//                           Container(
//                             height: 12,
//                             width: double.infinity,
//                             decoration: BoxDecoration(
//                               color: AppColors.slate200,
//                               borderRadius: BorderRadius.circular(9999),
//                             ),
//                             child: FractionallySizedBox(
//                               alignment: Alignment.centerLeft,
//                               widthFactor: 0.65,
//                               child: Container(
//                                 decoration: BoxDecoration(
//                                   color: AppColors.primary,
//                                   borderRadius: BorderRadius.circular(9999),
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),

//             // Learning Path Scrollable Area
//             Expanded(
//               child: SingleChildScrollView(
//                 padding: const EdgeInsets.symmetric(vertical: 48.0, horizontal: 32.0),
//                 child: Stack(
//                   alignment: Alignment.center,
//                   children: [
//                     // Background Path Line (Simulated via a CustomPaint or just a simple vertical line for now)
//                     Positioned.fill(
//                       child: Align(
//                         alignment: Alignment.center,
//                         child: CustomPaint(
//                           painter: _PathLinePainter(),
//                           child: const SizedBox(width: 200, height: double.infinity),
//                         ),
//                       ),
//                     ),

//                     // Path Nodes
//                     Column(
//                       children: [
//                         _CompletedNode(
//                           title: 'The Distraction Myth',
//                           stars: 3,
//                           offsetX: 48,
//                         ),
//                         const SizedBox(height: 64),
//                         _CompletedNode(
//                           title: 'Dopamine Baselines',
//                           stars: 2,
//                           offsetX: -32,
//                         ),
//                         const SizedBox(height: 64),
//                         _ActiveNode(
//                           title: 'Task Initiation',
//                           offsetX: 16,
//                           onTap: () async {
//                             // Load the English Unit 5 lesson and launch the game engine
//                             try {
//                               final lesson =
//                                   await LessonRepository.loadEnglishUnit5();
//                               if (context.mounted) {
//                                 Navigator.pushNamed(
//                                   context,
//                                   '/game_engine',
//                                   arguments: lesson,
//                                 );
//                               }
//                             } catch (e) {
//                               if (context.mounted) {
//                                 ScaffoldMessenger.of(context).showSnackBar(
//                                   SnackBar(content: Text('Error loading lesson: $e')),
//                                 );
//                               }
//                             }
//                           },
//                         ),
//                         const SizedBox(height: 64),
//                         _LockedNode(
//                           title: 'Time Blindness',
//                           offsetX: -40,
//                         ),
//                         const SizedBox(height: 64),
//                         _MiniBossNode(
//                           title: 'Unit Final Challenge',
//                           offsetX: 56,
//                         ),
//                         const SizedBox(height: 64),
//                         _LockedNode(
//                           title: 'Hyperfocus Mastery',
//                           offsetX: -16,
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//             ),

//             // Bottom Navigation Bar
//             CustomBottomNavBar(
//               currentIndex: 1,
//               onTap: (index) {
//                 if (index == 0) {
//                   Navigator.pushReplacementNamed(context, '/subjects_grid_view');
//                 } else if (index == 2) {
//                   ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Profile coming soon!')));
//                 }
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// // Decorative Painter for Path Line
// class _PathLinePainter extends CustomPainter {
//   @override
//   void paint(Canvas canvas, Size size) {
//     var paint = Paint()
//       ..color = AppColors.brandYellow.withOpacity(0.5)
//       ..strokeWidth = 12
//       ..style = PaintingStyle.stroke
//       ..strokeCap = StrokeCap.round;

//     var path = Path();
//     path.moveTo(size.width / 2, 0);
    
//     // Create a winding path that roughly follows the nodes
//     // For simplicity, drawn as a wobbly line down the center
//     for (double i = 0; i <= size.height; i += 100) {
//       path.quadraticBezierTo(
//         size.width / 2 + (i % 200 == 0 ? 50 : -50),
//         i + 50,
//         size.width / 2,
//         i + 100,
//       );
//     }
    
//     canvas.drawPath(path, paint);
//   }

//   @override
//   bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
// }

// // Node Widgets
// class _CompletedNode extends StatelessWidget {
//   final String title;
//   final int stars;
//   final double offsetX;

//   const _CompletedNode({
//     required this.title,
//     required this.stars,
//     required this.offsetX,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Transform.translate(
//       offset: Offset(offsetX, 0),
//       child: Column(
//         children: [
//           Stack(
//             clipBehavior: Clip.none,
//             children: [
//               Container(
//                 width: 80,
//                 height: 80,
//                 decoration: BoxDecoration(
//                   color: AppColors.brandGreen,
//                   shape: BoxShape.circle,
//                   boxShadow: [
//                     BoxShadow(
//                       color: AppColors.brandGreen.withOpacity(0.4),
//                       blurRadius: 10,
//                       offset: const Offset(0, 4),
//                     ),
//                   ],
//                   border: Border.all(color: AppColors.brandGreen.withOpacity(0.2), width: 4),
//                 ),
//                 child: const Icon(Icons.check, color: Colors.white, size: 40),
//               ),
//               Positioned(
//                 top: -16,
//                 right: -8,
//                 child: Row(
//                   children: List.generate(3, (index) {
//                     return Icon(
//                       Icons.star,
//                       color: index < stars ? Colors.amber : AppColors.slate300,
//                       size: 20,
//                     );
//                   }),
//                 ),
//               ),
//             ],
//           ),
//           const SizedBox(height: 8),
//           Container(
//             padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
//             decoration: BoxDecoration(
//               color: Colors.white,
//               borderRadius: BorderRadius.circular(9999),
//               boxShadow: [
//                 BoxShadow(
//                   color: Colors.black.withOpacity(0.05),
//                   blurRadius: 2,
//                   offset: const Offset(0, 1),
//                 ),
//               ],
//             ),
//             child: Text(
//               title,
//               style: const TextStyle(
//                 fontSize: 14,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class _ActiveNode extends StatelessWidget {
//   final String title;
//   final double offsetX;
//   final VoidCallback onTap;

//   const _ActiveNode({
//     required this.title,
//     required this.offsetX,
//     required this.onTap,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Transform.translate(
//       offset: Offset(offsetX, 0),
//       child: GestureDetector(
//         onTap: onTap,
//         child: Column(
//           children: [
//             Stack(
//               alignment: Alignment.center,
//               children: [
//                 // Animated pulse ring
//                 TweenAnimationBuilder<double>(
//                   tween: Tween(begin: 1.0, end: 1.2),
//                   duration: const Duration(seconds: 1),
//                   builder: (context, value, child) {
//                     return Container(
//                       width: 96 * value,
//                       height: 96 * value,
//                       decoration: BoxDecoration(
//                         color: AppColors.brandOrange.withOpacity(0.2 * (1.2 - value) / 0.2),
//                         shape: BoxShape.circle,
//                       ),
//                     );
//                   },
//                   onEnd: () {
//                     // Loop animation by rebuilding? Can be complex, skipping for static mockup
//                   },
//                 ),
//                 Container(
//                   width: 96,
//                   height: 96,
//                   decoration: BoxDecoration(
//                     color: AppColors.brandOrange,
//                     shape: BoxShape.circle,
//                     boxShadow: [
//                       BoxShadow(
//                         color: AppColors.brandOrange.withOpacity(0.5),
//                         blurRadius: 20,
//                         offset: const Offset(0, 4),
//                       ),
//                     ],
//                     border: Border.all(color: AppColors.brandOrange.withOpacity(0.3), width: 8),
//                   ),
//                   child: const Icon(Icons.play_arrow_rounded, color: Colors.white, size: 48),
//                 ),
//               ],
//             ),
//             const SizedBox(height: 8),
//             Container(
//               padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
//               decoration: BoxDecoration(
//                 color: AppColors.brandOrange.withOpacity(0.1),
//                 borderRadius: BorderRadius.circular(9999),
//               ),
//               child: Text(
//                 title,
//                 style: const TextStyle(
//                   color: AppColors.brandOrange,
//                   fontSize: 16,
//                   fontWeight: FontWeight.w900,
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class _LockedNode extends StatelessWidget {
//   final String title;
//   final double offsetX;

//   const _LockedNode({
//     required this.title,
//     required this.offsetX,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Transform.translate(
//       offset: Offset(offsetX, 0),
//       child: Opacity(
//         opacity: 0.6,
//         child: Column(
//           children: [
//             Container(
//               width: 80,
//               height: 80,
//               decoration: BoxDecoration(
//                 color: AppColors.slate200,
//                 shape: BoxShape.circle,
//                 boxShadow: [
//                   BoxShadow(
//                     color: Colors.black.withOpacity(0.05),
//                     blurRadius: 4,
//                     offset: const Offset(0, 2),
//                   ),
//                 ],
//               ),
//               child: const Icon(Icons.lock, color: AppColors.slate500, size: 40),
//             ),
//             const SizedBox(height: 8),
//             Text(
//               title,
//               style: const TextStyle(
//                 color: AppColors.slate500,
//                 fontSize: 14,
//                 fontWeight: FontWeight.w500,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class _MiniBossNode extends StatelessWidget {
//   final String title;
//   final double offsetX;

//   const _MiniBossNode({
//     required this.title,
//     required this.offsetX,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Transform.translate(
//       offset: Offset(offsetX, 0),
//       child: Opacity(
//         opacity: 0.6,
//         child: Column(
//           children: [
//             Transform.rotate(
//               angle: 45 * 3.14159 / 180,
//               child: Container(
//                 width: 112,
//                 height: 112,
//                 decoration: BoxDecoration(
//                   color: AppColors.brandPurple.withOpacity(0.15),
//                   borderRadius: BorderRadius.circular(24),
//                   boxShadow: [
//                     BoxShadow(
//                       color: AppColors.brandPurple.withOpacity(0.2),
//                       blurRadius: 8,
//                       offset: const Offset(0, 4),
//                     ),
//                   ],
//                   border: Border.all(color: AppColors.brandPurple.withOpacity(0.3), width: 4),
//                 ),
//                 child: Transform.rotate(
//                   angle: -45 * 3.14159 / 180,
//                   child: const Center(
//                     child: Icon(Icons.stars_rounded, color: AppColors.brandPurple, size: 56),
//                   ),
//                 ),
//               ),
//             ),
//             const SizedBox(height: 8),
//             Text(
//               title,
//               style: const TextStyle(
//                 color: AppColors.slate500,
//                 fontSize: 14,
//                 fontWeight: FontWeight.w500,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }


