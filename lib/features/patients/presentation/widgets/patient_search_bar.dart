import 'package:flutter/material.dart';
import '../../../../core/config/theme/app_typography.dart';
import '../../../../core/config/theme/app_colors.dart';

class PatientSearchBar extends StatefulWidget {
  final String initialValue;
  final ValueChanged<String> onChanged;

  const PatientSearchBar({
    super.key,
    required this.initialValue,
    required this.onChanged,
  });

  @override
  State<PatientSearchBar> createState() => _PatientSearchBarState();
}

class _PatientSearchBarState extends State<PatientSearchBar> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.initialValue);
  }

  @override
  void didUpdateWidget(covariant PatientSearchBar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.initialValue != oldWidget.initialValue &&
        widget.initialValue != _controller.text) {
      _controller.text = widget.initialValue;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Container(
      decoration: BoxDecoration(
        color: isDark ? AppColors.surfaceDark : AppColors.surfaceLight,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isDark ? AppColors.borderDark : AppColors.borderLight,
        ),
      ),
      child: TextField(
        controller: _controller,
        onChanged: widget.onChanged,
        textDirection: TextDirection.rtl,
        style: TextStyle(
          fontFamily: AppTypography.fontName,
          color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight,
          fontSize: 14,
        ),
        decoration: InputDecoration(
          hintText: 'جستجوی نام، کد ملی، شماره پرونده...',
          hintStyle: TextStyle(
            fontFamily: AppTypography.fontName,
            color: isDark
                ? AppColors.textSecondaryDark.withOpacity(0.5)
                : AppColors.textSecondaryLight.withOpacity(0.5),
            fontSize: 14,
          ),
          prefixIcon: Icon(
            Icons.search_rounded,
            color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight,
          ),
          suffixIcon: _controller.text.isNotEmpty
              ? IconButton(
                  icon: const Icon(Icons.clear_rounded, size: 18),
                  onPressed: () {
                    _controller.clear();
                    widget.onChanged('');
                  },
                )
              : null,
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        ),
      ),
    );
  }
}
