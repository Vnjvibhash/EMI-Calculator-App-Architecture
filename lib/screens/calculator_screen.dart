import 'package:flutter/material.dart';
import 'package:loanlens/models/calculator_model.dart';
import 'package:loanlens/widgets/input_field.dart';
import 'package:loanlens/widgets/result_display.dart';

class CalculatorScreen extends StatefulWidget {
  final CalculatorType calculatorType;

  const CalculatorScreen({
    super.key,
    required this.calculatorType,
  });

  @override
  State<CalculatorScreen> createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  final Map<String, TextEditingController> _controllers = {};
  String _result = '';
  String _additionalInfo = '';
  DateTime? _selectedDate;
  DateTime? _currentDate;

  @override
  void initState() {
    super.initState();
    _initializeControllers();
  }

  void _initializeControllers() {
    switch (widget.calculatorType.route) {
      case '/calculator/emi':
        _controllers['principal'] = TextEditingController();
        _controllers['rate'] = TextEditingController();
        _controllers['tenure'] = TextEditingController();
        break;
      case '/calculator/rd':
        _controllers['monthlyAmount'] = TextEditingController();
        _controllers['rate'] = TextEditingController();
        _controllers['months'] = TextEditingController();
        break;
      case '/calculator/fd':
        _controllers['principal'] = TextEditingController();
        _controllers['rate'] = TextEditingController();
        _controllers['years'] = TextEditingController();
        break;
      case '/calculator/sip-monthly':
        _controllers['monthlyAmount'] = TextEditingController();
        _controllers['rate'] = TextEditingController();
        _controllers['years'] = TextEditingController();
        break;
      case '/calculator/sip-total':
        _controllers['totalAmount'] = TextEditingController();
        _controllers['rate'] = TextEditingController();
        _controllers['years'] = TextEditingController();
        break;
      case '/calculator/unit':
        _controllers['totalCost'] = TextEditingController();
        _controllers['quantity'] = TextEditingController();
        break;
      case '/calculator/roi':
        _controllers['gain'] = TextEditingController();
        _controllers['cost'] = TextEditingController();
        break;
      case '/calculator/ppf':
        _controllers['yearlyAmount'] = TextEditingController();
        _controllers['rate'] = TextEditingController();
        _controllers['years'] = TextEditingController();
        break;
      case '/calculator/tip':
        _controllers['billAmount'] = TextEditingController();
        _controllers['tipPercentage'] = TextEditingController();
        break;
      case '/calculator/apy':
        _controllers['rate'] = TextEditingController();
        _controllers['frequency'] = TextEditingController();
        break;
      case '/calculator/sales':
        _controllers['costPrice'] = TextEditingController();
        _controllers['profitMargin'] = TextEditingController();
        break;
      case '/calculator/age':
        _currentDate = DateTime.now();
        break;
      case '/calculator/bmi':
        _controllers['weight'] = TextEditingController();
        _controllers['height'] = TextEditingController();
        break;
    }

    // Remove automatic calculation on text change
    // for (var controller in _controllers.values) {
    //   controller.addListener(_calculate);
    // }
  }

  void _calculate() {
    try {
      switch (widget.calculatorType.route) {
        case '/calculator/emi':
          _calculateEMI();
          break;
        case '/calculator/rd':
          _calculateRD();
          break;
        case '/calculator/fd':
          _calculateFD();
          break;
        case '/calculator/sip-monthly':
          _calculateSIPMonthly();
          break;
        case '/calculator/sip-total':
          _calculateSIPTotal();
          break;
        case '/calculator/unit':
          _calculateUnit();
          break;
        case '/calculator/roi':
          _calculateROI();
          break;
        case '/calculator/ppf':
          _calculatePPF();
          break;
        case '/calculator/tip':
          _calculateTip();
          break;
        case '/calculator/apy':
          _calculateAPY();
          break;
        case '/calculator/sales':
          _calculateSales();
          break;
        case '/calculator/age':
          _calculateAge();
          break;
        case '/calculator/bmi':
          _calculateBMI();
          break;
      }
    } catch (e) {
      setState(() {
        _result = '';
        _additionalInfo = '';
      });
    }
  }

  void _reset() {
    setState(() {
      // Clear all text controllers
      for (var controller in _controllers.values) {
        controller.clear();
      }
      
      // Clear results
      _result = '';
      _additionalInfo = '';
      
      // Reset date fields for age calculator
      if (widget.calculatorType.route == '/calculator/age') {
        _selectedDate = null;
        _currentDate = DateTime.now();
      }
    });
  }

  void _calculateEMI() {
    final principal = double.tryParse(_controllers['principal']?.text ?? '') ?? 0;
    final rate = double.tryParse(_controllers['rate']?.text ?? '') ?? 0;
    final tenure = int.tryParse(_controllers['tenure']?.text ?? '') ?? 0;

    if (principal > 0 && rate > 0 && tenure > 0) {
      final emi = CalculatorModel.calculateEMI(principal, rate, tenure);
      final totalAmount = emi * tenure;
      final totalInterest = totalAmount - principal;

      setState(() {
        _result = '₹${emi.toStringAsFixed(2)}';
        _additionalInfo = 'Principal: ₹${principal.toStringAsFixed(2)}\nTotal Amount: ₹${totalAmount.toStringAsFixed(2)}\nTotal Interest: ₹${totalInterest.toStringAsFixed(2)}';
      });
    }
  }

  void _calculateRD() {
    final monthlyAmount = double.tryParse(_controllers['monthlyAmount']?.text ?? '') ?? 0;
    final rate = double.tryParse(_controllers['rate']?.text ?? '') ?? 0;
    final months = int.tryParse(_controllers['months']?.text ?? '') ?? 0;

    if (monthlyAmount > 0 && rate > 0 && months > 0) {
      final maturityAmount = CalculatorModel.calculateRD(monthlyAmount, rate, months);
      final totalInvestment = monthlyAmount * months;
      final totalInterest = maturityAmount - totalInvestment;

      setState(() {
        _result = '₹${maturityAmount.toStringAsFixed(2)}';
        _additionalInfo = 'Total Investment: ₹${totalInvestment.toStringAsFixed(2)}\nTotal Interest: ₹${totalInterest.toStringAsFixed(2)}';
      });
    }
  }

  void _calculateFD() {
    final principal = double.tryParse(_controllers['principal']?.text ?? '') ?? 0;
    final rate = double.tryParse(_controllers['rate']?.text ?? '') ?? 0;
    final years = int.tryParse(_controllers['years']?.text ?? '') ?? 0;

    if (principal > 0 && rate > 0 && years > 0) {
      final maturityAmount = CalculatorModel.calculateFD(principal, rate, years);
      final totalInterest = maturityAmount - principal;

      setState(() {
        _result = '₹${maturityAmount.toStringAsFixed(2)}';
        _additionalInfo = 'Principal: ₹${principal.toStringAsFixed(2)}\nTotal Interest: ₹${totalInterest.toStringAsFixed(2)}';
      });
    }
  }

  void _calculateSIPMonthly() {
    final monthlyAmount = double.tryParse(_controllers['monthlyAmount']?.text ?? '') ?? 0;
    final rate = double.tryParse(_controllers['rate']?.text ?? '') ?? 0;
    final years = int.tryParse(_controllers['years']?.text ?? '') ?? 0;

    if (monthlyAmount > 0 && rate > 0 && years > 0) {
      final maturityAmount = CalculatorModel.calculateSIP(monthlyAmount, rate, years);
      final totalInvestment = monthlyAmount * years * 12;
      final totalGains = maturityAmount - totalInvestment;

      setState(() {
        _result = '₹${maturityAmount.toStringAsFixed(2)}';
        _additionalInfo = 'Monthly Investment: ₹${monthlyAmount.toStringAsFixed(2)}\nTotal Investment: ₹${totalInvestment.toStringAsFixed(2)}\nTotal Gains: ₹${totalGains.toStringAsFixed(2)}';
      });
    }
  }

  void _calculateSIPTotal() {
    final totalAmount = double.tryParse(_controllers['totalAmount']?.text ?? '') ?? 0;
    final rate = double.tryParse(_controllers['rate']?.text ?? '') ?? 0;
    final years = int.tryParse(_controllers['years']?.text ?? '') ?? 0;

    if (totalAmount > 0 && rate > 0 && years > 0) {
      final monthlyAmount = CalculatorModel.calculateSIPMonthlyFromTotal(totalAmount, rate, years);
      final actualMaturityAmount = CalculatorModel.calculateSIP(monthlyAmount, rate, years);
      final totalInvestment = monthlyAmount * years * 12;
      final totalGains = actualMaturityAmount - totalInvestment;

      setState(() {
        _result = '₹${monthlyAmount.toStringAsFixed(2)}';
        _additionalInfo = 'Target Amount: ₹${totalAmount.toStringAsFixed(2)}\nActual Maturity: ₹${actualMaturityAmount.toStringAsFixed(2)}\nTotal Investment: ₹${totalInvestment.toStringAsFixed(2)}\nTotal Gains: ₹${totalGains.toStringAsFixed(2)}';
      });
    }
  }

  void _calculateUnit() {
    final totalCost = double.tryParse(_controllers['totalCost']?.text ?? '') ?? 0;
    final quantity = int.tryParse(_controllers['quantity']?.text ?? '') ?? 0;

    if (totalCost > 0 && quantity > 0) {
      final unitPrice = CalculatorModel.calculateUnitPrice(totalCost, quantity);

      setState(() {
        _result = '₹${unitPrice.toStringAsFixed(2)}';
        _additionalInfo = 'Price per unit';
      });
    }
  }

  void _calculateROI() {
    final gain = double.tryParse(_controllers['gain']?.text ?? '') ?? 0;
    final cost = double.tryParse(_controllers['cost']?.text ?? '') ?? 0;

    if (cost > 0) {
      final roi = CalculatorModel.calculateROI(gain, cost);

      setState(() {
        _result = '${roi.toStringAsFixed(2)}%';
        _additionalInfo = roi >= 0 ? 'Profit' : 'Loss';
      });
    }
  }

  void _calculatePPF() {
    final yearlyAmount = double.tryParse(_controllers['yearlyAmount']?.text ?? '') ?? 0;
    final rate = double.tryParse(_controllers['rate']?.text ?? '') ?? 0;
    final years = int.tryParse(_controllers['years']?.text ?? '') ?? 0;

    if (yearlyAmount > 0 && rate > 0 && years > 0) {
      final maturityAmount = CalculatorModel.calculatePPF(yearlyAmount, rate, years);
      final totalInvestment = yearlyAmount * years;
      final totalInterest = maturityAmount - totalInvestment;

      setState(() {
        _result = '₹${maturityAmount.toStringAsFixed(2)}';
        _additionalInfo = 'Total Investment: ₹${totalInvestment.toStringAsFixed(2)}\nTotal Interest: ₹${totalInterest.toStringAsFixed(2)}';
      });
    }
  }

  void _calculateTip() {
    final billAmount = double.tryParse(_controllers['billAmount']?.text ?? '') ?? 0;
    final tipPercentage = double.tryParse(_controllers['tipPercentage']?.text ?? '') ?? 0;

    if (billAmount > 0) {
      final tipAmount = CalculatorModel.calculateTip(billAmount, tipPercentage);
      final totalAmount = billAmount + tipAmount;

      setState(() {
        _result = '₹${tipAmount.toStringAsFixed(2)}';
        _additionalInfo = 'Total Amount: ₹${totalAmount.toStringAsFixed(2)}';
      });
    }
  }

  void _calculateAPY() {
    final rate = double.tryParse(_controllers['rate']?.text ?? '') ?? 0;
    final frequency = int.tryParse(_controllers['frequency']?.text ?? '') ?? 0;

    if (rate > 0 && frequency > 0) {
      final apy = CalculatorModel.calculateAPY(rate, frequency);

      setState(() {
        _result = '${apy.toStringAsFixed(2)}%';
        _additionalInfo = 'Annual Percentage Yield';
      });
    }
  }

  void _calculateSales() {
    final costPrice = double.tryParse(_controllers['costPrice']?.text ?? '') ?? 0;
    final profitMargin = double.tryParse(_controllers['profitMargin']?.text ?? '') ?? 0;

    if (costPrice > 0) {
      final salesPrice = CalculatorModel.calculateSalesPrice(costPrice, profitMargin);
      final profit = salesPrice - costPrice;

      setState(() {
        _result = '₹${salesPrice.toStringAsFixed(2)}';
        _additionalInfo = 'Profit: ₹${profit.toStringAsFixed(2)}';
      });
    }
  }

  void _calculateAge() {
    if (_selectedDate != null && _currentDate != null) {
      final age = CalculatorModel.calculateAge(_selectedDate!, _currentDate!);

      setState(() {
        _result = '${age['years']} years, ${age['months']} months, ${age['days']} days';
        _additionalInfo = 'Total days: ${_currentDate!.difference(_selectedDate!).inDays}';
      });
    }
  }

  void _calculateBMI() {
    final weight = double.tryParse(_controllers['weight']?.text ?? '') ?? 0;
    final height = double.tryParse(_controllers['height']?.text ?? '') ?? 0;

    if (weight > 0 && height > 0) {
      final bmiData = CalculatorModel.calculateBMI(weight, height);

      setState(() {
        _result = '${bmiData['bmi'].toStringAsFixed(1)}';
        _additionalInfo = bmiData['category'];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.calculatorType.name),
        backgroundColor: Theme.of(context).colorScheme.surface,
        foregroundColor: Theme.of(context).colorScheme.onSurface,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Theme.of(context).colorScheme.primary.withValues(alpha: 0.05),
              Theme.of(context).colorScheme.surface,
            ],
          ),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Card(
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Text(
                        widget.calculatorType.icon,
                        style: const TextStyle(fontSize: 48),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        widget.calculatorType.description,
                        style: Theme.of(context).textTheme.bodyMedium,
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),
              ..._buildInputFields(),
              const SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: _calculate,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Theme.of(context).colorScheme.primary,
                        foregroundColor: Theme.of(context).colorScheme.onPrimary,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 2,
                      ),
                      child: const Text(
                        'Calculate',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: OutlinedButton(
                      onPressed: _reset,
                      style: OutlinedButton.styleFrom(
                        foregroundColor: Theme.of(context).colorScheme.primary,
                        side: BorderSide(
                          color: Theme.of(context).colorScheme.primary,
                          width: 2,
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text(
                        'Reset',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              if (_result.isNotEmpty) ...[
                ResultDisplay(
                  title: _getResultTitle(),
                  value: _result,
                  subtitle: _additionalInfo.isNotEmpty ? _additionalInfo : null,
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> _buildInputFields() {
    switch (widget.calculatorType.route) {
      case '/calculator/emi':
        return [
          InputField(
            label: 'Principal Amount',
            hint: 'Enter loan amount',
            controller: _controllers['principal']!,
            suffix: '₹',
          ),
          InputField(
            label: 'Interest Rate',
            hint: 'Enter annual interest rate',
            controller: _controllers['rate']!,
            suffix: '%',
          ),
          InputField(
            label: 'Tenure',
            hint: 'Enter loan tenure in months',
            controller: _controllers['tenure']!,
            suffix: 'months',
          ),
        ];
      case '/calculator/rd':
        return [
          InputField(
            label: 'Monthly Amount',
            hint: 'Enter monthly deposit',
            controller: _controllers['monthlyAmount']!,
            suffix: '₹',
          ),
          InputField(
            label: 'Interest Rate',
            hint: 'Enter annual interest rate',
            controller: _controllers['rate']!,
            suffix: '%',
          ),
          InputField(
            label: 'Tenure',
            hint: 'Enter tenure in months',
            controller: _controllers['months']!,
            suffix: 'months',
          ),
        ];
      case '/calculator/fd':
        return [
          InputField(
            label: 'Principal Amount',
            hint: 'Enter deposit amount',
            controller: _controllers['principal']!,
            suffix: '₹',
          ),
          InputField(
            label: 'Interest Rate',
            hint: 'Enter annual interest rate',
            controller: _controllers['rate']!,
            suffix: '%',
          ),
          InputField(
            label: 'Tenure',
            hint: 'Enter tenure in years',
            controller: _controllers['years']!,
            suffix: 'years',
          ),
        ];
      case '/calculator/sip-monthly':
        return [
          InputField(
            label: 'Monthly Investment',
            hint: 'Enter monthly SIP amount',
            controller: _controllers['monthlyAmount']!,
            suffix: '₹',
          ),
          InputField(
            label: 'Expected Return',
            hint: 'Enter expected annual return',
            controller: _controllers['rate']!,
            suffix: '%',
          ),
          InputField(
            label: 'Investment Period',
            hint: 'Enter investment period in years',
            controller: _controllers['years']!,
            suffix: 'years',
          ),
        ];
      case '/calculator/sip-total':
        return [
          InputField(
            label: 'Target Amount',
            hint: 'Enter target maturity amount',
            controller: _controllers['totalAmount']!,
            suffix: '₹',
          ),
          InputField(
            label: 'Expected Return',
            hint: 'Enter expected annual return',
            controller: _controllers['rate']!,
            suffix: '%',
          ),
          InputField(
            label: 'Investment Period',
            hint: 'Enter investment period in years',
            controller: _controllers['years']!,
            suffix: 'years',
          ),
        ];
      case '/calculator/unit':
        return [
          InputField(
            label: 'Total Cost',
            hint: 'Enter total cost',
            controller: _controllers['totalCost']!,
            suffix: '₹',
          ),
          InputField(
            label: 'Quantity',
            hint: 'Enter quantity',
            controller: _controllers['quantity']!,
            suffix: 'units',
          ),
        ];
      case '/calculator/roi':
        return [
          InputField(
            label: 'Current Value',
            hint: 'Enter current value',
            controller: _controllers['gain']!,
            suffix: '₹',
          ),
          InputField(
            label: 'Investment Cost',
            hint: 'Enter original investment',
            controller: _controllers['cost']!,
            suffix: '₹',
          ),
        ];
      case '/calculator/ppf':
        return [
          InputField(
            label: 'Yearly Investment',
            hint: 'Enter yearly PPF amount',
            controller: _controllers['yearlyAmount']!,
            suffix: '₹',
          ),
          InputField(
            label: 'Interest Rate',
            hint: 'Enter annual interest rate',
            controller: _controllers['rate']!,
            suffix: '%',
          ),
          InputField(
            label: 'Investment Period',
            hint: 'Enter investment period in years',
            controller: _controllers['years']!,
            suffix: 'years',
          ),
        ];
      case '/calculator/tip':
        return [
          InputField(
            label: 'Bill Amount',
            hint: 'Enter bill amount',
            controller: _controllers['billAmount']!,
            suffix: '₹',
          ),
          InputField(
            label: 'Tip Percentage',
            hint: 'Enter tip percentage',
            controller: _controllers['tipPercentage']!,
            suffix: '%',
          ),
        ];
      case '/calculator/apy':
        return [
          InputField(
            label: 'Annual Interest Rate',
            hint: 'Enter annual interest rate',
            controller: _controllers['rate']!,
            suffix: '%',
          ),
          InputField(
            label: 'Compounding Frequency',
            hint: 'Enter compounding frequency per year',
            controller: _controllers['frequency']!,
            suffix: 'times/year',
          ),
        ];
      case '/calculator/sales':
        return [
          InputField(
            label: 'Cost Price',
            hint: 'Enter cost price',
            controller: _controllers['costPrice']!,
            suffix: '₹',
          ),
          InputField(
            label: 'Profit Margin',
            hint: 'Enter profit margin',
            controller: _controllers['profitMargin']!,
            suffix: '%',
          ),
        ];
      case '/calculator/age':
        return [
          Container(
            margin: const EdgeInsets.symmetric(vertical: 8),
            child: Card(
              child: ListTile(
                title: const Text('Birth Date'),
                subtitle: Text(_selectedDate != null 
                    ? '${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year}'
                    : 'Select your birth date'),
                trailing: const Icon(Icons.calendar_today),
                onTap: () async {
                  final date = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now().subtract(const Duration(days: 365 * 25)),
                    firstDate: DateTime(1900),
                    lastDate: DateTime.now(),
                  );
                  if (date != null) {
                    setState(() {
                      _selectedDate = date;
                    });
                  }
                },
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 8),
            child: Card(
              child: ListTile(
                title: const Text('Current Date'),
                subtitle: Text(_currentDate != null 
                    ? '${_currentDate!.day}/${_currentDate!.month}/${_currentDate!.year}'
                    : 'Select current date'),
                trailing: const Icon(Icons.calendar_today),
                onTap: () async {
                  final date = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(1900),
                    lastDate: DateTime(2100),
                  );
                  if (date != null) {
                    setState(() {
                      _currentDate = date;
                    });
                  }
                },
              ),
            ),
          ),
        ];
      case '/calculator/bmi':
        return [
          InputField(
            label: 'Weight',
            hint: 'Enter your weight',
            controller: _controllers['weight']!,
            suffix: 'kg',
          ),
          InputField(
            label: 'Height',
            hint: 'Enter your height',
            controller: _controllers['height']!,
            suffix: 'm',
          ),
        ];
      default:
        return [];
    }
  }

  String _getResultTitle() {
    switch (widget.calculatorType.route) {
      case '/calculator/emi':
        return 'Monthly EMI';
      case '/calculator/rd':
        return 'Maturity Amount';
      case '/calculator/fd':
        return 'Maturity Amount';
      case '/calculator/sip-monthly':
        return 'Maturity Amount';
      case '/calculator/sip-total':
        return 'Required Monthly SIP';
      case '/calculator/unit':
        return 'Unit Price';
      case '/calculator/roi':
        return 'Return on Investment';
      case '/calculator/ppf':
        return 'Maturity Amount';
      case '/calculator/tip':
        return 'Tip Amount';
      case '/calculator/apy':
        return 'Annual Percentage Yield';
      case '/calculator/sales':
        return 'Selling Price';
      case '/calculator/age':
        return 'Your Age';
      case '/calculator/bmi':
        return 'BMI';
      default:
        return 'Result';
    }
  }

  @override
  void dispose() {
    for (var controller in _controllers.values) {
      controller.dispose();
    }
    super.dispose();
  }
}