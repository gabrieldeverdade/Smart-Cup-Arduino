import 'package:flutter/material.dart';

class WeeklyWaterCard extends StatelessWidget {
  const WeeklyWaterCard({super.key, required this.isDarkMode});
  final bool isDarkMode;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDarkMode
            ? const Color.fromRGBO(33, 35, 48, 1) // Fundo no modo escuro
            : const Color(0xFF63B5F5), // Fundo no modo claro
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Água Semanal",
            style: TextStyle(
              fontSize: 16,
              color: isDarkMode ? Colors.white : Colors.white, // Texto dinâmico
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            "Quantidade de água tomada por dia",
            style: TextStyle(
              color: isDarkMode ? Colors.white70 : Colors.white70, // Texto dinâmico
              fontSize: 12,
            ),
          ),
          const SizedBox(height: 12),
          Stack(
            children: [
              Container(
                height: 6,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: isDarkMode ? Colors.white24 : Colors.white24, // Barra de progresso dinâmica
                  borderRadius: BorderRadius.circular(3),
                ),
              ),
              Container(
                height: 6,
                width: (3 / 7) * MediaQuery.of(context).size.width * 0.7,
                decoration: BoxDecoration(
                  color: isDarkMode ? Colors.white : Colors.white, // Barra preenchida dinâmica
                  borderRadius: BorderRadius.circular(3),
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Align(
            alignment: Alignment.centerRight,
            child: Text(
              "3/7",
              style: TextStyle(
                color: isDarkMode ? Colors.white : Colors.white, // Texto dinâmico
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}