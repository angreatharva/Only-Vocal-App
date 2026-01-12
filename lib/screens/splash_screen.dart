import 'package:flutter/material.dart';
import 'package:only_vocal/components/colors.dart';
import '../main.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  late final AnimationController _enterController;
  late final Animation<double> _fadeIn;
  late final Animation<double> _scaleIn;
  late final Animation<Offset> _slideUp;

  final List<_OnboardPage> _pages = const [
    _OnboardPage(
      // title: 'Qalberooh – Pure Voices. Pure Soul',
      // subtitle: '',
      title: '',
      subtitle: '',
      imageAsset: 'assets/images/Qalberooh.png'
    ),
    _OnboardPage(
      // title: 'Halal Listening, Heartfelt Experience.',
      title: '',
      subtitle: '',
      imageAsset: 'assets/images/Halal.png'
    ),
    _OnboardPage(
      // title: 'Inspiring Souls with Voices, Not Instruments.',
      title: '',
      subtitle: '',
      imageAsset: 'assets/images/Inspiring.png'
    ),
    _OnboardPage(
      // title: 'Your space for peaceful sound.',
      title: '',
      subtitle: '',
      imageAsset: 'assets/images/Space.png'
    ),
    // _OnboardPage(
    //   title: '',
    //   subtitle: '',
    //   imageAsset: 'assets/images/Qalberooh.jpg',
    // ),
  ];

  @override
  void initState() {
    super.initState();
    _enterController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 420),
    );
    final CurvedAnimation curve = CurvedAnimation(
      parent: _enterController,
      curve: Curves.easeOutCubic,
    );
    _fadeIn = Tween<double>(begin: 0.0, end: 1.0).animate(curve);
    _scaleIn = Tween<double>(begin: 0.98, end: 1.0).animate(curve);
    _slideUp = Tween<Offset>(begin: const Offset(0, 0.03), end: Offset.zero).animate(curve);
    _enterController.forward();
  }

  @override
  void dispose() {
    _pageController.dispose();
    _enterController.dispose();
    super.dispose();
  }

  void _goToHome() {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (_) => const MainScreen()),
    );
  }

  void _onNext() {
    if (_currentPage < _pages.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 450),
        curve: Curves.easeOutCubic,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
        // backgroundColor: const Color(0xFF05152E), 
      body: SafeArea(
        child: Stack(
          children: [
            PageView.builder(
              controller: _pageController,
              physics: const BouncingScrollPhysics(),
              onPageChanged: (index) {
                setState(() => _currentPage = index);
                _enterController.forward(from: 0.0);
              },
              itemCount: _pages.length,
              itemBuilder: (context, index) {
                final p = _pages[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 7.0, vertical: 2.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      AnimatedSwitcher(
                        duration: const Duration(milliseconds: 350),
                        switchInCurve: Curves.easeOut,
                        switchOutCurve: Curves.easeIn,
                        child: p.imageAsset == null
                            ? FadeTransition(
                                key: ValueKey(p.title),
                                opacity: _fadeIn,
                                child: SlideTransition(
                                  position: _slideUp,
                                  child: ScaleTransition(
                                    scale: _scaleIn,
                                    child: Text(
                                      p.title,
                                      textAlign: TextAlign.center,
                                      style: theme.textTheme.displayMedium?.copyWith(
                                        fontWeight: FontWeight.bold,
                                        // color: Colors.white,
                                        // color: const Color(0xFF8367F4),
                                        // color: const Color(0xFFFCFCFC),
                                        color: AppColors.primary,
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            : Column(
                                key: ValueKey(p.imageAsset),
                                children: [
                                  LayoutBuilder(
                                    builder: (context, constraints) {
                                      final double height = MediaQuery.of(context).size.height * 0.8;
                                      return FadeTransition(
                                        opacity: _fadeIn,
                                        child: SlideTransition(
                                          position: _slideUp,
                                          child: ScaleTransition(
                                            scale: _scaleIn,
                                            child: ClipRRect(
                                              borderRadius: BorderRadius.circular(16),
                                              child: AnimatedContainer(
                                                duration: const Duration(milliseconds: 400),
                                                curve: Curves.easeOutCubic,
                                                height: height,
                                                width: double.infinity,
                                                child: Image.asset(
                                                  p.imageAsset!,
                                                  fit: BoxFit.cover,
                                                  errorBuilder: (context, error, stack) {
                                                    return Container(
                                                      color: Colors.white10,
                                                      alignment: Alignment.center,
                                                      child: Column(
                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                        children: const [
                                                          Icon(Icons.broken_image, color: AppColors.primary, size: 48),
                                                          SizedBox(height: 8),
                                                          Text('Image not found', style: TextStyle(color: AppColors.primary)),
                                                        ],
                                                      ),
                                                    );
                                                  },
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                  const SizedBox(height: 24),
                                ],
                              ),
                      ),
                      if (p.subtitle.isNotEmpty) ...[
                        const SizedBox(height: 16),
                        AnimatedOpacity(
                          opacity: 1,
                          duration: const Duration(milliseconds: 350),
                          child: Text(
                            p.subtitle,
                            textAlign: TextAlign.center,
                            style: theme.textTheme.titleLarge?.copyWith(
                              color: AppColors.primary,
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                );
              },
            ),

            Positioned(
              left: 16,
              right: 16,
              bottom: 24,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AnimatedSwitcher(
                    duration: const Duration(milliseconds: 250),
                    switchInCurve: Curves.easeOutCubic,
                    switchOutCurve: Curves.easeInCubic,
                    child: (_currentPage < _pages.length - 1)
                        ? TextButton(
                            key: const ValueKey('skip'),
                            onPressed: _goToHome,
                            child: Text(
                              'Skip',
                              style: theme.textTheme.titleLarge?.copyWith(color: Colors.white70),
                            ),
                          )
                        : const SizedBox(width: 64, key: ValueKey('spacer')),
                  ),

                  Row(
                    children: List.generate(
                      _pages.length,
                      (i) => AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        margin: const EdgeInsets.symmetric(horizontal: 4),
                        width: _currentPage == i ? 18 : 8,
                        height: 8,
                        decoration: BoxDecoration(
                          // color: _currentPage == i ? const Color(0xFFFFD700) : Colors.white24,
                          color: _currentPage == i ? AppColors.primary : Colors.white24,
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                  ),

                  AnimatedSwitcher(
                    duration: const Duration(milliseconds: 250),
                    switchInCurve: Curves.easeOutBack,
                    switchOutCurve: Curves.easeIn,
                    transitionBuilder: (child, anim) => ScaleTransition(scale: anim, child: child),
                    child: (_currentPage < _pages.length - 1)
                        ? ElevatedButton(
                            key: const ValueKey('next'),
                            onPressed: _onNext,
                            style: ElevatedButton.styleFrom(
                              // backgroundColor: const Color(0xFFFFD700),
                              backgroundColor: AppColors.primary,
                              foregroundColor: AppColors.background,
                              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                            ),
                            child: const Text('Next'),
                          )
                        : ElevatedButton(
                            key: const ValueKey('okay'),
                            onPressed: _goToHome,
                            style: ElevatedButton.styleFrom(
                              // backgroundColor: const Color(0xFFFFD700),
                              // backgroundColor: const Color(0xFF2B90CA),
                              backgroundColor: AppColors.primary,
                              foregroundColor: AppColors.background,
                              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                            ),
                            child: const Text('Okay'),
                          ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _OnboardPage {
  final String title;
  final String subtitle;
  final String? imageAsset;

  const _OnboardPage({
    required this.title,
    required this.subtitle,
    this.imageAsset,
  });
}

