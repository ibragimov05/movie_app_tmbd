import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/core.dart';
import '../../../../../router/app_router.dart';

part 'mixin/splash_mixin.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> with SplashMixin {
  @override
  Widget build(BuildContext context) => Scaffold(
        body: Center(
          child: AppAssets.images.popcorn.image(
            width: DeviceScreen.w(context) / 2.2,
          ),
        ),
      );
}
