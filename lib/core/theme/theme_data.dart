part of 'themes.dart';

final ThemeData lightTheme = ThemeData();

final ThemeData darkTheme = ThemeData.dark().copyWith(
  scaffoldBackgroundColor: AppColors.mainColor,
  appBarTheme: const AppBarTheme(
    backgroundColor: AppColors.mainColor,
    surfaceTintColor: Colors.transparent,
  ),
  textTheme: GoogleFonts.poppinsTextTheme(ThemeData.dark().textTheme),
);
