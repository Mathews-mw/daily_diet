import 'package:daily_diet/models/meal.dart';
import 'package:daily_diet/theme/colors/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class EditMealPage extends StatefulWidget {
  final Meal meal;
  final void Function(Meal meal) onSubmitEditForm;

  const EditMealPage({
    super.key,
    required this.meal,
    required this.onSubmitEditForm,
  });

  @override
  State<EditMealPage> createState() => _EditMealPage();
}

class _EditMealPage extends State<EditMealPage> {
  late TextEditingController mealNameController;
  late TextEditingController mealDescriptionController;
  late DateTime selectedDate;
  late TimeOfDay selectedTime;
  bool _isDiet = false;
  bool _isNotDiet = false;

  @override
  void initState() {
    super.initState();

    mealNameController = TextEditingController(text: widget.meal.name);
    mealDescriptionController =
        TextEditingController(text: widget.meal.description);

    selectedDate = DateTime(
      widget.meal.registerAt.year,
      widget.meal.registerAt.month,
      widget.meal.registerAt.day,
    );

    selectedTime = TimeOfDay(
      hour: widget.meal.registerAt.hour,
      minute: widget.meal.registerAt.minute,
    );

    if (widget.meal.isDiet) {
      _isDiet = true;
      _isNotDiet = false;
    } else {
      _isDiet = false;
      _isNotDiet = true;
    }
  }

  @override
  void dispose() {
    mealNameController.dispose();
    mealDescriptionController.dispose();
    super.dispose();
  }

  _showDatePicker(BuildContext context) {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now().subtract(const Duration(days: 365 * 2)),
      lastDate: DateTime.now(),
    ).then((date) {
      if (date == null) {
        return;
      }

      setState(() {
        selectedDate = date;
      });
    });
  }

  _showTimePicker(BuildContext context) {
    showTimePicker(context: context, initialTime: TimeOfDay.now()).then((time) {
      if (time == null) {
        return;
      }

      setState(() {
        selectedTime = time;
      });
    });
  }

  _setIsDietSelection(bool isDiet) {
    setState(() {
      if (isDiet) {
        _isDiet = true;
        _isNotDiet = false;
      } else {
        _isNotDiet = true;
        _isDiet = false;
      }
    });
  }

  _handleEditMealForm(Meal meal) {
    final mealName = mealNameController.text;
    final mealDescription = mealDescriptionController.text;
    final mealRegisterAt = DateTime(
      selectedDate.year,
      selectedDate.month,
      selectedDate.day,
      selectedTime.hour,
      selectedTime.minute,
    );

    if (mealName.isEmpty ||
        mealDescription.isEmpty ||
        (_isNotDiet == false && _isDiet == false)) {
      return ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Preencha todos os campos do formulário!'),
        showCloseIcon: true,
        width: 400,
        duration: Duration(seconds: 10),
        behavior: SnackBarBehavior.floating,
      ));
    }

    meal.name = mealName;
    meal.description = mealDescription;
    meal.registerAt = mealRegisterAt;
    meal.isDiet = _isDiet;

    widget.onSubmitEditForm(meal);

    Navigator.of(context).popUntil((route) => route.isFirst);
  }

  SnackBar invalidFormSnackBar() {
    return const SnackBar(
      content: Text('Preencha todos os campos do formulário'),
      showCloseIcon: true,
      width: 400,
      duration: Duration(seconds: 10),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.baseGray5,
        title: const Text(
          'Nova refeição',
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Container(
          color: AppColors.baseGray5,
          height: double.infinity,
          width: double.infinity,
          child: ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(16.0),
              topRight: Radius.circular(16.0),
            ),
            child: Container(
              height: double.infinity,
              color: AppColors.baseWhite,
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 20),
                            TextField(
                              decoration: const InputDecoration(
                                labelText: 'Nome',
                              ),
                              controller: mealNameController,
                            ),
                            const SizedBox(height: 20),
                            TextField(
                              minLines: 4,
                              maxLines: 4,
                              decoration: const InputDecoration(
                                labelText: 'Descrição',
                              ),
                              controller: mealDescriptionController,
                            ),
                            const SizedBox(height: 20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    const Text('Data'),
                                    const SizedBox(width: 12),
                                    OutlinedButton(
                                        onPressed: () =>
                                            _showDatePicker(context),
                                        child: Text(DateFormat('dd/MM/y')
                                            .format(selectedDate))),
                                  ],
                                ),
                                Row(
                                  children: [
                                    const Text('Hora'),
                                    const SizedBox(width: 12),
                                    OutlinedButton(
                                      onPressed: () => _showTimePicker(context),
                                      child: Text(selectedTime.format(context)),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(height: 20),
                            const Text(
                              'Está dentro da dieta?',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 4),
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: InkWell(
                                    onTap: () {
                                      _setIsDietSelection(true);
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 12, vertical: 8),
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          width: 1,
                                          color: _isDiet
                                              ? AppColors.baseGreenDark
                                              : AppColors.baseGray6,
                                        ),
                                        color: _isDiet
                                            ? AppColors.baseGreenLight
                                            : AppColors.baseGray6,
                                        borderRadius: BorderRadius.circular(6),
                                      ),
                                      child: const Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          CircleAvatar(
                                            radius: 5,
                                            backgroundColor:
                                                AppColors.baseGreenDark,
                                          ),
                                          SizedBox(width: 8),
                                          Text(
                                            'Sim',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 20),
                                Expanded(
                                  flex: 1,
                                  child: InkWell(
                                    onTap: () {
                                      _setIsDietSelection(false);
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 12, vertical: 8),
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          width: 1,
                                          color: _isNotDiet
                                              ? AppColors.baseRedDark
                                              : AppColors.baseGray6,
                                        ),
                                        color: _isNotDiet
                                            ? AppColors.baseRedLight
                                            : AppColors.baseGray6,
                                        borderRadius: BorderRadius.circular(6),
                                      ),
                                      child: const Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          CircleAvatar(
                                            radius: 5,
                                            backgroundColor:
                                                AppColors.baseRedDark,
                                          ),
                                          SizedBox(width: 8),
                                          Text(
                                            'Não',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: double.infinity,
                      child: FilledButton(
                        onPressed: () => _handleEditMealForm(widget.meal),
                        child: const Text('Salvar alterações'),
                      ),
                    ),
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
