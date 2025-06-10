import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:graduation_project_ui/constant.dart';
import 'package:graduation_project_ui/core/Services/Fire_Base_Auth_Service.dart';
import 'package:graduation_project_ui/core/Services/Shared_Preferences_Singlton.dart';
import 'package:graduation_project_ui/core/Utils/animation_utils.dart';
import 'package:flutter_animate/flutter_animate.dart';

class SpalshviewBody extends StatefulWidget {
  const SpalshviewBody({super.key});

  @override
  State<SpalshviewBody> createState() => _SpalshviewBodyState();
}

class _SpalshviewBodyState extends State<SpalshviewBody>
    with TickerProviderStateMixin {
  late AnimationController _fadeController;
  late AnimationController _scaleController;
  late AnimationController _slideController;

  @override
  void initState() {
    super.initState();

    // Initialize animation controllers
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );

    _scaleController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );

    _slideController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    // Start animations
    _startAnimations();

    // Navigate after delay
    NavigatToHomeScreen();
  }

  void _startAnimations() async {
    // Start logo animation with delay
    await Future.delayed(const Duration(milliseconds: 500));
    _scaleController.forward();

    await Future.delayed(const Duration(milliseconds: 300));
    _fadeController.forward();

    await Future.delayed(const Duration(milliseconds: 400));
    _slideController.forward();
  }

  @override
  void dispose() {
    _fadeController.dispose();
    _scaleController.dispose();
    _slideController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          height: MediaQuery.sizeOf(context).height,
          width: MediaQuery.sizeOf(context).width,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Theme.of(context).scaffoldBackgroundColor,
                Theme.of(context).scaffoldBackgroundColor.withOpacity(0.8),
              ],
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Animated Logo
              AnimatedBuilder(
                animation: _scaleController,
                builder: (context, child) {
                  return Transform.scale(
                    scale: Curves.elasticOut.transform(_scaleController.value),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            blurRadius: 20,
                            offset: const Offset(0, 10),
                          ),
                        ],
                      ),
                      child: Image.asset(
                        'assets/images/Logo.png',
                        width: 120,
                        height: 120,
                      ),
                    ),
                  );
                },
              ).animate().shimmer(
                    duration: 2000.ms,
                    delay: 1000.ms,
                    color: Colors.white.withOpacity(0.5),
                  ),

              const SizedBox(height: 30),

              // Animated App Name
              AnimatedBuilder(
                animation: _fadeController,
                builder: (context, child) {
                  return Opacity(
                    opacity: _fadeController.value,
                    child: Transform.translate(
                      offset: Offset(
                        0,
                        50 *
                            (1 -
                                Curves.easeOutCubic
                                    .transform(_fadeController.value)),
                      ),
                      child: Image.asset('assets/images/FITBODY.png'),
                    ),
                  );
                },
              ),

              const SizedBox(height: 50),

              // Loading indicator with animation
              AnimatedBuilder(
                animation: _slideController,
                builder: (context, child) {
                  return Opacity(
                    opacity: _slideController.value,
                    child: Transform.translate(
                      offset: Offset(
                        0,
                        30 *
                            (1 -
                                Curves.easeOutCubic
                                    .transform(_slideController.value)),
                      ),
                      child: Column(
                        children: [
                          Container(
                            width: 40,
                            height: 40,
                            child: CircularProgressIndicator(
                              strokeWidth: 3,
                              valueColor: AlwaysStoppedAnimation<Color>(
                                Theme.of(context).primaryColor,
                              ),
                            ),
                          )
                              .animate(
                                  onPlay: (controller) => controller.repeat())
                              .rotate(duration: 1000.ms),
                          const SizedBox(height: 20),
                          Text(
                            'Getting Ready...',
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(
                                  color: Colors.grey[400],
                                  fontSize: 16,
                                ),
                          )
                              .animate(
                                  onPlay: (controller) =>
                                      controller.repeat(reverse: true))
                              .fadeIn(duration: 1500.ms)
                              .fadeOut(duration: 1500.ms),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void NavigatToHomeScreen() {
    Future.delayed(const Duration(seconds: 4), () {
      if (!mounted) return;

      if (SharedPreferencesSinglton.getBool(onBoardingSeenKey) == true) {
        var islogin = FireBaseAuthService().isSignedIn();
        if (islogin) {
          GoRouter.of(context).pushReplacement('/Main_view');
        } else {
          GoRouter.of(context).pushReplacement('/Login_view');
        }
      } else {
        GoRouter.of(context).pushReplacement('/OnBoardingView');
      }
    });
  }
}
