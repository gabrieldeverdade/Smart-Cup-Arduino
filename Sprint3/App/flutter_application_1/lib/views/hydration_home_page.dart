// import 'package:flutter/material.dart';
// import 'package:poc_bluetooth/views/swap_info_card.dart';
// import 'app_bar_row.dart';
// import 'greeting_text.dart';
// import 'weekly_water_card.dart';
// import 'progress_section.dart';
// import 'motivation_text.dart';

// class HydrationHomePage extends StatelessWidget {
//   final int totalConsumedMl;

//   const HydrationHomePage({super.key, required this.totalConsumedMl});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFFF6F7FB),
//       body: SafeArea(
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               const AppBarRow(),
//               const SizedBox(height: 20),
//               const GreetingText(),
//               const SizedBox(height: 20),
//               const WeeklyWaterCard(),
//               const SizedBox(height: 50),
//               ProgressSection(totalConsumedMl: totalConsumedMl),
//               const SizedBox(height: 10),
//               const SwapCard(),
//               const SizedBox(height: 30),
//               const MotivationText(),
//               const SizedBox(height: 10),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
