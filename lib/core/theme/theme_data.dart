part of 'themes.dart';

final ThemeData lightTheme = ThemeData();

final ThemeData darkTheme = ThemeData.dark().copyWith(
  textTheme: GoogleFonts.poppinsTextTheme(ThemeData.dark().textTheme),
);
