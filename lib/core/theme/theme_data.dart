part of 'themes.dart';

final ThemeData lightTheme = ThemeData();

final ThemeData darkTheme = ThemeData.dark().copyWith(
  scaffoldBackgroundColor: AppColors.mainColor,
  appBarTheme: const AppBarTheme(
    backgroundColor: AppColors.mainColor,
    surfaceTintColor: Colors.transparent,
  ),
  textSelectionTheme: TextSelectionThemeData(
    selectionHandleColor: AppColors.mainColor,
    selectionColor: AppColors.mainColor.withOpacity(0.3),
    cursorColor: AppColors.mainColor,
  ),
  textTheme: GoogleFonts.poppinsTextTheme(ThemeData.dark().textTheme),
);
