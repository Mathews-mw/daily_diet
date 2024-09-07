import 'package:daily_diet/pages/edit_meal_page.dart';
import 'package:daily_diet/pages/home_page.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:daily_diet/models/meal.dart';
import 'package:daily_diet/theme/colors/app_colors.dart';

class MealDetailsPage extends StatelessWidget {
  final Meal meal;
  final void Function(Meal meal) onDeleteMeal;
  final void Function(Meal meal) onSubmitEditForm;

  const MealDetailsPage({
    super.key,
    required this.meal,
    required this.onDeleteMeal,
    required this.onSubmitEditForm,
  });

  _showDeleteMealDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        backgroundColor: AppColors.baseWhite,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6.0),
        ),
        title: Text(
          'Deseja realmente excluir o registro da refeição?',
          style: Theme.of(context).textTheme.titleSmall,
          textAlign: TextAlign.center,
        ),
        actions: <Widget>[
          OutlinedButton(
            onPressed: () => Navigator.pop(context, 'Cancel'),
            child: const Text('Cancelar'),
          ),
          FilledButton(
            onPressed: () {
              onDeleteMeal(meal);

              Navigator.of(context).pop();
              Navigator.of(context).popUntil((route) => route.isFirst);
            },
            child: const Text('Sim, excluir'),
          ),
        ],
      ),
    );
  }

  _navigateToEditMealPage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => EditMealPage(
          meal: meal,
          onSubmitEditForm: onSubmitEditForm,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor:
            meal.isDiet ? AppColors.baseGreenLight : AppColors.baseRedLight,
        title: const Text(
          'Refeição',
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Container(
          color:
              meal.isDiet ? AppColors.baseGreenLight : AppColors.baseRedLight,
          height: double.infinity,
          child: ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(16.0),
              topRight: Radius.circular(16.0),
            ),
            child: Container(
              color: AppColors.baseWhite,
              child: Padding(
                padding: const EdgeInsets.only(
                  top: 32,
                  right: 24,
                  left: 24,
                  bottom: 12,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                meal.name,
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                              Text(meal.description),
                            ],
                          ),
                          const SizedBox(height: 20),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Data e hora',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Text(DateFormat("dd/MM/yyyy  'às' hh:mm")
                                  .format(meal.registerAt)),
                            ],
                          ),
                          const SizedBox(height: 20),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 18,
                              vertical: 8,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.baseGray6,
                              borderRadius: BorderRadius.circular(99),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                CircleAvatar(
                                  radius: 5,
                                  backgroundColor: meal.isDiet
                                      ? AppColors.baseGreenDark
                                      : AppColors.baseRedDark,
                                ),
                                const SizedBox(width: 8),
                                meal.isDiet
                                    ? const Text('Dentro da dieta')
                                    : const Text('Fora da dieta')
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Column(
                      children: [
                        SizedBox(
                          width: double.infinity,
                          child: FilledButton.icon(
                              onPressed: () => _navigateToEditMealPage(context),
                              label: const Text('Editar refeição'),
                              icon: const Icon(Icons.edit)),
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: OutlinedButton.icon(
                            onPressed: () => _showDeleteMealDialog(context),
                            label: const Text('Excluir refeição'),
                            icon: const Icon(Icons.delete_forever),
                          ),
                        )
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
