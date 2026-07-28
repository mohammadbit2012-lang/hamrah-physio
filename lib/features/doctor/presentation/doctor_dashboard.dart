import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/config/theme/app_typography.dart';
import '../../../core/config/theme/app_colors.dart';
import '../../login/presentation/auth_controller.dart';
import 'widgets/dashboard_header.dart';
import 'widgets/statistics_card.dart';
import 'widgets/quick_actions.dart';
import 'widgets/today_patients_list.dart';
import 'widgets/workspace_placeholder.dart';
import 'widgets/doctor_sidebar.dart';
import '../../patients/presentation/patients_page.dart';

/// A production-quality, responsive, Material 3 Doctor Dashboard Workspace for Hamrah Physio.
class DoctorDashboard extends ConsumerStatefulWidget {
  const DoctorDashboard({super.key});

  @override
  ConsumerState<DoctorDashboard> createState() => _DoctorDashboardState();
}

class _DoctorDashboardState extends ConsumerState<DoctorDashboard> {
  int _selectedIndex = 0;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  void _handleLogout(WidgetRef ref) {
    // Reset state and logout
    ref.read(authControllerProvider.notifier).reset();
    context.go('/login');
  }

  String _getAppBarTitle() {
    if (_selectedIndex < doctorMenuItems.length) {
      return 'پنل مدیریت پزشک | ' + doctorMenuItems[_selectedIndex].title;
    }
    return 'پنل مدیریت پزشک';
  }

  Widget _buildBody(BuildContext context, WidgetRef ref) {
    switch (_selectedIndex) {
      case 0:
        return _buildDashboardContent(context, ref);
      case 1:
        return const PatientsPage();
      case 2:
        return const WorkspacePlaceholder(
          title: 'برنامه‌ریزی و مدیریت نوبت‌ها',
          description: 'نمایش لیست جامع نوبت‌های ثبت‌شده امروز، روزهای آینده و امکان مدیریت زمان‌بندی حضور بیماران در مرکز فیزیوتراپی.',
          icon: Icons.calendar_month_rounded,
          color: AppColors.info,
        );
      case 3:
        return const WorkspacePlaceholder(
          title: 'نسخه‌نویسی و طراحی برنامه‌های تمرینی',
          description: 'طراحی و تخصیص تمرینات ورزشی و فیزیوتراپی خانگی به تفکیک بیمار به همراه ویدیوهای آموزشی و تعداد تکرار هر تمرین.',
          icon: Icons.fitness_center_rounded,
          color: AppColors.success,
        );
      case 4:
        return const WorkspacePlaceholder(
          title: 'نسخه‌های الکترونیک فیزیوتراپی',
          description: 'ثبت، ویرایش و مدیریت نسخه‌های درمانی، دارویی و تجهیزات کمکی مورد نیاز بیماران برای ارائه به بیمه‌ها یا داروخانه‌ها.',
          icon: Icons.note_alt_rounded,
          color: AppColors.warning,
        );
      case 5:
        return const WorkspacePlaceholder(
          title: 'گزارش‌های آماری و عملکردی',
          description: 'تحلیل داده‌های مربوط به مراجعات بیماران، اثربخشی درمان‌ها، آمارهای مالی و میزان رضایت‌مندی مراجعین از خدمات مرکز.',
          icon: Icons.analytics_rounded,
          color: AppColors.error,
        );
      case 6:
        return const WorkspacePlaceholder(
          title: 'تنظیمات پنل کاربری پزشک',
          description: 'پیکربندی ساعت‌های حضور در مطب، اطلاعات شخصی، فعال‌سازی اعلان‌ها، تغییر کلمه عبور و شخصی‌سازی ظاهر داشبورد.',
          icon: Icons.settings_rounded,
          color: Colors.blueGrey,
        );
      default:
        return _buildDashboardContent(context, ref);
    }
  }

  Widget _buildDashboardContent(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final screenWidth = MediaQuery.of(context).size.width;

    // Determine grid columns dynamically based on screen width and sidebar size
    final remainingWidth = screenWidth > 1000 ? screenWidth - (screenWidth > 1200 ? 260 : 76) : screenWidth;
    final statColumns = remainingWidth > 1100
        ? 6
        : (remainingWidth > 750 ? 3 : 2);

    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // 1. Dashboard Header
          const DashboardHeader(),
          
          const SizedBox(height: 8),

          // 2. Statistics Section Title
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Text(
              'خلاصه وضعیت امروز',
              textDirection: TextDirection.rtl,
              style: theme.textTheme.titleMedium?.copyWith(
                fontFamily: AppTypography.fontName,
                fontWeight: FontWeight.bold,
                color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight,
              ),
            ),
          ),

          // 3. Responsive Grid for Statistics Cards
          GridView(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: statColumns,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 1.35,
            ),
            children: [
              StatisticsCard(
                title: 'بیماران امروز',
                value: '۱۲',
                icon: Icons.people_outline_rounded,
                iconColor: theme.colorScheme.primary,
                trendText: '+۳ نفر جدید',
                isTrendPositive: true,
              ),
              StatisticsCard(
                title: 'نوبت‌های ثبت‌شده',
                value: '۱۵',
                icon: Icons.calendar_today_rounded,
                iconColor: AppColors.info,
                trendText: '۱۰۰٪ ظرفیت',
                isTrendPositive: true,
              ),
              StatisticsCard(
                title: 'بیماران در انتظار',
                value: '۳',
                icon: Icons.hourglass_empty_rounded,
                iconColor: AppColors.warning,
                trendText: 'متوسط ۱۵ دقیقه',
                isTrendPositive: false,
              ),
              StatisticsCard(
                title: 'ویزیت‌های انجام‌شده',
                value: '۸',
                icon: Icons.check_circle_outline_rounded,
                iconColor: AppColors.success,
                trendText: '۲ مورد اورژانسی',
                isTrendPositive: true,
              ),
              StatisticsCard(
                title: 'جلسات درمانی فعال',
                value: '۶',
                icon: Icons.fitness_center_rounded,
                iconColor: Colors.deepPurple,
                trendText: 'کابین ۱ تا ۵',
                isTrendPositive: true,
              ),
              StatisticsCard(
                title: 'درآمد تقریبی (تومان)',
                value: '۴,۵۰۰,۰۰۰',
                icon: Icons.monetization_on_outlined,
                iconColor: Colors.teal.shade700,
                trendText: '+۱۲٪ رشد ماهانه',
                isTrendPositive: true,
              ),
            ],
          ),

          const SizedBox(height: 16),

          // 4. Quick Actions
          const QuickActions(),

          const SizedBox(height: 16),

          // 5. Today's Patients List
          const TodayPatientsList(),
          
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  Widget _buildDrawer(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Drawer(
      backgroundColor: isDark ? AppColors.surfaceDark : AppColors.surfaceLight,
      child: SafeArea(
        child: Column(
          children: [
            // Drawer Header
            Container(
              padding: const EdgeInsets.all(24.0),
              color: theme.colorScheme.primary.withOpacity(0.06),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          'دکتر همراه فیزیو',
                          style: theme.textTheme.titleMedium?.copyWith(
                            fontFamily: AppTypography.fontName,
                            fontWeight: FontWeight.bold,
                            color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'پزشک متخصص فیزیوتراپی',
                          style: theme.textTheme.bodySmall?.copyWith(
                            fontFamily: AppTypography.fontName,
                            color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 16),
                  Container(
                    width: 52,
                    height: 52,
                    decoration: BoxDecoration(
                      color: theme.colorScheme.primary.withOpacity(0.12),
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: theme.colorScheme.primary.withOpacity(0.3),
                        width: 1.5,
                      ),
                    ),
                    child: Icon(
                      Icons.person_pin_rounded,
                      color: theme.colorScheme.primary,
                      size: 32,
                    ),
                  ),
                ],
              ),
            ),
            const Divider(height: 1),
            // Menu Items
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(vertical: 8),
                itemCount: doctorMenuItems.length,
                itemBuilder: (context, index) {
                  final item = doctorMenuItems[index];
                  final isSelected = _selectedIndex == index;

                  return ListTile(
                    selected: isSelected,
                    selectedTileColor: theme.colorScheme.primary.withOpacity(0.08),
                    selectedColor: theme.colorScheme.primary,
                    onTap: () {
                      setState(() {
                        _selectedIndex = index;
                      });
                      _scaffoldKey.currentState?.closeDrawer(); // Close drawer
                    },
                    leading: isSelected ? Icon(item.selectedIcon) : Icon(item.icon),
                    title: Text(
                      item.title,
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        fontFamily: AppTypography.fontName,
                        fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                      ),
                    ),
                  );
                },
              ),
            ),
            const Divider(height: 1),
            // Logout item
            ListTile(
              onTap: () {
                _scaffoldKey.currentState?.closeDrawer(); // Close drawer
                _handleLogout(ref);
              },
              leading: const Icon(Icons.logout_rounded, color: AppColors.error),
              title: const Text(
                'خروج از حساب',
                textAlign: TextAlign.right,
                style: TextStyle(
                  fontFamily: AppTypography.fontName,
                  color: AppColors.error,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 12),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final screenWidth = MediaQuery.of(context).size.width;

    final bool isDesktop = screenWidth > 1000;
    final bool isLargeDesktop = screenWidth > 1200;

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        key: _scaffoldKey,
        // Only show drawer on non-desktop screens
        drawer: isDesktop ? null : _buildDrawer(context, ref),
        appBar: AppBar(
          title: Text(
            _getAppBarTitle(),
            style: const TextStyle(
              fontFamily: AppTypography.fontName,
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
          backgroundColor: isDark ? AppColors.surfaceDark : AppColors.surfaceLight,
          elevation: 0,
          // Menu burger icon ONLY on tablet/mobile:
          leading: isDesktop
              ? null
              : IconButton(
                  icon: const Icon(Icons.menu_rounded),
                  onPressed: () {
                    _scaffoldKey.currentState?.openDrawer();
                  },
                ),
          actions: [
            // Show quick logout in appbar on mobile, or just rely on sidebar on desktop
            if (!isDesktop)
              IconButton(
                icon: const Icon(Icons.logout_rounded, color: AppColors.error),
                tooltip: 'خروج از حساب کاربری',
                onPressed: () => _handleLogout(ref),
              ),
          ],
        ),
        body: Row(
          children: [
            // 1. Desktop Sidebar (always visible on desktop, on the right in RTL Row)
            if (isDesktop)
              DoctorSidebar(
                selectedIndex: _selectedIndex,
                onSelected: (index) {
                  setState(() {
                    _selectedIndex = index;
                  });
                },
                isExtended: isLargeDesktop,
                onLogout: () => _handleLogout(ref),
              ),
            
            // Divider for separating sidebar and content
            if (isDesktop)
              VerticalDivider(
                width: 1,
                thickness: 1,
                color: isDark ? AppColors.borderDark : AppColors.borderLight,
              ),

            // 2. Content Area
            Expanded(
              child: Container(
                color: isDark ? AppColors.backgroundDark : AppColors.backgroundLight,
                child: SafeArea(
                  child: _buildBody(context, ref),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
