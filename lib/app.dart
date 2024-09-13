import 'package:flutter/material.dart';
import 'package:movie_app_tmbd/core/theme/themes.dart';
import 'package:movie_app_tmbd/router/app_router.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,

      /// router
      routerConfig: router,

      /// theme style
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: ThemeMode.dark,
    );
  }
}
