import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:portfolio/constants/colors.dart';
import 'package:visibility_detector/visibility_detector.dart';

class AboutSection extends StatefulWidget {
  final ScrollController scrollController;
  const AboutSection({super.key, required this.scrollController});

  @override
  State<AboutSection> createState() => _AboutSectionState();
}

class _AboutSectionState extends State<AboutSection> {
  bool _isVisible = false;
  double _parallaxOffset = 0;

  @override
  void initState() {
    super.initState();
    widget.scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    widget.scrollController.removeListener(_onScroll);
    super.dispose();
  }

  void _onScroll() {
    if (!mounted) return;
    setState(() {
      _parallaxOffset = widget.scrollController.offset * 0.1;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return VisibilityDetector(
      key: const Key('about-section'),
      onVisibilityChanged: (info) {
        if (info.visibleFraction > 0.1 && !_isVisible) {
          setState(() => _isVisible = true);
        }
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 120, horizontal: 40),
        width: double.infinity,
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _sectionTitle("THE STORY", theme),
                      const SizedBox(height: 40),
                      if (_isVisible) ...[
                        ShaderMask(
                          shaderCallback: (bounds) => const LinearGradient(
                            colors: [AppColors.primary, AppColors.secondary],
                          ).createShader(bounds),
                          child: Text(
                            "I turn ideas into scalable and user-friendly web applications.",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                              height: 1.3,
                            ),
                          ),
                        ).animate().fadeIn(duration: 800.ms).slideX(begin: -0.2),
                        const SizedBox(height: 30),
                        
                        SizedBox(
                          width: double.infinity,
                          child: DefaultTextStyle(
                            style: TextStyle(
                              color: isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary,
                              fontSize: 18,
                              height: 1.8,
                              fontFamily: theme.textTheme.bodyLarge?.fontFamily,
                            ),
                            child: AnimatedTextKit(
                              animatedTexts: [
                                TypewriterAnimatedText(
                                  "As a Full Stack Developer, I specialize in Java Spring Boot, Angular, Node.js, and PostgreSQL with hands-on experience in real-time production projects, Linux server deployment, API development, and frontend design. I enjoy solving complex technical problems, optimizing application performance, and building modern digital solutions that deliver a seamless user experience.\n\n"
                                  "I am continuously learning, exploring new technologies, and improving my skills to create secure, scalable, and high-performing applications.",
                                  speed: const Duration(milliseconds: 30),
                                ),
                              ],
                              isRepeatingAnimation: false,
                              displayFullTextOnTap: true,
                            ),
                          ),
                        ).animate().fadeIn(delay: 400.ms, duration: 800.ms),
                      ],
                    ],
                  ),
                ),
                const SizedBox(width: 80),
                if (_isVisible)
                  Expanded(
                    child: Transform.translate(
                      offset: Offset(0, -_parallaxOffset),
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Container(
                            width: 400,
                            height: 400,
                            decoration: BoxDecoration(
                              border: Border.all(color: AppColors.primary.withValues(alpha: 0.2), width: 2),
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ).animate(onPlay: (controller) => controller.repeat())
                           .rotate(duration: 20.seconds),
                          Container(
                            width: 320,
                            height: 450,
                            decoration: BoxDecoration(
                              color: AppColors.primary.withValues(alpha: 0.1),
                              borderRadius: BorderRadius.circular(30),
                              image: const DecorationImage(
                                image: AssetImage("assets/image.jpeg"),
                                fit: BoxFit.fill,
                              ),
                            ),
                          ).animate().fadeIn(delay: 600.ms).scale(duration: 600.ms),
                        ],
                      ),
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _sectionTitle(String title, ThemeData theme) {
    return Row(
      children: [
        Container(
          height: 1,
          width: 50,
          color: AppColors.primary,
        ),
        const SizedBox(width: 15),
        Text(
          title,
          style: const TextStyle(
            color: AppColors.primary,
            fontSize: 14,
            fontWeight: FontWeight.bold,
            letterSpacing: 3,
          ),
        ),
      ],
    );
  }
}
