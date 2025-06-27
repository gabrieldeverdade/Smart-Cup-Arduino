import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AppBarRow extends StatelessWidget {
  const AppBarRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () {
            Scaffold.of(context).openDrawer();
          },
        ),
        Text(
          DateFormat("EEEE, d", "pt_BR").format(DateTime.now()),
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Color(0xFF0A2C66),
          ),
        ),
        const Icon(Icons.notifications_none_rounded),
      ],
    );
  }
}
