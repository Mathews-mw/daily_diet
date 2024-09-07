import 'package:daily_diet/components/meal_item.dart';
import 'package:daily_diet/models/meal.dart';
import 'package:daily_diet/pages/diet_register_page.dart';
import 'package:daily_diet/pages/stats_page.dart';
import 'package:daily_diet/theme/colors/app_colors.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  final double availableScreenSize;
  const HomePage({super.key, required this.availableScreenSize});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Meal> meals = [];

  _registerNewMeal(Meal meal) {
    setState(() {
      meals.add(meal);
    });
  }

  _editMeal(Meal meal) {
    var currentMealIndex = meals.indexWhere((item) => item.id == meal.id);

    setState(() {
      meals[currentMealIndex] = meal;
    });
  }

  _deleteMeal(Meal meal) {
    setState(() {
      meals.removeWhere((item) => item.id == meal.id);
    });
  }

  _navigateToDietRegisterPage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => DietRegisterPage(onSubmitForm: _registerNewMeal),
      ),
    );
  }

  _navigateToStatsPage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => StatsPage(
          mealsList: meals,
          percentageMealsWithinDiet: _calculateAmountWithinDiet(meals),
        ),
      ),
    );
  }

  double _calculateAmountWithinDiet(List<Meal> meals) {
    final amountMeals = meals.length;

    final amountWithinDiet =
        meals.where((meal) => meal.isDiet == true).toList().length;

    final percentageMealsWithinDiet = ((amountWithinDiet / amountMeals) * 100);

    return percentageMealsWithinDiet;
  }

  @override
  Widget build(BuildContext context) {
    var isWithinDiet = _calculateAmountWithinDiet(meals) >= 50.0;
    var percentageDietMeals = _calculateAmountWithinDiet(meals);

    debugPrint('Tamanho da tela ${widget.availableScreenSize}');

    return Column(
      children: <Widget>[
        SizedBox(
          width: double.infinity,
          child: Card.filled(
            color: isWithinDiet
                ? AppColors.baseGreenLight
                : AppColors.baseRedLight,
            child: Padding(
              padding:
                  const EdgeInsets.only(top: 0, bottom: 10, left: 0, right: 0),
              child: Column(
                children: <Widget>[
                  SizedBox(
                    width: double.infinity,
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: IconButton(
                        icon: const Icon(Icons.north_east),
                        color: isWithinDiet
                            ? AppColors.baseGreenDark
                            : AppColors.baseRedDark,
                        onPressed: () => _navigateToStatsPage(context),
                      ),
                    ),
                  ),
                  percentageDietMeals.isNaN
                      ? Text(
                          '0%',
                          style: Theme.of(context).textTheme.titleLarge,
                        )
                      : Text(
                          '${percentageDietMeals.toStringAsFixed(2)}%',
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                  const Text('das refeições dentro da dieta')
                ],
              ),
            ),
          ),
        ),
        const SizedBox(height: 20),
        SizedBox(
          width: double.infinity,
          child: FilledButton.icon(
              onPressed: () => _navigateToDietRegisterPage(context),
              label: const Text('Nova refeição'),
              icon: const Icon(Icons.add)),
        ),
        const SizedBox(height: 20),
        SizedBox(
          height: widget.availableScreenSize * 0.6,
          child: ListView.builder(
            itemCount: meals.length,
            itemBuilder: (ctx, index) {
              final meal = meals[index];

              return MealItem(
                meal: meal,
                onDeleteMeal: _deleteMeal,
                onSubmitEditForm: _editMeal,
              );
            },
          ),
        ),
      ],
    );
  }
}
