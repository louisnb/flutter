import 'package:flutter/material.dart';

class HabitationOption extends StatelessWidget {
  final String texte;
  final IconData icon;
  const HabitationOption(this.icon, this.texte, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 35,
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(2.0),
      ),
      padding: const EdgeInsets.all(8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(icon),
          const SizedBox(width: 5),
          Text(texte)
        ],
      ),
    );
  }
}
