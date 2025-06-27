import 'package:flutter/material.dart';
import 'package:poc_bluetooth/views/circle_animation.dart';
import 'package:poc_bluetooth/views/swap_info_card.dart';

class ProgressSection extends StatelessWidget {
  final int totalConsumedMl;
  final int dailyGoalMl;
  final bool isDarkMode;

  const ProgressSection({
    super.key,
    required this.totalConsumedMl,
    this.dailyGoalMl = 2000,
    this.isDarkMode = false,
  });

  @override
  Widget build(BuildContext context) {
    final double percentage =
        (totalConsumedMl / dailyGoalMl * 100).clamp(0, 100);

    return Center(
      child: Column(
        mainAxisSize: MainAxisSize
            .min, // importante para o Column usar só o espaço necessário
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 200,
            child: CircularWaveProgress(
                percentage: percentage, isDarkMode: isDarkMode),
          ),
          const SizedBox(height: 90),
          SwapCard(dailyGoalMl: dailyGoalMl, isDarkMode: isDarkMode),
        ],
      ),
    );
  }
}
