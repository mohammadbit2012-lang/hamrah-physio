import 'package:flutter/material.dart';
import '../../../../core/config/theme/app_typography.dart';
import '../../../../core/config/theme/app_colors.dart';

class WorkspaceMenuItem {
  final String title;
  final IconData icon;
  final IconData selectedIcon;

  const WorkspaceMenuItem({
    required this.title,
    required this.icon,
    required this.selectedIcon,
  });
}

const List<WorkspaceMenuItem> doctorMenuItems = [
  WorkspaceMenuItem(
    title: 'داشبورد',
    icon: Icons.dashboard_outlined,
    selectedIcon: Icons.dashboard_rounded,
  ),
  WorkspaceMenuItem(
    title: 'بیماران',
    icon: Icons.people_outline_rounded,
    selectedIcon: Icons.people_rounded,
  ),
  WorkspaceMenuItem(
    title: 'نوبت‌ها',
    icon: Icons.calendar_today_outlined,
    selectedIcon: Icons.calendar_today_rounded,
  ),
  WorkspaceMenuItem(
    title: 'برنامه‌های تمرینی',
    icon: Icons.fitness_center_outlined,
    selectedIcon: Icons.fitness_center_rounded,
  ),
  WorkspaceMenuItem(
    title: 'نسخه‌ها',
    icon: Icons.note_alt_outlined,
    selectedIcon: Icons.note_alt_rounded,
  ),
  WorkspaceMenuItem(
    title: 'گزارش‌ها',
    icon: Icons.analytics_outlined,
    selectedIcon: Icons.analytics_rounded,
  ),
  WorkspaceMenuItem(
    title: 'تنظیمات',
    icon: Icons.settings_outlined,
    selectedIcon: Icons.settings_rounded,
  ),
];

class DoctorSidebar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onSelected;
  final bool isExtended;
  final VoidCallback onLogout;

  const DoctorSidebar({
    super.key,
    required this.selectedIndex,
    required this.onSelected,
    required this.isExtended,
    required this.onLogout,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final width = isExtended ? 260.0 : 76.0;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      width: width,
      height: double.infinity,
      decoration: BoxDecoration(
        color: isDark ? AppColors.surfaceDark : AppColors.surfaceLight,
        border: Border(
          left: BorderSide(
            color: isDark ? AppColors.borderDark : AppColors.borderLight,
            width: 1,
          ),
        ),
      ),
      child: Column(
        children: [
          // Logo / Header
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 24.0, horizontal: 16.0),
            child: Row(
              mainAxisAlignment: isExtended ? MainAxisAlignment.end : MainAxisAlignment.center,
              children: [
                if (isExtended) ...[
                  Text(
                    'همراه فیزیو',
                    style: theme.textTheme.titleLarge?.copyWith(
                      fontFamily: AppTypography.fontName,
                      fontWeight: FontWeight.bold,
                      color: theme.colorScheme.primary,
                    ),
                  ),
                  const SizedBox(width: 12),
                ],
                Icon(
                  Icons.local_hospital_rounded,
                  color: theme.colorScheme.primary,
                  size: 28,
                ),
              ],
            ),
          ),
          const Divider(height: 1, indent: 16, endIndent: 16),
          const SizedBox(height: 16),
          // Menu Items
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              itemCount: doctorMenuItems.length,
              itemBuilder: (context, index) {
                final item = doctorMenuItems[index];
                final isSelected = selectedIndex == index;

                return Padding(
                  padding: const EdgeInsets.only(bottom: 4.0),
                  child: InkWell(
                    onTap: () => onSelected(index),
                    borderRadius: BorderRadius.circular(12),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 150),
                      padding: EdgeInsets.symmetric(
                        vertical: 12,
                        horizontal: isExtended ? 16 : 8,
                      ),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? theme.colorScheme.primary.withOpacity(0.08)
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        mainAxisAlignment: isExtended ? MainAxisAlignment.end : MainAxisAlignment.center,
                        children: [
                          if (isExtended) ...[
                            Expanded(
                              child: Text(
                                item.title,
                                textAlign: TextAlign.right,
                                style: theme.textTheme.bodyMedium?.copyWith(
                                  fontFamily: AppTypography.fontName,
                                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                                  color: isSelected
                                      ? theme.colorScheme.primary
                                      : (isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight),
                                ),
                              ),
                            ),
                            const SizedBox(width: 12),
                          ],
                          Icon(
                            isSelected ? item.selectedIcon : item.icon,
                            color: isSelected
                                ? theme.colorScheme.primary
                                : (isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight),
                            size: 22,
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          // Bottom Profile or Logout
          const Divider(height: 1, indent: 16, endIndent: 16),
          const SizedBox(height: 12),
          // Logout button
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: InkWell(
              onTap: onLogout,
              borderRadius: BorderRadius.circular(12),
              child: Container(
                padding: EdgeInsets.symmetric(
                  vertical: 12,
                  horizontal: isExtended ? 16 : 8,
                ),
                child: Row(
                  mainAxisAlignment: isExtended ? MainAxisAlignment.end : MainAxisAlignment.center,
                  children: [
                    if (isExtended) ...[
                      const Expanded(
                        child: Text(
                          'خروج از حساب',
                          textAlign: TextAlign.right,
                          style: TextStyle(
                            fontFamily: AppTypography.fontName,
                            fontWeight: FontWeight.bold,
                            color: AppColors.error,
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                    ],
                    const Icon(
                      Icons.logout_rounded,
                      color: AppColors.error,
                      size: 22,
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
