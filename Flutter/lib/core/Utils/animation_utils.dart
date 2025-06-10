import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';

/// Animation utilities and constants for the FitApp
class AnimationUtils {
  // Duration constants
  static const Duration splashDuration = Duration(milliseconds: 1200);
  static const Duration pageTransitionDuration = Duration(milliseconds: 600);
  static const Duration cardAnimationDuration = Duration(milliseconds: 400);
  static const Duration buttonAnimationDuration = Duration(milliseconds: 200);
  static const Duration bottomNavDuration = Duration(milliseconds: 300);

  // Curve constants
  static const Curve defaultCurve = Curves.easeInOutCubic;
  static const Curve bounceCurve = Curves.elasticOut;
  static const Curve smoothCurve = Curves.easeOutQuad;

  // Common animation effects
  static List<Effect> fadeInUp({
    Duration? delay,
    Duration? duration,
  }) =>
      [
        FadeEffect(
          delay: delay ?? 0.ms,
          duration: duration ?? cardAnimationDuration,
          begin: 0,
          end: 1,
          curve: defaultCurve,
        ),
        SlideEffect(
          delay: delay ?? 0.ms,
          duration: duration ?? cardAnimationDuration,
          begin: const Offset(0, 50),
          end: Offset.zero,
          curve: defaultCurve,
        ),
      ];

  static List<Effect> fadeInScale({
    Duration? delay,
    Duration? duration,
  }) =>
      [
        FadeEffect(
          delay: delay ?? 0.ms,
          duration: duration ?? cardAnimationDuration,
          begin: 0,
          end: 1,
          curve: defaultCurve,
        ),
        ScaleEffect(
          delay: delay ?? 0.ms,
          duration: duration ?? cardAnimationDuration,
          begin: const Offset(0.8, 0.8),
          end: const Offset(1.0, 1.0),
          curve: bounceCurve,
        ),
      ];

  static List<Effect> slideInLeft({
    Duration? delay,
    Duration? duration,
  }) =>
      [
        SlideEffect(
          delay: delay ?? 0.ms,
          duration: duration ?? cardAnimationDuration,
          begin: const Offset(-100, 0),
          end: Offset.zero,
          curve: defaultCurve,
        ),
        FadeEffect(
          delay: delay ?? 0.ms,
          duration: duration ?? cardAnimationDuration,
          begin: 0,
          end: 1,
          curve: defaultCurve,
        ),
      ];

  static List<Effect> slideInRight({
    Duration? delay,
    Duration? duration,
  }) =>
      [
        SlideEffect(
          delay: delay ?? 0.ms,
          duration: duration ?? cardAnimationDuration,
          begin: const Offset(100, 0),
          end: Offset.zero,
          curve: defaultCurve,
        ),
        FadeEffect(
          delay: delay ?? 0.ms,
          duration: duration ?? cardAnimationDuration,
          begin: 0,
          end: 1,
          curve: defaultCurve,
        ),
      ];

  static List<Effect> buttonPressEffect() => [
        ScaleEffect(
          duration: buttonAnimationDuration,
          begin: const Offset(1.0, 1.0),
          end: const Offset(0.95, 0.95),
          curve: Curves.easeInOut,
        ),
      ];

  /// Custom page transition builder for smooth navigation
  static Page<T> buildPageTransition<T extends Object?>({
    required Widget child,
    required LocalKey key,
    SlideDirection direction = SlideDirection.leftToRight,
  }) {
    return CustomTransitionPage<T>(
      key: key,
      child: child,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        Offset begin;
        switch (direction) {
          case SlideDirection.leftToRight:
            begin = const Offset(-1.0, 0.0);
            break;
          case SlideDirection.rightToLeft:
            begin = const Offset(1.0, 0.0);
            break;
          case SlideDirection.topToBottom:
            begin = const Offset(0.0, -1.0);
            break;
          case SlideDirection.bottomToTop:
            begin = const Offset(0.0, 1.0);
            break;
        }

        const end = Offset.zero;
        final tween = Tween(begin: begin, end: end).chain(
          CurveTween(curve: defaultCurve),
        );

        return SlideTransition(
          position: animation.drive(tween),
          child: FadeTransition(
            opacity: animation.drive(
              Tween(begin: 0.0, end: 1.0).chain(
                CurveTween(curve: smoothCurve),
              ),
            ),
            child: child,
          ),
        );
      },
      transitionDuration: pageTransitionDuration,
      reverseTransitionDuration: pageTransitionDuration,
    );
  }
}

enum SlideDirection {
  leftToRight,
  rightToLeft,
  topToBottom,
  bottomToTop,
}

/// Animated Loading Widget
class AnimatedLoadingWidget extends StatelessWidget {
  final String? text;
  final Color? color;

  const AnimatedLoadingWidget({
    super.key,
    this.text,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 60,
          height: 60,
          child: CircularProgressIndicator(
            strokeWidth: 3,
            valueColor: AlwaysStoppedAnimation<Color>(
              color ?? Theme.of(context).primaryColor,
            ),
          ),
        )
            .animate(onPlay: (controller) => controller.repeat())
            .rotate(duration: 1000.ms),
        if (text != null) ...[
          const SizedBox(height: 16),
          Text(
            text!,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: color,
                ),
          )
              .animate(onPlay: (controller) => controller.repeat(reverse: true))
              .fadeIn(duration: 800.ms)
              .fadeOut(duration: 800.ms),
        ],
      ],
    );
  }
}

/// Animated Button Widget
class AnimatedButton extends StatefulWidget {
  final Widget child;
  final VoidCallback? onPressed;
  final Color? backgroundColor;
  final BorderRadius? borderRadius;
  final EdgeInsets? padding;

  const AnimatedButton({
    super.key,
    required this.child,
    this.onPressed,
    this.backgroundColor,
    this.borderRadius,
    this.padding,
  });

  @override
  State<AnimatedButton> createState() => _AnimatedButtonState();
}

class _AnimatedButtonState extends State<AnimatedButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: AnimationUtils.buttonAnimationDuration,
      vsync: this,
    );
    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 0.95,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => _controller.forward(),
      onTapUp: (_) {
        _controller.reverse();
        widget.onPressed?.call();
      },
      onTapCancel: () => _controller.reverse(),
      child: AnimatedBuilder(
        animation: _scaleAnimation,
        builder: (context, child) {
          return Transform.scale(
            scale: _scaleAnimation.value,
            child: Container(
              padding: widget.padding ?? const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: widget.backgroundColor ?? Theme.of(context).primaryColor,
                borderRadius: widget.borderRadius ?? BorderRadius.circular(12),
              ),
              child: widget.child,
            ),
          );
        },
      ),
    );
  }
}
