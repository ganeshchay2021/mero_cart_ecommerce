import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> leftTextAnimation;
  late Animation<Offset> rightTextAnimation;
  late Animation<double> scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: Duration(seconds: 3));

    leftTextAnimation = Tween<Offset>(begin: Offset(-1.5, 0), end: Offset.zero)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic));

    rightTextAnimation = Tween<Offset>(begin: Offset(1.5, 0), end: Offset.zero)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic));
    
    scaleAnimation = Tween<double>(begin: 0.0, end: 1.0)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.linear));
    
    // Start the animation
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.bottomLeft,
            end: Alignment.topLeft,
            colors: [
              Colors.amber.shade300,
              Colors.amber.shade200,
              Colors.amber.shade100,
            ],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ScaleTransition(
                scale: scaleAnimation,
                child: Image.asset("assets/logo.png", height: 150, fit: BoxFit.cover)),
              SlideTransition(
                position: leftTextAnimation,
                child: Text(
                  textAlign: TextAlign.center,
                  "Mero Cart",
                  style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                    color: Colors.red.shade300,
                
                    fontSize: 30,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Gap(10),
              SlideTransition(
                position: rightTextAnimation,
                child: Text(
                  textAlign: TextAlign.center,
                  "Smart Gorgeous & fashionable\ncollection makes you cool",
                  style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                    color: const Color.fromARGB(255, 27, 92, 29),
                    fontSize: 18,
                    height: 1.1,
                    letterSpacing: 2,
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Gap(20),
            ],
          ),
        ),
      ),
    );
  }
}
