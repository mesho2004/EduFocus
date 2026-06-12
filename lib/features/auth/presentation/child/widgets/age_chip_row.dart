import 'package:edufocus/core/themes/app_theme.dart';
import 'package:flutter/material.dart';

class AgeChipRow extends StatelessWidget {
  final int? selectedAge;
  final ValueChanged<int> onSelected;

  const AgeChipRow({
    super.key,
    required this.selectedAge,
    required this.onSelected,
  });

  static const _ages = [
    (value: 4, label: '4'),
    (value: 5, label: '5'),
    (value: 6, label: '6'),
    (value: 7, label: '7'),
    (value: 8, label: '8'),
    (value: 9, label: '9+'),
  ];

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 10,
      runSpacing: 8,
      children: _ages.map((a) {
        final isSelected = a.value == selectedAge;
        return ChoiceChip(
          label: Text(
            a.label,
            style: TextStyle(
              color: isSelected ? Colors.white : context.colors.textSecondary,
              fontWeight: FontWeight.bold,
              fontSize: 15,
            ),
          ),
          selected: isSelected,
          onSelected: (_) => onSelected(a.value),
          selectedColor: context.colors.brandGreen,
          backgroundColor: context.colors.border.withOpacity(0.3),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: BorderSide(
              color: isSelected
                  ? context.colors.brandGreen
                  : context.colors.border,
            ),
          ),
          showCheckmark: false,
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        );
      }).toList(),
    );
  }
}
