import 'package:flutter/material.dart';

class SwapCard extends StatefulWidget {
final int dailyGoalMl;

const SwapCard({super.key, required this.dailyGoalMl, this.isDarkMode = false});
final bool isDarkMode;

@override
State<SwapCard> createState() => _SwapCardState();
}

class _SwapCardState extends State<SwapCard> {
@override
void initState() {
  super.initState();
}

@override
Widget build(BuildContext context) {
  final int weeklyGoal = widget.dailyGoalMl * 7;

  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      // Meta Semanal Card
      SizedBox(
        width: 159,
        height: 60,
        child: _InfoCard(
          label: "Meta Semanal",
          amount: "${weeklyGoal ~/ 1000} Litros",
          isDarkMode: widget.isDarkMode,
        ),
      ),
      const SizedBox(height: 16),
      // Objetivo Card
      SizedBox(
        width: 96,
        height: 44,
        child: _InfoCard(
          label: "Objetivo",
          amount: "${widget.dailyGoalMl}ml",
          isSmallCard: true,
          isDarkMode: widget.isDarkMode,
        ),
      ),
    ],
  );
}
}

class _InfoCard extends StatelessWidget {
final String? time;
final String label;
final String amount;
final String? percent;
final bool isSmallCard;
final bool isDarkMode;

const _InfoCard({
  super.key,
  this.time,
  this.label = '',
  required this.amount,
  this.percent,
  this.isSmallCard = false,
  this.isDarkMode = false,
});

@override
@override
Widget build(BuildContext context) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: isSmallCard ? 10 : 16),
    decoration: BoxDecoration(
      color: isDarkMode ? const Color.fromRGBO(33, 35, 48, 1) : Colors.white, // Fundo dinâmico
      borderRadius: BorderRadius.circular(15),
      border: Border.all(
        color: isDarkMode
            ? const Color.fromRGBO(33, 35, 48, 1) // Cor da borda no modo escuro
            : const Color.fromRGBO(212, 212, 212, 1), // Cor da borda no modo claro
        width: 1,
      ),
    ),
    alignment: Alignment.center,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          time ?? label,
          style: TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w400,
            fontSize: 12,
            color: isDarkMode ? Colors.white : Colors.black54, // Cor do texto dinâmico
          ),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: isSmallCard ? 2 : 4),
        Text(
          amount,
          style: TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w500,
            fontSize: 12,
            color: isDarkMode ? Colors.white : const Color.fromRGBO(0, 0, 0, 1), // Cor do texto dinâmico
          ),
          textAlign: TextAlign.center,
        ),
        if (percent != null)
          Text(
            percent!,
            style: TextStyle(
              fontSize: 12,
              color: isDarkMode ? Colors.white : Colors.grey, // Cor do texto dinâmico
            ),
            textAlign: TextAlign.center,
          ),
      ],
    ),
  );
}
}