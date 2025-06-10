import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:graduation_project_ui/Features/Home/presention/Models/BottomNavigationModel.dart';
import 'package:graduation_project_ui/core/Utils/AppColors.dart';
import 'package:graduation_project_ui/core/Utils/animation_utils.dart';
import 'package:flutter_animate/flutter_animate.dart';

class Custombottomnavigatiorbar extends StatefulWidget {
  const Custombottomnavigatiorbar({super.key, required this.onItemTapped});

  final ValueChanged<int> onItemTapped;

  @override
  State<Custombottomnavigatiorbar> createState() =>
      _CustombottomnavigatiorbarState();
}

class _CustombottomnavigatiorbarState extends State<Custombottomnavigatiorbar>
    with TickerProviderStateMixin {
  int selectedIndex = 0;
  late List<AnimationController> _controllers;

  @override
  void initState() {
    super.initState();
    _controllers = List.generate(
      BottomNavigationBarList.length,
      (index) => AnimationController(
        duration: AnimationUtils.bottomNavDuration,
        vsync: this,
      ),
    );
    // Animate the first item as selected
    _controllers[0].forward();
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 70,
      decoration: const ShapeDecoration(
        color: KPrimaryColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
      ),
      child: Row(
        children: BottomNavigationBarList.asMap().entries.map((e) {
          var index = e.key;
          var itemS = e.value;
          return Expanded(
            child: GestureDetector(
              onTap: () {
                // Animate out previous selection
                _controllers[selectedIndex].reverse();

                setState(() {
                  selectedIndex = index;
                  widget.onItemTapped(index);
                });

                // Animate in new selection
                _controllers[index].forward();
              },
              child: AnimatedBuilder(
                animation: _controllers[index],
                builder: (context, child) {
                  return navigatorIcon(
                    isActive: selectedIndex == index,
                    bottomNavigationBarEntity: itemS,
                    animationValue: _controllers[index].value,
                  );
                },
              ),
            ),
          );
        }).toList(),
      ),
    ).animate().slideY(
          begin: 1,
          end: 0,
          duration: 800.ms,
          delay: 500.ms,
          curve: AnimationUtils.defaultCurve,
        );
  }
}

class navigatorIcon extends StatelessWidget {
  const navigatorIcon({
    super.key,
    required this.isActive,
    required this.bottomNavigationBarEntity,
    required this.animationValue,
  });

  final bool isActive;
  final BottomNavigationBarEntity bottomNavigationBarEntity;
  final double animationValue;

  @override
  Widget build(BuildContext context) {
    return Transform.scale(
      scale: 1.0 + (animationValue * 0.1),
      child: isActive
          ? ActiveIcon(
              image: bottomNavigationBarEntity.Activeimage,
              title: bottomNavigationBarEntity.title,
              animationValue: animationValue,
            )
          : inActiveIcon(
              image: bottomNavigationBarEntity.Activeimage,
              animationValue: animationValue,
            ),
    );
  }
}

class inActiveIcon extends StatelessWidget {
  const inActiveIcon({
    super.key,
    required this.image,
    required this.animationValue,
  });

  final String image;
  final double animationValue;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: AnimationUtils.bottomNavDuration,
      curve: AnimationUtils.smoothCurve,
      padding: EdgeInsets.all(8 + (animationValue * 4)),
      child: SvgPicture.asset(
        image,
        colorFilter: ColorFilter.mode(
          Color.lerp(Colors.grey, Colors.white, animationValue) ?? Colors.grey,
          BlendMode.srcIn,
        ),
      ),
    );
  }
}

class ActiveIcon extends StatelessWidget {
  const ActiveIcon({
    super.key,
    required this.image,
    required this.title,
    required this.animationValue,
  });

  final String image, title;
  final double animationValue;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AnimatedContainer(
        duration: AnimationUtils.bottomNavDuration,
        curve: AnimationUtils.bounceCurve,
        decoration: BoxDecoration(
          color: Color.lerp(
            const Color(0xFFEEEEEE).withOpacity(0.3),
            const Color(0xFFEEEEEE),
            animationValue,
          ),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1 * animationValue),
              blurRadius: 8 * animationValue,
              offset: Offset(0, 2 * animationValue),
            ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            AnimatedContainer(
              duration: AnimationUtils.bottomNavDuration,
              width: 30,
              height: 30,
              decoration: ShapeDecoration(
                color: KPrimaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              child: Center(
                child: SizedBox(
                  height: 15,
                  width: 15,
                  child: SvgPicture.asset(image).animate().scale(
                        begin: const Offset(0.8, 0.8),
                        end: const Offset(1.0, 1.0),
                        duration: AnimationUtils.bottomNavDuration,
                        curve: AnimationUtils.bounceCurve,
                      ),
                ),
              ),
            ),
            AnimatedContainer(
              duration: AnimationUtils.bottomNavDuration,
              height: 20,
              width: 60 * animationValue,
              child: animationValue > 0.5
                  ? Center(
                      child: Text(
                        title,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 13,
                          fontWeight: FontWeight.w800,
                        ),
                      ).animate().fadeIn(
                            duration: AnimationUtils.bottomNavDuration,
                            delay: 100.ms,
                          ),
                    )
                  : null,
            ),
          ],
        ),
      ),
    );
  }
}
