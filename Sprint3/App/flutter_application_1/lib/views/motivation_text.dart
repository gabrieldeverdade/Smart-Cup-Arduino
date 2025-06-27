import 'package:flutter/material.dart';

class MotivationText extends StatelessWidget {
  const MotivationText({super.key, required this.totalConsumedMl});
  final int totalConsumedMl;

  @override
  Widget build(BuildContext context) {
    final percentagem = (totalConsumedMl / 2000) * 100;

    return Center(
      child: Text(
        "Você atingiu ${percentagem.toStringAsFixed(0)}% da sua meta, \ncontinue com foco na sua \nsaúde!",
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontFamily: 'Poppins', // Aplicando a fonte Poppins
          fontWeight: FontWeight.w400, // Aplicando o peso 400
          fontSize: 14,
          color: Color.fromRGBO(132, 138, 148, 1) // Cor preta
        ),
      ),
    );
  }
}
