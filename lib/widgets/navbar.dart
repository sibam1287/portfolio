import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:portfolio/constants/colors.dart';
import 'package:portfolio/providers/theme_provider.dart';
import 'package:provider/provider.dart';

class Navbar extends StatelessWidget implements PreferredSizeWidget {
  final Function(int) onNavItemTap;

  const Navbar({super.key, required this.onNavItemTap});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDark = themeProvider.isDarkMode;
    final theme = Theme.of(context);

    return PreferredSize(
      preferredSize: preferredSize,
      child: ClipRRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Container(
            height: kToolbarHeight + MediaQuery.of(context).padding.top,
            padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
            decoration: BoxDecoration(
              color: theme.scaffoldBackgroundColor.withOpacity(0.7),
              border: Border(
                bottom: BorderSide(
                  color: Colors.white.withOpacity(0.1),
                  width: 1,
                ),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Row(
                children: [
                  Text(
                    'PORTFOLIO',
                    style: TextStyle(
                      color: AppColors.primary,
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                      letterSpacing: 2,
                    ),
                  ),
                  const Spacer(),
                  _navItem('Home', 0, context),
                  _navItem('About', 1, context),
                  _navItem('Skills', 2, context),
                  _navItem('Projects', 3, context),
                  _navItem('Contact', 4, context),
                  const SizedBox(width: 20),
                  Container(
                    decoration: BoxDecoration(
                      color: AppColors.primary.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: IconButton(
                      onPressed: () => themeProvider.toggleTheme(),
                      icon: Icon(isDark ? Icons.light_mode : Icons.dark_mode),
                      color: isDark ? Colors.orange : AppColors.primary,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _navItem(String title, int index, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: TextButton(
        onPressed: () => onNavItemTap(index),
        style: TextButton.styleFrom(
          foregroundColor: Theme.of(context).textTheme.bodyLarge?.color,
        ),
        child: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.w500),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(70);
}
