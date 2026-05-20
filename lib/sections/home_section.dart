import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:portfolio/constants/colors.dart';

class HomeSection extends StatelessWidget {
  const HomeSection({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final theme = Theme.of(context);
    
    return Container(
      height: size.height,
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "WELCOME TO MY UNIVERSE",
                style: TextStyle(
                  color: AppColors.secondary,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 4,
                ),
              ).animate().fadeIn(duration: 800.ms).slideX(begin: -0.5),
              const SizedBox(height: 20),
              SizedBox(
                height: 200,
                child: DefaultTextStyle(
                  style: TextStyle(
                    color: theme.textTheme.displayLarge?.color,
                    fontSize: 80,
                    fontWeight: FontWeight.w900,
                    height: 1.1,
                    fontFamily: theme.textTheme.displayLarge?.fontFamily,
                  ),
                  child: AnimatedTextKit(
                    animatedTexts: [
                      TypewriterAnimatedText('Building Digital\nExperiences.'),
                      TypewriterAnimatedText('Designing Future\nInterfaces.'),
                      TypewriterAnimatedText('Engineering Mobile\nSolutions.'),
                    ],
                    repeatForever: true,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Container(
                    width: 40,
                    height: 2,
                    color: AppColors.primary,
                  ).animate().scaleX(delay: 800.ms, duration: 400.ms),
                  const SizedBox(width: 15),
                  Text(
                    "I am John Doe, a Creative Developer.",
                    style: TextStyle(
                      color: theme.brightness == Brightness.dark 
                        ? AppColors.darkTextSecondary 
                        : AppColors.lightTextSecondary,
                      fontSize: 24,
                    ),
                  ).animate().fadeIn(delay: 1000.ms).moveX(begin: -20),
                ],
              ),
              const SizedBox(height: 50),
              Row(
                children: [
                  _animatedButton(
                    child: const Text(
                      "EXPLORE MY WORK",
                      style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 1.2),
                    ),
                    onPressed: () {},
                    primary: true,
                  ).animate().fadeIn(delay: 1400.ms).scale(),
                  const SizedBox(width: 25),
                  _animatedButton(
                    child: const Text(
                      "GET IN TOUCH",
                      style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 1.2),
                    ),
                    onPressed: () {},
                    primary: false,
                    theme: theme,
                  ).animate().fadeIn(delay: 1600.ms).scale(),
                ],
              ),
            ],
          ),
          Positioned(
            bottom: 40,
            left: size.width / 2 - 20,
            child: Column(
              children: [
                const Icon(Icons.keyboard_arrow_down, size: 30)
                    .animate(onPlay: (c) => c.repeat())
                    .moveY(begin: 0, end: 10, duration: 1.seconds)
                    .fadeIn(duration: 1.seconds),
                const Text("SCROLL", style: TextStyle(fontSize: 10, letterSpacing: 2))
                    .animate().fadeIn(delay: 2.seconds),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _animatedButton({
    required Widget child,
    required VoidCallback onPressed,
    required bool primary,
    ThemeData? theme,
  }) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: primary ? [
          BoxShadow(
            color: AppColors.primary.withOpacity(0.3),
            blurRadius: 20,
            offset: const Offset(0, 10),
          )
        ] : [],
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: primary ? AppColors.primary : Colors.transparent,
          foregroundColor: primary ? Colors.white : theme?.textTheme.bodyLarge?.color,
          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 25),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
            side: primary ? BorderSide.none : BorderSide(color: AppColors.primary, width: 2),
          ),
          elevation: 0,
        ),
        child: child,
      ),
    );
  }
}
