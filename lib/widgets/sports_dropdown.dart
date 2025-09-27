import 'package:flutter/material.dart';
import '../models/sports.dart';

class SportsDropdown extends StatelessWidget {
  final SportType? selected;
  final ValueChanged<SportType?> onChanged;

  const SportsDropdown({
    super.key,
    required this.selected,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<SportType>(
      value: selected,
      decoration: const InputDecoration(
        labelText: "Select Sport",
        border: OutlineInputBorder(),
      ),
      items: SportType.values.map((sport) {
        return DropdownMenuItem<SportType>(
          value: sport,
          child: Row(
            children: [
              Icon(
                sportIcons[sport],
                color: sportColors[sport],
              ),
              const SizedBox(width: 8),
              Text(sportNames[sport]!),
            ],
          ),
        );
      }).toList(),
      onChanged: onChanged,
    );
  }
}
