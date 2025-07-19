import 'package:flutter/material.dart';
import 'package:loanlens/models/calculator_model.dart';

class CalculatorCard extends StatelessWidget {
  final CalculatorType calculator;
  final VoidCallback onTap;
  final bool isFullWidth;

  const CalculatorCard({
    super.key,
    required this.calculator,
    required this.onTap,
    this.isFullWidth = false,
  });

  @override
  Widget build(BuildContext context) {
    final iconWidget = Text(
      calculator.icon,
      style: const TextStyle(fontSize: 52),
    );

    final nameWidget = Text(
      calculator.name,
      style: Theme.of(context).textTheme.titleMedium?.copyWith(
        fontWeight: FontWeight.bold,
        color: Theme.of(context).colorScheme.onPrimaryContainer,
      ),
      textAlign: TextAlign.center,
    );

    final descriptionWidget = Text(
      calculator.description,
      style: Theme.of(context).textTheme.bodySmall?.copyWith(
        color: Theme.of(
          context,
        ).colorScheme.onPrimaryContainer.withOpacity(0.8),
      ),
      textAlign: TextAlign.center,
    );

    return Card(
      elevation: 2,
      margin: const EdgeInsets.all(2),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Theme.of(context).colorScheme.primaryContainer,
                Theme.of(context).colorScheme.primaryContainer.withOpacity(0.7),
              ],
            ),
          ),
          child: isFullWidth
              ? Row(
                  children: [
                    iconWidget,
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          nameWidget,
                          const SizedBox(height: 4),
                          descriptionWidget,
                        ],
                      ),
                    ),
                  ],
                )
              : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    iconWidget,
                    const SizedBox(height: 12),
                    nameWidget,
                    const SizedBox(height: 4),
                    descriptionWidget,
                  ],
                ),
        ),
      ),
    );
  }
}
