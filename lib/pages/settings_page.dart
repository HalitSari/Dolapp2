import 'package:dolaptakip/providers/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Ayarlar'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Padding(
            padding: EdgeInsets.only(left: 12, bottom: 8),
            child: Text(
              'Görünüm',
              style: TextStyle(
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
                  title: 'Aydınlık Tema',
                  icon: Icons.light_mode_rounded,
                  value: ThemeMode.light,
                  groupValue: themeProvider.themeMode,
                  onChanged: (val) => themeProvider.setThemeMode(val!),
                ),
                Divider(height: 1, color: Colors.grey.withAlpha(20)),
                _buildThemeOption(
                  context,
                  title: 'Karanlık Tema',
                  icon: Icons.dark_mode_rounded,
                  value: ThemeMode.dark,
                  groupValue: themeProvider.themeMode,
                  onChanged: (val) => themeProvider.setThemeMode(val!),
                ),
                Divider(height: 1, color: Colors.grey.withAlpha(20)),
                _buildThemeOption(
                  context,
                  title: 'Sistem Teması',
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

  Widget _buildThemeOption(
    BuildContext context, {
    required String title,
    required IconData icon,
    required ThemeMode value,
    required ThemeMode groupValue,
    required ValueChanged<ThemeMode?> onChanged,
  }) {
    return RadioListTile<ThemeMode>(
      value: value,
      groupValue: groupValue,
      onChanged: onChanged,
      activeColor: Theme.of(context).primaryColor,
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
      controlAffinity: ListTileControlAffinity.trailing,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    );
  }
}
