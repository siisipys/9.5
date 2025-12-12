import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

/// Animated Background with geometric shapes
/// Creates a dynamic, living background with floating shapes
class AnimatedBackground extends StatefulWidget {
  final Widget child;
  
  const AnimatedBackground({super.key, required this.child});
  
  @override
  State<AnimatedBackground> createState() => _AnimatedBackgroundState();
}

class _AnimatedBackgroundState extends State<AnimatedBackground>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 20),
      vsync: this,
    )..repeat();
  }
  
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Base gradient
        Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: AppColors.gradientPrimary,
            ),
          ),
        ),
        
        // Animated shapes
        AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return CustomPaint(
              painter: _BackgroundPainter(
                animation: _controller.value,
              ),
              size: Size.infinite,
            );
          },
        ),
        
        // Content
        widget.child,
      ],
    );
  }
}

class _BackgroundPainter extends CustomPainter {
  final double animation;
  
  _BackgroundPainter({required this.animation});
  
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..style = PaintingStyle.fill;
    
    // Draw floating circles
    _drawFloatingCircle(
      canvas, size,
      paint: paint..color = AppColors.accentCoral.withOpacity(0.08),
      centerX: size.width * 0.2,
      centerY: size.height * 0.3,
      radius: 150,
      offset: animation,
    );
    
    _drawFloatingCircle(
      canvas, size,
      paint: paint..color = AppColors.accentGold.withOpacity(0.06),
      centerX: size.width * 0.8,
      centerY: size.height * 0.7,
      radius: 200,
      offset: animation * 0.7,
    );
    
    _drawFloatingCircle(
      canvas, size,
      paint: paint..color = AppColors.success.withOpacity(0.05),
      centerX: size.width * 0.5,
      centerY: size.height * 0.1,
      radius: 120,
      offset: animation * 1.3,
    );
    
    _drawFloatingCircle(
      canvas, size,
      paint: paint..color = AppColors.primaryLight.withOpacity(0.15),
      centerX: size.width * 0.9,
      centerY: size.height * 0.2,
      radius: 80,
      offset: animation * 0.5,
    );
  }
  
  void _drawFloatingCircle(
    Canvas canvas,
    Size size, {
    required Paint paint,
    required double centerX,
    required double centerY,
    required double radius,
    required double offset,
  }) {
    final x = centerX + math.sin(offset * 2 * math.pi) * 30;
    final y = centerY + math.cos(offset * 2 * math.pi) * 20;
    
    canvas.drawCircle(Offset(x, y), radius, paint);
  }
  
  @override
  bool shouldRepaint(covariant _BackgroundPainter oldDelegate) {
    return oldDelegate.animation != animation;
  }
}
