import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'package:daily_diet/pages/home_page.dart';
import 'package:daily_diet/theme/colors/app_colors.dart';

void main() {
  runApp(DailyDietApp());
}

class DailyDietApp extends StatelessWidget {
  DailyDietApp({super.key});

  final ThemeData theme = ThemeData();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate
      ],
      supportedLocales: const [Locale('pt', 'BR')],
      home: MainPage(),
      theme: theme.copyWith(
          colorScheme: theme.colorScheme
              .copyWith(primary: Colors.black, secondary: Colors.white),
          textTheme: theme.textTheme.copyWith(
            bodyMedium: GoogleFonts.nunitoSans(
                fontSize: 16, color: AppColors.baseGray1),
            titleLarge: GoogleFonts.nunitoSans(
                fontSize: 42,
                fontWeight: FontWeight.bold,
                color: AppColors.baseGray1),
            titleMedium: GoogleFonts.nunitoSans(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: AppColors.baseGray1),
            titleSmall: GoogleFonts.nunitoSans(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: AppColors.baseGray1),
            displayLarge: GoogleFonts.nunitoSans(),
          ),
          filledButtonTheme: FilledButtonThemeData(
            style: FilledButton.styleFrom(
              backgroundColor: AppColors.baseGray2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
          outlinedButtonTheme: OutlinedButtonThemeData(
            style: OutlinedButton.styleFrom(
              overlayColor: AppColors.baseGray2,
              foregroundColor: AppColors.baseGray1,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
          inputDecorationTheme: InputDecorationTheme(
            border: const OutlineInputBorder(),
            labelStyle: const TextStyle(color: AppColors.baseGray2),
            hintStyle: const TextStyle(color: AppColors.baseGray4),
            focusedBorder: OutlineInputBorder(
              borderSide:
                  const BorderSide(color: AppColors.baseGray3, width: 1.0),
              borderRadius: BorderRadius.circular(6),
            ),
          )),
    );
  }
}

class MainPage extends StatelessWidget {
  MainPage({super.key});

  final appBar = AppBar(
    backgroundColor: AppColors.baseWhite,
    title: const Text(
      'Daily Diet',
      style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
    ),
    centerTitle: true,
  );

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final statusBardHeight = mediaQuery.padding.top;
    final appBarHeight = appBar.preferredSize.height;

    final availableSize =
        mediaQuery.size.height - appBarHeight - statusBardHeight;

    return Scaffold(
      appBar: appBar,
      body: SafeArea(
          child: SingleChildScrollView(
        child: Container(
          color: AppColors.baseWhite,
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: HomePage(availableScreenSize: availableSize),
          ),
        ),
      )),
    );
  }
}
