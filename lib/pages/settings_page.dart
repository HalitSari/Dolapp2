import 'package:dolaptakip/providers/language_provider.dart';
import 'package:dolaptakip/providers/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:dolaptakip/l10n/app_localizations.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final languageProvider = Provider.of<LanguageProvider>(context);
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.settingsPageTitle),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // --- Language Settings ---
          Padding(
            padding: const EdgeInsets.only(left: 12, bottom: 8),
            child: Text(
              l10n.settingsLanguageTitle,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.grey,
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withAlpha(10),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              children: [
                _buildLanguageOption(
                  context,
                  title: l10n.languageTr,
                  code: 'tr',
                  currentLocale: languageProvider.locale,
                  onChanged: (locale) => languageProvider.setLocale(locale),
                ),
                Divider(height: 1, color: Colors.grey.withAlpha(20)),
                _buildLanguageOption(
                  context,
                  title: l10n.languageEn,
                  code: 'en',
                  currentLocale: languageProvider.locale,
                  onChanged: (locale) => languageProvider.setLocale(locale),
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),

          // --- Theme Settings ---
          Padding(
            padding: const EdgeInsets.only(left: 12, bottom: 8),
            child: Text(
              l10n.settingsThemeTitle,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.grey,
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withAlpha(10),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              children: [
                _buildThemeOption(
                  context,
                  title: l10n.themeLight,
                  icon: Icons.light_mode_rounded,
                  value: ThemeMode.light,
                  groupValue: themeProvider.themeMode,
                  onChanged: (val) => themeProvider.setThemeMode(val!),
                ),
                Divider(height: 1, color: Colors.grey.withAlpha(20)),
                _buildThemeOption(
                  context,
                  title: l10n.themeDark,
                  icon: Icons.dark_mode_rounded,
                  value: ThemeMode.dark,
                  groupValue: themeProvider.themeMode,
                  onChanged: (val) => themeProvider.setThemeMode(val!),
                ),
                Divider(height: 1, color: Colors.grey.withAlpha(20)),
                _buildThemeOption(
                  context,
                  title: l10n.themeSystem,
                  icon: Icons.settings_system_daydream_rounded,
                  value: ThemeMode.system,
                  groupValue: themeProvider.themeMode,
                  onChanged: (val) => themeProvider.setThemeMode(val!),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLanguageOption(
    BuildContext context, {
    required String title,
    required String code,
    required Locale currentLocale,
    required ValueChanged<Locale> onChanged,
  }) {
    final isSelected = currentLocale.languageCode == code;
    return ListTile(
      title: Text(
        title,
        style: TextStyle(
          fontWeight: FontWeight.w500,
          color: Theme.of(context).textTheme.bodyMedium?.color,
        ),
      ),
      trailing: isSelected
          ? Icon(
              Icons.check_circle_rounded,
              color: Theme.of(context).primaryColor,
            )
          : null,
      onTap: () {
        // Construct locale based on code
        final locale = code == 'tr'
            ? const Locale('tr', 'TR')
            : const Locale('en', 'US');
        onChanged(locale);
      },
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    );
  }

  Widget _buildThemeOption(
    BuildContext context, {
    required String title,
    required IconData icon,
    required ThemeMode value,
    required ThemeMode groupValue,
    required ValueChanged<ThemeMode?> onChanged,
  }) {
    final isSelected = value == groupValue;
    return ListTile(
      onTap: () => onChanged(value),
      title: Row(
        children: [
          Icon(icon, size: 20, color: Theme.of(context).iconTheme.color),
          const SizedBox(width: 12),
          Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.w500,
              color: Theme.of(context).textTheme.bodyMedium?.color,
            ),
          ),
        ],
      ),
      trailing: isSelected
          ? Icon(
              Icons.check_circle_rounded,
              color: Theme.of(context).primaryColor,
            )
          : null,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    );
  }
}
