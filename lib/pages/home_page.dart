import 'package:daily_diet/components/meal_item.dart';
import 'package:daily_diet/models/meal.dart';
import 'package:daily_diet/pages/diet_register_page.dart';
import 'package:daily_diet/theme/colors/app_colors.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Meal> meals = [
    Meal(
        name: 'X-tudo',
        description:
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec elementum diam vitae sem varius porttitor. Proin vitae massa erat. Maecenas a purus a quam laoreet imperdiet eu in augue.',
        registerAt: DateTime.now(),
        isDiet: false),
    Meal(
        name: 'Salada',
        description:
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec elementum diam vitae sem varius porttitor. Proin vitae massa erat. Maecenas a purus a quam laoreet imperdiet eu in augue.',
        registerAt: DateTime.now(),
        isDiet: true),
    Meal(
        name: 'Bolo de chocolate',
        description:
            'Melhor bolo de chocolate da cidade do Sonho de bolo. Contém uma ignorância absurda de cobertura de chocolate.',
        registerAt: DateTime.now(),
        isDiet: false),
    // Meal(
    //     name: 'Arroz com frango',
    //     description: 'xywnlctcoycxvwrt',
    //     registerAt: DateTime.now(),
    //     isDiet: true),
    // Meal(
    //     name: 'Vitamina de Banana',
    //     description: 'xywnlctcoycxvwrt',
    //     registerAt: DateTime.now(),
    //     isDiet: true),
    // Meal(
    //     name: 'X-tudo',
    //     description: 'xywnlctcoycxvwrt',
    //     registerAt: DateTime.now(),
    //     isDiet: false),
    // Meal(
    //     name: 'Salada',
    //     description: 'xywnlctcoycxvwrt',
    //     registerAt: DateTime.now(),
    //     isDiet: true),
    // Meal(
    //     name: 'Bolo de chocolate',
    //     description: 'xywnlctcoycxvwrt',
    //     registerAt: DateTime.now(),
    //     isDiet: false),
    // Meal(
    //     name: 'Arroz com frango',
    //     description: 'xywnlctcoycxvwrt',
    //     registerAt: DateTime.now(),
    //     isDiet: true),
    // Meal(
    //     name: 'Vitamina de Banana',
    //     description: 'xywnlctcoycxvwrt',
    //     registerAt: DateTime.now(),
    //     isDiet: true),
  ];

  _registerNewMeal(Meal meal) {
    setState(() {
      meals.add(meal);
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
                        onPressed: () {},
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

                return MealItem(meal: meal, onDeleteMeal: _deleteMeal);
              }),
        )
      ],
    );
  }
}
