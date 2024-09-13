part of '../splash_page.dart';

mixin SplashMixin on State<SplashPage> {
  @override
  void initState() {
    super.initState();

    Future.delayed(
      const Duration(seconds: 2),
      () => _toTheNextScreen(),
    );
  }

  void _toTheNextScreen() => context.replace(Routes.main);
}
