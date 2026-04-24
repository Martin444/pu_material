import 'package:flutter/material.dart';
import '../utils/pu_colors.dart';

class FilterChipAtom extends StatelessWidget {
  final String label;
  final bool selected;
  final ValueChanged<bool>? onSelected;
  final Color? selectedColor;
  final Color? unselectedColor;

  const FilterChipAtom({
    super.key,
    required this.label,
    this.selected = false,
    this.onSelected,
    this.selectedColor,
    this.unselectedColor,
  });

  @override
  Widget build(BuildContext context) {
    final isSelected = selected;
    final activeColor = selectedColor ?? PUColors.primaryColor;
    final bgColor = isSelected 
        ? activeColor.withValues(alpha: 0.15)
        : (unselectedColor ?? PUColors.bgInput);

    return InkWell(
      onTap: () => onSelected?.call(!isSelected),
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? activeColor : PUColors.borderInputColor,
            width: 1,
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w500,
            color: isSelected ? activeColor : PUColors.textColorMuted,
          ),
        ),
      ),
    );
  }
}

class FilterChipsRowMolecule extends StatelessWidget {
  final List<FilterChipData> chips;
  final bool multiSelect;
  final void Function(List<String>)? onSelectionChanged;

  const FilterChipsRowMolecule({
    super.key,
    required this.chips,
    this.multiSelect = false,
    this.onSelectionChanged,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: chips.map((chip) => _buildChip(chip)).toList(),
      ),
    );
  }

  Widget _buildChip(FilterChipData chip) {
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: FilterChipAtom(
        label: chip.label,
        selected: chip.selected,
        selectedColor: chip.color,
        onSelected: (selected) {
          chip.onSelected?.call(selected);
          if (!multiSelect) {
            onSelectionChanged?.call([chip.value]);
          }
        },
      ),
    );
  }
}

class FilterChipData {
  final String label;
  final String value;
  final bool selected;
  final Color? color;
  final void Function(bool)? onSelected;

  const FilterChipData({
    required this.label,
    required this.value,
    this.selected = false,
    this.color,
    this.onSelected,
  });
}