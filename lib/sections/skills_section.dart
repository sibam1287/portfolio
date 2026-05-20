import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:portfolio/constants/colors.dart';
import 'package:visibility_detector/visibility_detector.dart';

class SkillsSection extends StatefulWidget {
  const SkillsSection({super.key});

  @override
  State<SkillsSection> createState() => _SkillsSectionState();
}

class _SkillsSectionState extends State<SkillsSection> {
  bool _isVisible = false;

  final List<Map<String, dynamic>> skills = const [
    {"name": "Java Spring Boot", "image": "assets/Java.png"},
    {"name": "Angular", "image": "assets/angular.png"},
    {"name": "Node.js & Express", "image": "assets/npde.png"},
    {"name": "PostgreSQL", "image": "assets/posgres.png"},
    {"name": "JWT Authentication", "image": "assets/JWT Authentication.png"},
    {"name": "Linux Server Deployment", "image": "assets/linuxserver.jpeg"},
   // {"name": "Docker & Redis Basics", "image": null},
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return VisibilityDetector(
      key: const Key('skills-section'),
      onVisibilityChanged: (info) {
        if (info.visibleFraction > 0.2 && !_isVisible) {
          setState(() => _isVisible = true);
        }
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 120, horizontal: 40),
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _sectionTitle("EXPERTISE", theme),
            const SizedBox(height: 60),
            if (_isVisible)
              AnimationLimiter(
                child: GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 30,
                    mainAxisSpacing: 30,
                    childAspectRatio: 2.2,
                  ),
                  itemCount: skills.length,
                  itemBuilder: (context, index) {
                    return AnimationConfiguration.staggeredGrid(
                      position: index,
                      duration: const Duration(milliseconds: 800),
                      columnCount: 3,
                      child: ScaleAnimation(
                        child: FadeInAnimation(
                          child: _skillCard(skills[index], theme),
                        ),
                      ),
                    );
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _skillCard(Map<String, dynamic> skill, ThemeData theme) {
    final hasImage = skill['image'] != null;
    
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
        image: hasImage ? DecorationImage(
          image: AssetImage(skill['image']),
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(
            Colors.black.withValues(alpha: 0.8),
            BlendMode.darken,
          ),
        ) : null,
        color: !hasImage ? Colors.white.withValues(alpha: 0.05) : null,
      ),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            skill['name'],
            style: const TextStyle(
              fontSize: 18, 
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
            textAlign: TextAlign.center,
          ),
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
