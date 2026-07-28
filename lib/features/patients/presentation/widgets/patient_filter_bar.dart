import 'package:flutter/material.dart';
import '../../../../core/config/theme/app_typography.dart';
import '../../../../core/config/theme/app_colors.dart';

class PatientFilterBar extends StatelessWidget {
  final String selectedFilter;
  final ValueChanged<String> onFilterChanged;

  const PatientFilterBar({
    super.key,
    required this.selectedFilter,
    required this.onFilterChanged,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    final filters = [
      {'key': 'all', 'label': 'همه'},
      {'key': 'active', 'label': 'فعال'},
      {'key': 'inactive', 'label': 'غیرفعال'},
      {'key': 'today', 'label': 'امروز'},
    ];

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      physics: const BouncingScrollPhysics(),
      child: Row(
        children: filters.map((filter) {
          final isSelected = selectedFilter == filter['key'];
          return Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: FilterChip(
              selected: isSelected,
              label: Text(
                filter['label']!,
                style: TextStyle(
                  fontFamily: AppTypography.fontName,
                  fontSize: 13,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                  color: isSelected
                      ? theme.colorScheme.onPrimary
                      : (isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight),
                ),
              ),
              selectedColor: theme.colorScheme.primary,
              checkmarkColor: theme.colorScheme.onPrimary,
              backgroundColor: isDark ? AppColors.surfaceDark : Colors.grey.shade100,
              side: BorderSide(
                color: isSelected
                    ? Colors.transparent
                    : (isDark ? AppColors.borderDark : AppColors.borderLight),
                width: 1,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              onSelected: (_) => onFilterChanged(filter['key']!),
            ),
          );
        }).toList(),
      ),
    );
  }
}
