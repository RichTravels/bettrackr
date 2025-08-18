// lib/widgets/team_dropdown.dart
import 'package:flutter/material.dart';

class TeamDropdown extends StatelessWidget {
  final String label;
  final List<String> items;
  final String? value;
  final ValueChanged<String?> onChanged;

  const TeamDropdown({
    super.key,
    required this.label,
    required this.items,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      isExpanded: true,
      value: value,
      decoration: InputDecoration(labelText: label),
      items: items
          .map((t) => DropdownMenuItem<String>(value: t, child: Text(t)))
          .toList(),
      onChanged: onChanged,
      validator: (v) => (v == null || v.trim().isEmpty) ? 'Pick a team' : null,
    );
  }
}
