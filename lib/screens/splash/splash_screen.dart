
import 'package:brainmri/screens/mainlayout/bridge.dart';
import 'package:brainmri/screens/mainlayout/main_layout_screen.dart';
import 'package:brainmri/screens/observation/add_observation_screen.dart';
import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:brainmri/main.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    init();
  }

  Future<void> init() async {
    try {
      final PackageInfo info = await PackageInfo.fromPlatform();
      packageVersion = info.version;
    } catch (_) {}
    await Future<void>.delayed(const Duration(seconds: 1));
    if (mounted) {
      Navigator.of(context).pushReplacement(
        PageRouteBuilder<void>(
          pageBuilder: (_, __, ___) => const Bridge(),
          transitionsBuilder: (_, Animation<double> a, __, Widget child) {
            return FadeTransition(opacity: a, child: child);
          },
          transitionDuration: const Duration(seconds: 1),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.black,
      child: Center(
        child: Hero(
          tag: 'LOGO',
          child: Image.asset('assets/comed_logo_white.png', width: 100.0),
        ),
      ),
    );
  }
}
