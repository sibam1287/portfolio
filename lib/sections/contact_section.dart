import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:portfolio/constants/colors.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:visibility_detector/visibility_detector.dart';

class ContactSection extends StatefulWidget {
  const ContactSection({super.key});

  @override
  State<ContactSection> createState() => _ContactSectionState();
}

class _ContactSectionState extends State<ContactSection> {
  bool _isVisible = false;

  Future<void> _launchUrl(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri)) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return VisibilityDetector(
      key: const Key('contact-section'),
      onVisibilityChanged: (info) {
        if (info.visibleFraction > 0.3 && !_isVisible) {
          setState(() => _isVisible = true);
        }
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 120, horizontal: 40),
        width: double.infinity,
        child: Column(
          children: [
            _sectionTitle("GET IN TOUCH", theme).animate().fadeIn(),
            const SizedBox(height: 80),
            if (_isVisible) ...[
              Text(
                "Let's Build Something\nExtraordinary Together.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: theme.textTheme.displayLarge?.color,
                  fontSize: 60,
                  fontWeight: FontWeight.w900,
                  height: 1.1,
                ),
              ).animate().fadeIn(duration: 800.ms).scale(begin: const Offset(0.9, 0.9)),
              const SizedBox(height: 40),
              Text(
                "Currently available for freelance work and full-time opportunities.\nDrop me a message and let's start a conversation.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary,
                  fontSize: 20,
                ),
              ).animate().fadeIn(delay: 400.ms),
              const SizedBox(height: 60),
              ElevatedButton(
                onPressed: () => _launchUrl("mailto:hello@example.com"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 30),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: const Text(
                  "SAY HELLO",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, letterSpacing: 2),
                ),
              ).animate(onPlay: (c) => c.repeat(reverse: true))
               .shimmer(duration: 2.seconds, color: Colors.white.withOpacity(0.3))
               .scale(begin: const Offset(1, 1), end: const Offset(1.05, 1.05), duration: 2.seconds),
              const SizedBox(height: 80),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _socialIcon(FontAwesomeIcons.github, "https://github.com", theme),
                  const SizedBox(width: 40),
                  _socialIcon(FontAwesomeIcons.linkedin, "https://linkedin.com", theme),
                  const SizedBox(width: 40),
                  _socialIcon(FontAwesomeIcons.twitter, "https://twitter.com", theme),
                  const SizedBox(width: 40),
                  _socialIcon(FontAwesomeIcons.instagram, "https://instagram.com", theme),
                ],
              ).animate().fadeIn(delay: 800.ms).moveY(begin: 30),
            ],
            const SizedBox(height: 120),
            Text(
              "DESIGNED & DEVELOPED BY JOHN DOE © 2026",
              style: TextStyle(
                color: isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary,
                fontSize: 12,
                letterSpacing: 2,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _socialIcon(dynamic icon, String url, ThemeData theme) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.primary.withOpacity(0.05),
        shape: BoxShape.circle,
        border: Border.all(color: AppColors.primary.withOpacity(0.1)),
      ),
      child: IconButton(
        onPressed: () => _launchUrl(url),
        icon: FaIcon(icon),
        color: theme.textTheme.bodyLarge?.color,
        iconSize: 24,
        padding: const EdgeInsets.all(15),
        hoverColor: AppColors.primary.withOpacity(0.2),
      ),
    );
  }

  Widget _sectionTitle(String title, ThemeData theme) {
    return Column(
      children: [
        Text(
          title,
          style: const TextStyle(
            color: AppColors.primary,
            fontSize: 14,
            fontWeight: FontWeight.bold,
            letterSpacing: 4,
          ),
        ),
        const SizedBox(height: 10),
        Container(
          height: 1,
          width: 30,
          color: AppColors.primary,
        ),
      ],
    );
  }
}
