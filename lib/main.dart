import 'package:flutter/material.dart';
import 'dart:ui' show PointerDeviceKind;
import 'package:e_commerce_flutter/core/utils/app_theme.dart';
import 'package:e_commerce_flutter/features/auth/views/Splash/splash_view.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      scrollBehavior: const MaterialScrollBehavior().copyWith(
        dragDevices: {
          PointerDeviceKind.mouse,
          PointerDeviceKind.touch,
        },
      ),
      debugShowCheckedModeBanner: false,
      home: const SplashView(),
      theme: AppTheme.lightAppTheme,
    );
  }
}
