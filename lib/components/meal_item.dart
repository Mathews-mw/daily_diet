import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:daily_diet/models/meal.dart';
import 'package:daily_diet/theme/colors/app_colors.dart';

class MealItem extends StatelessWidget {
  final Meal meal;

  const MealItem({super.key, required this.meal});

  @override
  Widget build(BuildContext context) {
    return Card.outlined(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(6.0), // Define o raio das bordas
        side: const BorderSide(
          color: AppColors.baseGray5, // Cor da borda
          width: 2.0, // Largura da borda
        ),
      ),
      elevation: 0,
      child: InkWell(
        onTap: () {},
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Text(DateFormat('hh:mm').format(meal.registerAt)),
              const SizedBox(
                height: 18,
                child: VerticalDivider(
                  color: AppColors.baseGray4,
                  thickness: 2,
                  width: 30,
                ),
              ),
              Expanded(flex: 1, child: Text(meal.name)),
              CircleAvatar(
                radius: 8,
                backgroundColor:
                    meal.isDiet ? AppColors.baseGreenMid : AppColors.baseRedMid,
              )
            ],
          ),
        ),
      ),
    );
  }
}
