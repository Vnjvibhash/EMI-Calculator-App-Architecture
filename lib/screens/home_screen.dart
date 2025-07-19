import 'package:flutter/material.dart';
import 'package:loanlens/models/calculator_model.dart';
import 'package:loanlens/widgets/calculator_card.dart';
import 'package:loanlens/screens/calculator_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final calculators = CalculatorData.calculators;

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Theme.of(context).colorScheme.primary.withOpacity(0.05),
              Theme.of(context).colorScheme.surface,
            ],
          ),
        ),
        child: SafeArea(
          child: CustomScrollView(
            slivers: [
              SliverAppBar(
                expandedHeight: 120,
                floating: true,
                pinned: true,
                backgroundColor: Colors.transparent,
                elevation: 0,
                flexibleSpace: FlexibleSpaceBar(
                  title: Text(
                    "Loan's EMI Lens",
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                  ),
                  centerTitle: true,
                ),
              ),
              SliverPadding(
                padding: const EdgeInsets.all(16),
                sliver: SliverToBoxAdapter(
                  child: Text(
                    'Choose a calculator to get started',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
                        ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),

              // Custom Grid/List Handling
              SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                sliver: SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      final calculator = calculators[index];

                      // Every 3rd item – full width
                      if ((index + 1) % 3 == 0) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 6),
                          child: CalculatorCard(
                            calculator: calculator,
                            isFullWidth: true,
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => CalculatorScreen(
                                    calculatorType: calculator,
                                  ),
                                ),
                              );
                            },
                          ),
                        );
                      }

                      // For even-indexed item: row with next item
                      if (index % 3 == 0 && index + 1 < calculators.length) {
                        return Row(
                          children: [
                            Expanded(
                              child: CalculatorCard(
                                calculator: calculators[index],
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => CalculatorScreen(
                                        calculatorType: calculators[index],
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: CalculatorCard(
                                calculator: calculators[index + 1],
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => CalculatorScreen(
                                        calculatorType: calculators[index + 1],
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        );
                      }

                      // Skip already handled second item in pair
                      if (index % 3 == 1) return const SizedBox.shrink();

                      // Fallback (e.g., last item if odd count)
                      return CalculatorCard(
                        calculator: calculator,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CalculatorScreen(
                                calculatorType: calculator,
                              ),
                            ),
                          );
                        },
                      );
                    },
                    childCount: calculators.length,
                  ),
                ),
              ),

              const SliverPadding(padding: EdgeInsets.only(bottom: 32)),
            ],
          ),
        ),
      ),
    );
  }
}