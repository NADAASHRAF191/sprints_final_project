import 'package:e_commerce_flutter/features/Auth/views/Splash/getStarted.dart';
import 'package:flutter/material.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    super.initState();
    getOnboarding();
  }

  void getOnboarding() {
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => const GetStartView(),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset(
          'assets/images/logo.png',
          width: MediaQuery.of(context).size.width * 0.9, // 90% عرض الشاشة
          height: MediaQuery.of(context).size.height * 0.3, // 30% ارتفاع الشاشة
          fit: BoxFit.contain, // عشان الصورة تتناسب وما تتحرفش
        ),
      ),
    );
  }
}
