import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:portfolio/constants/colors.dart';
import 'package:portfolio/sections/about_section.dart';
import 'package:portfolio/sections/contact_section.dart';
import 'package:portfolio/sections/home_section.dart';
import 'package:portfolio/sections/projects_section.dart';
import 'package:portfolio/sections/skills_section.dart';
import 'package:portfolio/widgets/navbar.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final ScrollController _scrollController = ScrollController();
  final List<GlobalKey> _sectionKeys = List.generate(5, (index) => GlobalKey());

  void _scrollToSection(int index) {
    final context = _sectionKeys[index].currentContext;
    if (context != null) {
      Scrollable.ensureVisible(
        context,
        duration: const Duration(milliseconds: 1000),
        curve: Curves.easeInOutQuart,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: Navbar(onNavItemTap: _scrollToSection),
      body: Stack(
        children: [
          _buildAnimatedBackground(),
          SingleChildScrollView(
            controller: _scrollController,
            child: Column(
              children: [
                HomeSection(key: _sectionKeys[0]),
                AboutSection(key: _sectionKeys[1], scrollController: _scrollController),
                SkillsSection(key: _sectionKeys[2]),
                ProjectsSection(key: _sectionKeys[3]),
                ContactSection(key: _sectionKeys[4]),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAnimatedBackground() {
    return Stack(
      children: [
        Positioned(
          top: -100,
          right: -100,
          child: _backgroundBlob(AppColors.accent1, 600),
        ).animate(onPlay: (controller) => controller.repeat(reverse: true))
         .move(begin: const Offset(0, 0), end: const Offset(-100, 100), duration: 15.seconds),
        
        Positioned(
          bottom: -100,
          left: -150,
          child: _backgroundBlob(AppColors.accent2, 700),
        ).animate(onPlay: (controller) => controller.repeat(reverse: true))
         .move(begin: const Offset(0, 0), end: const Offset(100, -100), duration: 20.seconds),
      ],
    );
  }

  Widget _backgroundBlob(Color color, double size) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: RadialGradient(
          colors: [
            color.withValues(alpha: 0.2),
            color.withValues(alpha: 0.0),
          ],
        ),
      ),
    );
  }
}
