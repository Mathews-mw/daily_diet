import 'package:daily_diet/components/meal_item.dart';
import 'package:daily_diet/models/meal.dart';
import 'package:daily_diet/pages/diet_register_page.dart';
import 'package:daily_diet/theme/colors/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(DailyDietApp());
}

class DailyDietApp extends StatelessWidget {
  DailyDietApp({super.key});

  final ThemeData theme = ThemeData();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
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

class HomePage extends StatelessWidget {
  final bool _isDiet = true;

  final List<Meal> meals = [
    Meal(name: 'X-tudo', registerAt: DateTime.now(), isDiet: false),
    Meal(name: 'Salada', registerAt: DateTime.now(), isDiet: true),
    Meal(name: 'Bolo de chocolate', registerAt: DateTime.now(), isDiet: false),
    Meal(name: 'Arroz com frango', registerAt: DateTime.now(), isDiet: true),
    Meal(name: 'Vitamina de Banana', registerAt: DateTime.now(), isDiet: true),
    Meal(name: 'X-tudo', registerAt: DateTime.now(), isDiet: false),
    Meal(name: 'Salada', registerAt: DateTime.now(), isDiet: true),
    Meal(name: 'Bolo de chocolate', registerAt: DateTime.now(), isDiet: false),
    Meal(name: 'Arroz com frango', registerAt: DateTime.now(), isDiet: true),
    Meal(name: 'Vitamina de Banana', registerAt: DateTime.now(), isDiet: true),
  ];

  HomePage({super.key});

  _navigateToDietRegisterPage(BuildContext context) {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => const DietRegisterPage(),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Daily Diet',
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: <Widget>[
              SizedBox(
                width: double.infinity,
                child: Card.filled(
                  color: _isDiet
                      ? AppColors.baseGreenLight
                      : AppColors.baseRedLight,
                  child: Padding(
                    padding: const EdgeInsets.only(
                        top: 0, bottom: 10, left: 0, right: 0),
                    child: Column(
                      children: <Widget>[
                        SizedBox(
                          width: double.infinity,
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: IconButton(
                              icon: const Icon(Icons.north_east),
                              color: AppColors.baseGreenDark,
                              onPressed: () {},
                            ),
                          ),
                        ),
                        Text(
                          '90,86%',
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        const Text('das refeições dentro da dieta')
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 40),
              SizedBox(
                width: double.infinity,
                child: FilledButton.icon(
                    onPressed: () => _navigateToDietRegisterPage(context),
                    label: const Text('Nova refeição'),
                    icon: const Icon(Icons.add)),
              ),
              const SizedBox(height: 20),
              Container(
                height: 540,
                child: ListView.builder(
                    itemCount: meals.length,
                    itemBuilder: (ctx, index) {
                      final meal = meals[index];

                      return MealItem(meal: meal);
                    }),
              )
            ],
          ),
        ),
      )),
    );
  }
}
