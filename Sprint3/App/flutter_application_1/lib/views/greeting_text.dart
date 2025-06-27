import 'package:flutter/material.dart';

class GreetingText extends StatelessWidget {
  const GreetingText({super.key, required this.isDarkMode}); // Corrigido para aceitar isDarkMode como parâmetro
  final bool isDarkMode;

  @override
  Widget build(BuildContext context) {
    return Text(
      "Olá, Gabriel!",
      style: TextStyle(
        fontFamily: 'SF Pro Display',
        fontSize: 28,
        fontWeight: FontWeight.w700,
        color: isDarkMode ? Colors.white : const Color.fromRGBO(18, 20, 26, 1), // Corrigido para usar isDarkMode
      ),
    );
  }
}