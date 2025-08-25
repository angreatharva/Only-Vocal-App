import 'dart:async';
import 'package:flutter/material.dart';
import '../main.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _titleOpacity;
  late final Animation<double> _titleScale;
  late final List<Animation<double>> _quoteOpacities;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 2000))
      ..forward();

    _titleOpacity = CurvedAnimation(parent: _controller, curve: const Interval(0.0, 0.4, curve: Curves.easeOut));
    _titleScale = Tween<double>(begin: 0.96, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: const Interval(0.0, 0.4, curve: Curves.easeOutBack)),
    );

    _quoteOpacities = [
      CurvedAnimation(parent: _controller, curve: const Interval(0.25, 0.55, curve: Curves.easeOut)),
      CurvedAnimation(parent: _controller, curve: const Interval(0.40, 0.70, curve: Curves.easeOut)),
      CurvedAnimation(parent: _controller, curve: const Interval(0.55, 0.85, curve: Curves.easeOut)),
      CurvedAnimation(parent: _controller, curve: const Interval(0.70, 1.00, curve: Curves.easeOut)),
    ];

    Timer(const Duration(seconds: 3), () {
      if (!mounted) return;
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => const MainScreen()),
      );
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              FadeTransition(
                opacity: _titleOpacity,
                child: ScaleTransition(
                  scale: _titleScale,
                  child: Text(
                    'Tarteel – Pure Voices. Pure Soul.',
                    textAlign: TextAlign.center,
                    style: theme.textTheme.displayMedium?.copyWith(
                      color: const Color(0xFFFFD700),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              FadeTransition(
                opacity: _quoteOpacities[0],
                child: Text(
                  'Halal Listening, Heartfelt Experience.',
                  textAlign: TextAlign.center,
                  style: theme.textTheme.titleLarge?.copyWith(
                    color: Colors.white.withOpacity(0.85),
                  ),
                ),
              ),
              FadeTransition(
                opacity: _quoteOpacities[1],
                child: Text(
                  'Inspiring Souls with Voices, Not Instruments.',
                  textAlign: TextAlign.center,
                  style: theme.textTheme.titleLarge?.copyWith(
                    color: Colors.white.withOpacity(0.85),
                  ),
                ),
              ),
              FadeTransition(
                opacity: _quoteOpacities[2],
                child: Text(
                  'Your space for peaceful sound.',
                  textAlign: TextAlign.center,
                  style: theme.textTheme.titleLarge?.copyWith(
                    color: Colors.white.withOpacity(0.85),
                  ),
                ),
              ),
              FadeTransition(
                opacity: _quoteOpacities[3],
                child: Text(
                  'Voices that inspire. Sounds that heal.',
                  textAlign: TextAlign.center,
                  style: theme.textTheme.titleLarge?.copyWith(
                    color: Colors.white.withOpacity(0.85),
                  ),
                ),
              ),
              const SizedBox(height: 28),
              FadeTransition(
                opacity: _quoteOpacities[3],
                child: const SizedBox(
                  width: 36,
                  height: 36,
                  child: CircularProgressIndicator(strokeWidth: 3),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


