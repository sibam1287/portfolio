import 'dart:ui';
import 'package:flutter/material.dart';

class AnimatedCard extends StatefulWidget {
  final Widget child;
  final double blur;
  final double opacity;
  final Color? color;
  final VoidCallback? onTap;

  const AnimatedCard({
    super.key,
    required this.child,
    this.blur = 10,
    this.opacity = 0.1,
    this.color,
    this.onTap,
  });

  @override
  State<AnimatedCard> createState() => _AnimatedCardState();
}

class _AnimatedCardState extends State<AnimatedCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
          transform: _isHovered 
            ? (Matrix4.identity()..translate(0, -10, 0)..scale(1.02))
            : Matrix4.identity(),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: widget.blur, sigmaY: widget.blur),
              child: Container(
                decoration: BoxDecoration(
                  color: (widget.color ?? theme.colorScheme.surface)
                      .withOpacity(widget.opacity),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: Colors.white.withOpacity(0.2),
                    width: 1.5,
                  ),
                  boxShadow: [
                    if (_isHovered)
                      BoxShadow(
                        color: theme.primaryColor.withOpacity(0.3),
                        blurRadius: 20,
                        offset: const Offset(0, 10),
                      ),
                  ],
                ),
                child: widget.child,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
