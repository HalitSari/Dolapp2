import 'package:flutter/material.dart';
import 'package:dolaptakip/l10n/app_localizations.dart';

class CustomBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const CustomBottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Container(
      margin: const EdgeInsets.fromLTRB(24, 0, 24, 24),
      decoration: BoxDecoration(
        color: Theme.of(
          context,
        ).cardColor.withAlpha(240), // Adaptive background
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(
              Theme.of(context).brightness == Brightness.dark ? 80 : 20,
            ),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
          BoxShadow(
            color: Theme.of(context).primaryColor.withAlpha(20),
            blurRadius: 20,
            spreadRadius: -5,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30),
        child: BottomNavigationBar(
          currentIndex: currentIndex,
          onTap: onTap,
          backgroundColor: Colors.transparent, // Transparent to show container
          selectedItemColor: Theme.of(context).primaryColor,
          unselectedItemColor: Colors.grey.withAlpha(128),
          showSelectedLabels: false, // Minimalist look
          showUnselectedLabels: false,
          elevation: 0,
          type: BottomNavigationBarType.fixed,
          items: [
            BottomNavigationBarItem(
              icon: const Icon(Icons.home_rounded),
              activeIcon: const Icon(Icons.home_rounded, size: 28),
              label: l10n.tabHome,
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.warning_amber_rounded),
              activeIcon: const Icon(Icons.warning_amber_rounded, size: 28),
              label: l10n.tabExpired,
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.restaurant_menu_rounded),
              activeIcon: const Icon(Icons.restaurant_menu_rounded, size: 28),
              label: l10n.tabRecipes,
            ),
          ],
        ),
      ),
    );
  }
}
