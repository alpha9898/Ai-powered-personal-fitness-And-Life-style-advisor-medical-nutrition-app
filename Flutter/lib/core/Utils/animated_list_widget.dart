import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:graduation_project_ui/core/Utils/animation_utils.dart';
import 'package:flutter_animate/flutter_animate.dart';

/// Animated ListView with staggered animations
class AnimatedListWidget extends StatelessWidget {
  final int itemCount;
  final IndexedWidgetBuilder itemBuilder;
  final ScrollController? controller;
  final EdgeInsets? padding;
  final ScrollPhysics? physics;
  final bool shrinkWrap;
  final Axis scrollDirection;
  final Duration animationDuration;
  final Duration delayBetweenItems;

  const AnimatedListWidget({
    super.key,
    required this.itemCount,
    required this.itemBuilder,
    this.controller,
    this.padding,
    this.physics,
    this.shrinkWrap = false,
    this.scrollDirection = Axis.vertical,
    this.animationDuration = const Duration(milliseconds: 375),
    this.delayBetweenItems = const Duration(milliseconds: 100),
  });

  @override
  Widget build(BuildContext context) {
    return AnimationLimiter(
      child: ListView.builder(
        controller: controller,
        padding: padding,
        physics: physics,
        shrinkWrap: shrinkWrap,
        scrollDirection: scrollDirection,
        itemCount: itemCount,
        itemBuilder: (context, index) {
          return AnimationConfiguration.staggeredList(
            position: index,
            duration: animationDuration,
            delay: delayBetweenItems,
            child: SlideAnimation(
              verticalOffset: scrollDirection == Axis.vertical ? 50.0 : 0.0,
              horizontalOffset: scrollDirection == Axis.horizontal ? 50.0 : 0.0,
              curve: AnimationUtils.defaultCurve,
              child: FadeInAnimation(
                curve: AnimationUtils.smoothCurve,
                child: itemBuilder(context, index),
              ),
            ),
          );
        },
      ),
    );
  }
}

/// Animated GridView with staggered animations
class AnimatedGridWidget extends StatelessWidget {
  final int itemCount;
  final IndexedWidgetBuilder itemBuilder;
  final SliverGridDelegate gridDelegate;
  final ScrollController? controller;
  final EdgeInsets? padding;
  final ScrollPhysics? physics;
  final bool shrinkWrap;
  final Axis scrollDirection;
  final Duration animationDuration;
  final Duration delayBetweenItems;

  const AnimatedGridWidget({
    super.key,
    required this.itemCount,
    required this.itemBuilder,
    required this.gridDelegate,
    this.controller,
    this.padding,
    this.physics,
    this.shrinkWrap = false,
    this.scrollDirection = Axis.vertical,
    this.animationDuration = const Duration(milliseconds: 375),
    this.delayBetweenItems = const Duration(milliseconds: 50),
  });

  @override
  Widget build(BuildContext context) {
    return AnimationLimiter(
      child: GridView.builder(
        controller: controller,
        padding: padding,
        physics: physics,
        shrinkWrap: shrinkWrap,
        scrollDirection: scrollDirection,
        gridDelegate: gridDelegate,
        itemCount: itemCount,
        itemBuilder: (context, index) {
          return AnimationConfiguration.staggeredGrid(
            position: index,
            duration: animationDuration,
            delay: delayBetweenItems,
            columnCount:
                (gridDelegate as SliverGridDelegateWithFixedCrossAxisCount?)
                        ?.crossAxisCount ??
                    2,
            child: ScaleAnimation(
              curve: AnimationUtils.bounceCurve,
              child: FadeInAnimation(
                curve: AnimationUtils.smoothCurve,
                child: itemBuilder(context, index),
              ),
            ),
          );
        },
      ),
    );
  }
}

/// Animated Card Widget with hover and tap effects
class AnimatedCard extends StatefulWidget {
  final Widget child;
  final VoidCallback? onTap;
  final EdgeInsets? margin;
  final EdgeInsets? padding;
  final Color? backgroundColor;
  final BorderRadius? borderRadius;
  final List<BoxShadow>? boxShadow;
  final double? elevation;
  final Duration animationDuration;
  final bool enableHoverEffect;

  const AnimatedCard({
    super.key,
    required this.child,
    this.onTap,
    this.margin,
    this.padding,
    this.backgroundColor,
    this.borderRadius,
    this.boxShadow,
    this.elevation,
    this.animationDuration = const Duration(milliseconds: 200),
    this.enableHoverEffect = true,
  });

  @override
  State<AnimatedCard> createState() => _AnimatedCardState();
}

class _AnimatedCardState extends State<AnimatedCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _elevationAnimation;
  bool _isHovered = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.animationDuration,
      vsync: this,
    );

    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 0.98,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));

    _elevationAnimation = Tween<double>(
      begin: widget.elevation ?? 4.0,
      end: (widget.elevation ?? 4.0) + 4.0,
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
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Transform.scale(
          scale: _scaleAnimation.value,
          child: MouseRegion(
            onEnter: widget.enableHoverEffect ? (_) => _onHover(true) : null,
            onExit: widget.enableHoverEffect ? (_) => _onHover(false) : null,
            child: GestureDetector(
              onTapDown: (_) => _controller.forward(),
              onTapUp: (_) {
                _controller.reverse();
                widget.onTap?.call();
              },
              onTapCancel: () => _controller.reverse(),
              child: Container(
                margin: widget.margin ?? const EdgeInsets.all(8),
                padding: widget.padding ?? const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: widget.backgroundColor ?? Theme.of(context).cardColor,
                  borderRadius:
                      widget.borderRadius ?? BorderRadius.circular(12),
                  boxShadow: widget.boxShadow ??
                      [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: _isHovered
                              ? _elevationAnimation.value
                              : (widget.elevation ?? 4.0),
                          offset: Offset(0, _isHovered ? 4 : 2),
                        ),
                      ],
                ),
                child: widget.child,
              ),
            ),
          ),
        );
      },
    );
  }

  void _onHover(bool isHovered) {
    setState(() {
      _isHovered = isHovered;
    });
  }
}

/// Animated Container with entrance animation
class AnimatedEntranceContainer extends StatelessWidget {
  final Widget child;
  final Duration delay;
  final Duration duration;
  final AnimationType animationType;

  const AnimatedEntranceContainer({
    super.key,
    required this.child,
    this.delay = Duration.zero,
    this.duration = const Duration(milliseconds: 400),
    this.animationType = AnimationType.fadeInUp,
  });

  @override
  Widget build(BuildContext context) {
    switch (animationType) {
      case AnimationType.fadeInUp:
        return child
            .animate()
            .fadeIn(
              delay: delay,
              duration: duration,
              curve: AnimationUtils.smoothCurve,
            )
            .slideY(
              begin: 0.2,
              end: 0,
              delay: delay,
              duration: duration,
              curve: AnimationUtils.defaultCurve,
            );
      case AnimationType.fadeInLeft:
        return child
            .animate()
            .fadeIn(
              delay: delay,
              duration: duration,
              curve: AnimationUtils.smoothCurve,
            )
            .slideX(
              begin: -0.2,
              end: 0,
              delay: delay,
              duration: duration,
              curve: AnimationUtils.defaultCurve,
            );
      case AnimationType.fadeInRight:
        return child
            .animate()
            .fadeIn(
              delay: delay,
              duration: duration,
              curve: AnimationUtils.smoothCurve,
            )
            .slideX(
              begin: 0.2,
              end: 0,
              delay: delay,
              duration: duration,
              curve: AnimationUtils.defaultCurve,
            );
      case AnimationType.fadeInScale:
        return child
            .animate()
            .fadeIn(
              delay: delay,
              duration: duration,
              curve: AnimationUtils.smoothCurve,
            )
            .scale(
              begin: const Offset(0.8, 0.8),
              end: const Offset(1.0, 1.0),
              delay: delay,
              duration: duration,
              curve: AnimationUtils.bounceCurve,
            );
      case AnimationType.fadeIn:
        return child.animate().fadeIn(
              delay: delay,
              duration: duration,
              curve: AnimationUtils.smoothCurve,
            );
    }
  }
}

enum AnimationType {
  fadeInUp,
  fadeInLeft,
  fadeInRight,
  fadeInScale,
  fadeIn,
}
