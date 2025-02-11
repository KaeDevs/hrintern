import 'dart:async';
import 'package:flutter/material.dart';
import 'package:ss/BaseOfApp.dart';
import 'package:flutter_intro/flutter_intro.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Splash Screen',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: SplashScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreen createState() => _SplashScreen();
}

class _SplashScreen extends State<SplashScreen> with TickerProviderStateMixin {
  late AnimationController _introController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _fadeIntroAnimation;

  late AnimationController _slideController;
  late Animation<Offset> _slideAnimation;

  late AnimationController _fadeController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();

    _introController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 2000),
    );

    _scaleAnimation =
        Tween<double>(begin: 0.8, end: 1.1).animate(CurvedAnimation(
      parent: _introController,
      curve: Curves.easeOutBack,
    ));

    _fadeIntroAnimation =
        Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(
      parent: _introController,
      curve: Curves.easeInOutCubic,
    ));

    _slideController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 2500),
    );

    _slideAnimation = Tween<Offset>(
      begin: Offset(0, 0),
      end: Offset(0, -1.3),
    ).animate(CurvedAnimation(
      parent: _slideController,
      curve: Curves.easeInOutCubic,
    ));

    _fadeController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 3500),
    );

    _fadeAnimation = CurvedAnimation(
      parent: _fadeController,
      curve: Curves.easeInOutCubic,
    );

    _introController.forward();

    Timer(Duration(seconds: 2), () {
      _slideController.forward();

      Future.delayed(Duration(milliseconds: 1500), () {
        _fadeController.forward();

        Future.delayed(Duration(seconds: 2), () {
          Navigator.pushReplacement(
            context,
            PageRouteBuilder(
              transitionDuration: Duration(milliseconds: 1500),
              pageBuilder: (_, __, ___) => Intro(
                  padding: EdgeInsets.all(12),
                  borderRadius: const BorderRadius.all(Radius.circular(4)),
                  maskColor: const Color.fromRGBO(0, 0, 0, .8),
                  child: Baseofapp()),
              transitionsBuilder: (_, animation, __, child) {
                return FadeTransition(opacity: animation, child: child);
              },
            ),
          );
        });
      });
    });
  }

  @override
  void dispose() {
    _introController.dispose();
    _slideController.dispose();
    _fadeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FadeTransition(
              opacity: _fadeIntroAnimation,
              child: ScaleTransition(
                scale: _scaleAnimation,
                child: SlideTransition(
                  position: _slideAnimation,
                  child: Image.asset("assets/images/launch_logo.png",
                      height: 80, width: 80),
                ),
              ),
            ),
            SizedBox(height: 30),
            FadeTransition(
              opacity: _fadeAnimation,
              child: Text(
                "HrBlueSky",
                style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontFamily: "H1"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
