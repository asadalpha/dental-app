import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:dental_app/core/theme/app_colors.dart';

class OnboardingContent {
  final String title;
  final String description;
  final IconData icon;
  final Color color;

  OnboardingContent({
    required this.title,
    required this.description,
    required this.icon,
    required this.color,
  });
}

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentIndex = 0;

  final List<OnboardingContent> _contents = [
    OnboardingContent(
      title: "Welcome to IntelliDent",
      description:
          "Experience the next generation of AI-driven dental diagnostics and care.",
      icon: Icons.health_and_safety_rounded,
      color: AppColors.primary,
    ),
    OnboardingContent(
      title: "Smart Scan Analysis",
      description:
          "Upload your dental scans and get high-precision AI insights in seconds.",
      icon: Icons.analytics_rounded,
      color: AppColors.secondary,
    ),
    OnboardingContent(
      title: "Secure Health Track",
      description:
          "Your dental history, safely stored and easily accessible whenever you need it.",
      icon: Icons.security_rounded,
      color: AppColors.primaryDark,
    ),
  ];

  void _goToLogin() {
    Navigator.pushReplacementNamed(context, '/login');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background Gradient decoration
          Positioned(
            top: -100,
            right: -100,
            child: Container(
              width: 300,
              height: 300,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.primary.withOpacity(0.05),
              ),
            ),
          ),
          Positioned(
            bottom: -50,
            left: -50,
            child: Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.secondary.withOpacity(0.05),
              ),
            ),
          ),

          SafeArea(
            child: Column(
              children: [
                Align(
                  alignment: Alignment.topRight,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: TextButton(
                      onPressed: _goToLogin,
                      child: Text(
                        "Skip",
                        style: TextStyle(
                          color: AppColors.textSecondary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ),

                Expanded(
                  child: PageView.builder(
                    controller: _pageController,
                    itemCount: _contents.length,
                    onPageChanged: (index) {
                      setState(() => _currentIndex = index);
                    },
                    itemBuilder: (context, index) {
                      final item = _contents[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 40.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                                  padding: const EdgeInsets.all(32),
                                  decoration: BoxDecoration(
                                    color: item.color.withOpacity(0.1),
                                    shape: BoxShape.circle,
                                  ),
                                  child: Icon(
                                    item.icon,
                                    size: 120,
                                    color: item.color,
                                  ),
                                )
                                .animate()
                                .scale(
                                  duration: 600.ms,
                                  curve: Curves.easeOutBack,
                                )
                                .fadeIn(duration: 600.ms),

                            const SizedBox(height: 48),

                            Text(
                                  item.title,
                                  style: Theme.of(
                                    context,
                                  ).textTheme.headlineLarge,
                                  textAlign: TextAlign.center,
                                )
                                .animate(key: ValueKey('title_$index'))
                                .fadeIn(delay: 200.ms, duration: 500.ms)
                                .slideY(begin: 0.2, end: 0),

                            const SizedBox(height: 16),

                            Text(
                                  item.description,
                                  style: Theme.of(context).textTheme.bodyLarge
                                      ?.copyWith(
                                        color: AppColors.textSecondary,
                                        height: 1.5,
                                      ),
                                  textAlign: TextAlign.center,
                                )
                                .animate(key: ValueKey('desc_$index'))
                                .fadeIn(delay: 400.ms, duration: 500.ms)
                                .slideY(begin: 0.2, end: 0),
                          ],
                        ),
                      );
                    },
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.fromLTRB(24, 0, 24, 48),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: List.generate(
                          _contents.length,
                          (index) => AnimatedContainer(
                            duration: const Duration(milliseconds: 300),
                            margin: const EdgeInsets.only(right: 8),
                            height: 8,
                            width: _currentIndex == index ? 32 : 8,
                            decoration: BoxDecoration(
                              color: _currentIndex == index
                                  ? AppColors.primary
                                  : AppColors.primary.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),
                        ),
                      ),

                      SizedBox(
                        height: 56,
                        child: ElevatedButton(
                          onPressed: () {
                            if (_currentIndex == _contents.length - 1) {
                              _goToLogin();
                            } else {
                              _pageController.nextPage(
                                duration: const Duration(milliseconds: 600),
                                curve: Curves.easeInOutQuart,
                              );
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(horizontal: 32),
                            minimumSize: const Size(0, 56),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                _currentIndex == _contents.length - 1
                                    ? "Get Started"
                                    : "Next",
                              ),
                              if (_currentIndex != _contents.length - 1) ...[
                                const SizedBox(width: 8),
                                const Icon(
                                  Icons.arrow_forward_rounded,
                                  size: 20,
                                ),
                              ],
                            ],
                          ),
                        ),
                      ).animate().fadeIn(delay: 600.ms).scale(delay: 600.ms),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
