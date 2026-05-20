import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:portfolio/constants/colors.dart';
import 'package:portfolio/models/project.dart';
import 'package:portfolio/widgets/animated_card.dart';
import 'package:visibility_detector/visibility_detector.dart';

class ProjectsSection extends StatefulWidget {
  const ProjectsSection({super.key});

  @override
  State<ProjectsSection> createState() => _ProjectsSectionState();
}

class _ProjectsSectionState extends State<ProjectsSection> {
  bool _isVisible = false;

  final List<Project> mockProjects = [
    Project(
      title: "Zenith Commerce",
      description: "A premium shopping experience with seamless animations and global payments.",
      imageUrl: "https://images.unsplash.com/photo-1557821552-17105176677c?fit=crop&w=800&h=600",
      technologies: ["Flutter", "Firebase", "Stripe", "Node.js",],
    ),
    Project(
      title: "Orbit Task",
      description: "Collaborative project management tool for creative teams.",
      imageUrl: "https://images.unsplash.com/photo-1540350394557-8d14678e7f91?fit=crop&w=800&h=600",
      technologies: ["Flutter", "Riverpod", "Go", "PostgreSQL"],
    ),
    Project(
      title: "Vivid Weather",
      description: "Hyper-local weather forecasts with stunning data visualizations.",
      imageUrl: "https://images.unsplash.com/photo-1504608524841-42fe6f032b4b?fit=crop&w=800&h=600",
      technologies: ["Flutter", "OpenWeather", "Canvas"],
    ),
    Project(
      title: "Crypto Pulse",
      description: "Real-time cryptocurrency tracker with interactive market charts.",
      imageUrl: "https://images.unsplash.com/photo-1518546305927-5a555bb7020d?fit=crop&w=800&h=600",
      technologies: ["Flutter", "WebSocket", "Redux"],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return VisibilityDetector(
      key: const Key('projects-section'),
      onVisibilityChanged: (info) {
        if (info.visibleFraction > 0.1 && !_isVisible) {
          setState(() => _isVisible = true);
        }
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 120, horizontal: 40),
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _sectionTitle("PORTFOLIO", theme),
            const SizedBox(height: 60),
            if (_isVisible)
              AnimationLimiter(
                child: GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 40,
                    mainAxisSpacing: 40,
                    childAspectRatio: 1.1,
                  ),
                  itemCount: mockProjects.length,
                  itemBuilder: (context, index) {
                    return AnimationConfiguration.staggeredGrid(
                      position: index,
                      duration: const Duration(milliseconds: 1000),
                      columnCount: 2,
                      child: SlideAnimation(
                        verticalOffset: 100,
                        child: FadeInAnimation(
                          child: _projectCard(mockProjects[index], theme, isDark),
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

  Widget _projectCard(Project project, ThemeData theme, bool isDark) {
    return AnimatedCard(
      opacity: 0.05,
      blur: 20,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 3,
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(project.imageUrl),
                  fit: BoxFit.cover,
                ),
              ),
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      Colors.black.withOpacity(0.7),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Flexible(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          project.title,
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          project.description,
                          style: TextStyle(
                            color: isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary,
                            fontSize: 14,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: project.technologies.take(4).map((tech) {
                        return Container(
                          margin: const EdgeInsets.only(right: 10),
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            color: AppColors.primary.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: AppColors.primary.withOpacity(0.2)),
                          ),
                          child: Text(
                            tech,
                            style: const TextStyle(
                              color: AppColors.primary,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
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
