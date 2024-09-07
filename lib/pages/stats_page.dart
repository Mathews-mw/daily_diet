import 'package:daily_diet/models/meal.dart';
import 'package:daily_diet/theme/colors/app_colors.dart';
import 'package:flutter/material.dart';

class StatsPage extends StatelessWidget {
  final List<Meal> mealsList;
  final double percentageMealsWithinDiet;

  const StatsPage({
    super.key,
    required this.mealsList,
    required this.percentageMealsWithinDiet,
  });

  @override
  Widget build(BuildContext context) {
    final totalMealsWithinDiet =
        mealsList.where((meal) => meal.isDiet).toList();
    final totalMealsOffDiet =
        mealsList.where((meal) => meal.isDiet == false).toList();

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100.0,
        backgroundColor: percentageMealsWithinDiet >= 50
            ? AppColors.baseGreenLight
            : AppColors.baseRedLight,
        title: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: Column(
            children: [
              Text(
                '${percentageMealsWithinDiet.toStringAsFixed(2)}%',
                style:
                    const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
              const Text(
                'das refeições dentro da dieta',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w300),
              ),
            ],
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Container(
          color: AppColors.baseRedLight,
          height: double.infinity,
          child: ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(16.0),
              topRight: Radius.circular(16.0),
            ),
            child: Container(
              color: AppColors.baseWhite,
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.only(
                  top: 32,
                  right: 24,
                  left: 24,
                  bottom: 12,
                ),
                child: Column(
                  children: [
                    Text(
                      'Estatísticas gerais',
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                    const SizedBox(height: 20),
                    const Card.filled(
                      color: AppColors.baseGray6,
                      child: Padding(
                        padding: EdgeInsets.all(24),
                        child: Column(
                          children: <Widget>[
                            Text(
                              '4',
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              'melhor sequência de pratos dentro da dieta',
                              textAlign: TextAlign.center,
                            )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: Card.filled(
                        color: AppColors.baseGray6,
                        child: Padding(
                          padding: const EdgeInsets.all(24),
                          child: Column(
                            children: <Widget>[
                              Text(
                                mealsList.length.toString(),
                                style: const TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const Text(
                                'refeições registradas',
                                textAlign: TextAlign.center,
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: Card.filled(
                            color: AppColors.baseGreenLight,
                            child: Padding(
                              padding: const EdgeInsets.all(24),
                              child: Column(
                                children: <Widget>[
                                  Text(
                                    totalMealsWithinDiet.length.toString(),
                                    style: const TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const Text(
                                    'refeições dentro da dieta',
                                    textAlign: TextAlign.center,
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Card.filled(
                            color: AppColors.baseRedLight,
                            child: Padding(
                              padding: const EdgeInsets.all(24),
                              child: Column(
                                children: <Widget>[
                                  Text(
                                    totalMealsOffDiet.length.toString(),
                                    style: const TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const Text(
                                    'refeições fora da dieta',
                                    textAlign: TextAlign.center,
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
