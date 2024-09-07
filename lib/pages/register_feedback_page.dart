import 'package:daily_diet/theme/colors/app_colors.dart';
import 'package:flutter/material.dart';

class RegisterFeedbackPage extends StatelessWidget {
  final bool isDiet;

  const RegisterFeedbackPage({super.key, required this.isDiet});

  Widget _selectFeedBackWidget(BuildContext context) {
    if (isDiet) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
            'Continue assim!',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: AppColors.baseGreenDark,
            ),
          ),
          const Text(
            'Você continua dentro da dieta. Muito bem!',
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          Image.asset('assets/images/within_diet.png', fit: BoxFit.cover),
          const SizedBox(height: 20),
          FilledButton(
            onPressed: () => _navigateToInitialPage(context),
            child: const Text('Ir para tela inicial'),
          )
        ],
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Text(
          'Que pena!',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: AppColors.baseRedDark,
          ),
        ),
        const Text(
          'Você saiu da dieta dessa vez, mas continue se esforçando e não desista!',
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 20),
        Image.asset('assets/images/off_diet.png', fit: BoxFit.cover),
        const SizedBox(height: 20),
        FilledButton(
          onPressed: () => _navigateToInitialPage(context),
          child: const Text('Ir para tela inicial'),
        )
      ],
    );
  }

  _navigateToInitialPage(BuildContext context) {
    Navigator.of(context).popUntil((route) => route.isFirst);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.baseWhite,
      ),
      body: SafeArea(
          child: Container(
        width: double.infinity,
        height: double.infinity,
        color: AppColors.baseWhite,
        child: Padding(
          padding: const EdgeInsets.only(
            top: 32,
            right: 24,
            left: 24,
            bottom: 12,
          ),
          child: _selectFeedBackWidget(context),
        ),
      )),
    );
  }
}
