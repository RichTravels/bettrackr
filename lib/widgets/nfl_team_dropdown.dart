import 'package:flutter/material.dart';
import '../models/nfl.dart'; // NflTeam, nflTeamName

class NflTeamDropdown extends StatelessWidget {
  final NflTeam? value;
  final ValueChanged<NflTeam?> onChanged;
  final String? label;
  final FormFieldValidator<NflTeam?>? validator;
  final bool dense;

  const NflTeamDropdown({
    super.key,
    required this.value,
    required this.onChanged,
    this.label,
    this.validator,
    this.dense = false,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<NflTeam>(
      value: value,
      onChanged: onChanged,
      isDense: dense,
      decoration: InputDecoration(
        labelText: label ?? 'Team',
        border: const OutlineInputBorder(),
      ),
      items: NflTeam.values.map((team) {
        return DropdownMenuItem(
          value: team,
          child: Text(nflTeamName[team]!, overflow: TextOverflow.ellipsis),
        );
      }).toList(),
      validator: validator ?? (t) => t == null ? 'Select a team' : null,
    );
  }
}
