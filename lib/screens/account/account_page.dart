import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:motigraph/widgets/moti_glass_card.dart';
import 'package:motigraph/settings/app_settings_controller.dart';

class AccountPage extends StatefulWidget {
  final AppSettingsController settingsController;

  const AccountPage({
    super.key,
    required this.settingsController,
  });

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  bool get isDark =>
      widget.settingsController.themeMode == ThemeMode.dark;

  bool get isArabic =>
      context.locale.languageCode == 'ar';

  Future<void> _changeTheme(ThemeMode mode) async {
    await widget.settingsController.changeTheme(mode);

    if (!mounted) return;

    setState(() {});
  }

  Future<void> _changeLanguage(Locale locale) async {
    await widget.settingsController.changeLanguage(locale);

    if (!mounted) return;

    await context.setLocale(locale);

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,

      appBar: AppBar(
        elevation: 0,
        backgroundColor: theme.scaffoldBackgroundColor,
        surfaceTintColor: Colors.transparent,

        title: Text(
          'profile'.tr(),
          style: TextStyle(
            fontSize: 21,
            fontWeight: FontWeight.bold,
            color: colorScheme.onSurface,
          ),
        ),
      ),

      body: ListView(
        padding: const EdgeInsets.fromLTRB(
          16,
          10,
          16,
          30,
        ),
        children: [

          // =========================
          // PROFILE HEADER
          // =========================

          MotiGlassCard(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                children: [

                  Container(
                    width: 72,
                    height: 72,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: colorScheme.primary
                          .withValues(alpha: 0.12),
                      border: Border.all(
                        color: colorScheme.primary
                            .withValues(alpha: 0.5),
                        width: 1.5,
                      ),
                    ),
                    child: Icon(
                      Icons.person_outline,
                      size: 38,
                      color: colorScheme.primary,
                    ),
                  ),

                  const SizedBox(width: 16),

                  Expanded(
                    child: Column(
                      crossAxisAlignment:
                      CrossAxisAlignment.start,
                      children: [

                        Text(
                          'guest_user'.tr(),
                          style: TextStyle(
                            fontSize: 19,
                            fontWeight: FontWeight.bold,
                            color: colorScheme.onSurface,
                          ),
                        ),

                        const SizedBox(height: 5),

                        Text(
                          'guest_email'.tr(),
                          style: TextStyle(
                            fontSize: 13,
                            color: colorScheme.onSurface
                                .withValues(alpha: 0.55),
                          ),
                        ),
                      ],
                    ),
                  ),

                  Icon(
                    Icons.arrow_forward_ios,
                    size: 15,
                    color: colorScheme.onSurface
                        .withValues(alpha: 0.35),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 24),

          // =========================
          // SETTINGS TITLE
          // =========================

          Padding(
            padding: const EdgeInsetsDirectional.only(
              start: 6,
              bottom: 10,
            ),
            child: Text(
              'settings'.tr(),
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: colorScheme.primary,
              ),
            ),
          ),

          // =========================
          // SETTINGS CARD
          // =========================

          MotiGlassCard(
            child: Column(
              children: [

                _ProfileSettingTile(
                  icon: Icons.language_outlined,
                  title: 'language'.tr(),
                  subtitle:
                  isArabic ? 'العربية' : 'English',
                  onTap: _showLanguageBottomSheet,
                ),

                _divider(context),

                _ProfileSettingTile(
                  icon: isDark
                      ? Icons.dark_mode_outlined
                      : Icons.light_mode_outlined,
                  title: 'theme'.tr(),
                  subtitle: isDark
                      ? 'dark'.tr()
                      : 'light'.tr(),
                  onTap: _showThemeBottomSheet,
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),

          // =========================
          // ACCOUNT SECTION
          // =========================

          Padding(
            padding: const EdgeInsetsDirectional.only(
              start: 6,
              bottom: 10,
            ),
            child: Text(
              'account'.tr(),
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: colorScheme.primary,
              ),
            ),
          ),

          MotiGlassCard(
            child: Column(
              children: [

                _ProfileSettingTile(
                  icon: Icons.edit_outlined,
                  title: 'edit_profile'.tr(),
                  onTap: () {
                    // TODO: Edit Profile
                  },
                ),

                _divider(context),

                _ProfileSettingTile(
                  icon: Icons.notifications_none_outlined,
                  title: 'notifications'.tr(),
                  onTap: () {
                    // TODO: Notifications
                  },
                ),

                _divider(context),

                _ProfileSettingTile(
                  icon: Icons.info_outline,
                  title: 'about'.tr(),
                  onTap: () {
                    // TODO: About
                  },
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),

          // =========================
          // LOGOUT
          // =========================

          MotiGlassCard(
            child: _ProfileSettingTile(
              icon: Icons.logout,
              title: 'logout'.tr(),
              iconColor: Colors.redAccent,
              titleColor: Colors.redAccent,
              onTap: () {
                // TODO: Logout
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _divider(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Divider(
      height: 1,
      indent: 62,
      color: colorScheme.onSurface.withValues(
        alpha: 0.08,
      ),
    );
  }

  // =========================================================
  // LANGUAGE BOTTOM SHEET
  // =========================================================

  void _showLanguageBottomSheet() {
    final theme = Theme.of(context);

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) {
        return Container(
          padding: const EdgeInsets.fromLTRB(
            20,
            12,
            20,
            30,
          ),
          decoration: BoxDecoration(
            color: theme.scaffoldBackgroundColor,
            borderRadius: const BorderRadius.vertical(
              top: Radius.circular(28),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [

              Container(
                width: 40,
                height: 4,
                margin: const EdgeInsets.only(
                  bottom: 22,
                ),
                decoration: BoxDecoration(
                  color: theme.colorScheme.onSurface
                      .withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(20),
                ),
              ),

              Text(
                'language'.tr(),
                style: TextStyle(
                  fontSize: 19,
                  fontWeight: FontWeight.bold,
                  color: theme.colorScheme.onSurface,
                ),
              ),

              const SizedBox(height: 18),

              _OptionTile(
                icon: Icons.language,
                title: 'العربية',
                selected: isArabic,
                onTap: () async {
                  Navigator.pop(context);
                  await _changeLanguage(
                    const Locale('ar'),
                  );
                },
              ),

              _OptionTile(
                icon: Icons.language,
                title: 'English',
                selected: !isArabic,
                onTap: () async {
                  Navigator.pop(context);
                  await _changeLanguage(
                    const Locale('en'),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }

  // =========================================================
  // THEME BOTTOM SHEET
  // =========================================================

  void _showThemeBottomSheet() {
    final theme = Theme.of(context);

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Container(
          padding: const EdgeInsets.fromLTRB(
            20,
            12,
            20,
            30,
          ),
          decoration: BoxDecoration(
            color: theme.scaffoldBackgroundColor,
            borderRadius: const BorderRadius.vertical(
              top: Radius.circular(28),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [

              Container(
                width: 40,
                height: 4,
                margin: const EdgeInsets.only(
                  bottom: 22,
                ),
                decoration: BoxDecoration(
                  color: theme.colorScheme.onSurface
                      .withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(20),
                ),
              ),

              Text(
                'theme'.tr(),
                style: TextStyle(
                  fontSize: 19,
                  fontWeight: FontWeight.bold,
                  color: theme.colorScheme.onSurface,
                ),
              ),

              const SizedBox(height: 18),

              _OptionTile(
                icon: Icons.light_mode_outlined,
                title: 'light'.tr(),
                selected: !isDark,
                onTap: () async {
                  Navigator.pop(context);
                  await _changeTheme(
                    ThemeMode.light,
                  );
                },
              ),

              _OptionTile(
                icon: Icons.dark_mode_outlined,
                title: 'dark'.tr(),
                selected: isDark,
                onTap: () async {
                  Navigator.pop(context);
                  await _changeTheme(
                    ThemeMode.dark,
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }
}


// =========================================================
// PROFILE SETTING TILE
// =========================================================

class _ProfileSettingTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String? subtitle;
  final VoidCallback? onTap;
  final Color? iconColor;
  final Color? titleColor;

  const _ProfileSettingTile({
    required this.icon,
    required this.title,
    this.subtitle,
    this.onTap,
    this.iconColor,
    this.titleColor,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 15,
          ),
          child: Row(
            children: [

              Icon(
                icon,
                size: 23,
                color: iconColor ??
                    colorScheme.primary,
              ),

              const SizedBox(width: 16),

              Expanded(
                child: Column(
                  crossAxisAlignment:
                  CrossAxisAlignment.start,
                  children: [

                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: titleColor ??
                            colorScheme.onSurface,
                      ),
                    ),

                    if (subtitle != null) ...[
                      const SizedBox(height: 3),
                      Text(
                        subtitle!,
                        style: TextStyle(
                          fontSize: 12,
                          color: colorScheme.onSurface
                              .withValues(alpha: 0.5),
                        ),
                      ),
                    ],
                  ],
                ),
              ),

              Icon(
                Icons.arrow_forward_ios,
                size: 14,
                color: colorScheme.onSurface
                    .withValues(alpha: 0.3),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


// =========================================================
// OPTION TILE
// =========================================================

class _OptionTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final bool selected;
  final VoidCallback onTap;

  const _OptionTile({
    required this.icon,
    required this.title,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(
            milliseconds: 200,
          ),
          margin: const EdgeInsets.only(
            bottom: 8,
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 14,
          ),
          decoration: BoxDecoration(
            color: selected
                ? colorScheme.primary
                .withValues(alpha: 0.12)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: selected
                  ? colorScheme.primary
                  .withValues(alpha: 0.45)
                  : colorScheme.onSurface
                  .withValues(alpha: 0.08),
            ),
          ),
          child: Row(
            children: [

              Icon(
                icon,
                color: selected
                    ? colorScheme.primary
                    : colorScheme.onSurface
                    .withValues(alpha: 0.6),
              ),

              const SizedBox(width: 14),

              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: selected
                        ? FontWeight.w600
                        : FontWeight.w400,
                  ),
                ),
              ),

              if (selected)
                Icon(
                  Icons.check_circle,
                  color: colorScheme.primary,
                  size: 21,
                ),
            ],
          ),
        ),
      ),
    );
  }
}