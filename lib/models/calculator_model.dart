import 'dart:math';

class CalculatorModel {
  static double calculateEMI(double principal, double rate, int tenure) {
    if (principal <= 0 || rate <= 0 || tenure <= 0) return 0;
    double monthlyRate = rate / (12 * 100);
    double emi = (principal * monthlyRate * pow(1 + monthlyRate, tenure)) / 
                 (pow(1 + monthlyRate, tenure) - 1);
    return emi;
  }

  static double calculateRD(double monthlyAmount, double rate, int months) {
    if (monthlyAmount <= 0 || rate <= 0 || months <= 0) return 0;
    double monthlyRate = rate / (12 * 100);
    double maturityAmount = monthlyAmount * 
                           (pow(1 + monthlyRate, months) - 1) / monthlyRate;
    return maturityAmount;
  }

  static double calculateFD(double principal, double rate, int years) {
    if (principal <= 0 || rate <= 0 || years <= 0) return 0;
    double maturityAmount = principal * pow(1 + rate / 100, years);
    return maturityAmount;
  }

  static double calculateSIP(double monthlyAmount, double rate, int years) {
    if (monthlyAmount <= 0 || rate <= 0 || years <= 0) return 0;
    double monthlyRate = rate / (12 * 100);
    int months = years * 12;
    double maturityAmount = monthlyAmount * 
                           (pow(1 + monthlyRate, months) - 1) / monthlyRate * 
                           (1 + monthlyRate);
    return maturityAmount;
  }

  static double calculateSIPMonthlyFromTotal(double totalAmount, double rate, int years) {
    if (totalAmount <= 0 || rate <= 0 || years <= 0) return 0;
    double monthlyRate = rate / (12 * 100);
    int months = years * 12;
    double monthlyAmount = totalAmount / 
                          ((pow(1 + monthlyRate, months) - 1) / monthlyRate * 
                           (1 + monthlyRate));
    return monthlyAmount;
  }

  static double calculateUnitPrice(double totalCost, int quantity) {
    if (totalCost <= 0 || quantity <= 0) return 0;
    return totalCost / quantity;
  }

  static double calculateROI(double gain, double cost) {
    if (cost <= 0) return 0;
    return ((gain - cost) / cost) * 100;
  }

  static double calculatePPF(double yearlyAmount, double rate, int years) {
    if (yearlyAmount <= 0 || rate <= 0 || years <= 0) return 0;
    double maturityAmount = yearlyAmount * 
                           (pow(1 + rate / 100, years) - 1) / (rate / 100);
    return maturityAmount;
  }

  static double calculateTip(double billAmount, double tipPercentage) {
    if (billAmount <= 0 || tipPercentage < 0) return 0;
    return billAmount * (tipPercentage / 100);
  }

  static double calculateAPY(double rate, int compoundingFrequency) {
    if (rate <= 0 || compoundingFrequency <= 0) return 0;
    double apy = pow(1 + rate / (100 * compoundingFrequency), compoundingFrequency) - 1;
    return apy * 100;
  }

  static double calculateSalesPrice(double costPrice, double profitMargin) {
    if (costPrice <= 0 || profitMargin < 0) return 0;
    return costPrice * (1 + profitMargin / 100);
  }

  static Map<String, int> calculateAge(DateTime birthDate, DateTime currentDate) {
    int years = currentDate.year - birthDate.year;
    int months = currentDate.month - birthDate.month;
    int days = currentDate.day - birthDate.day;

    if (days < 0) {
      months--;
      days += DateTime(currentDate.year, currentDate.month, 0).day;
    }
    if (months < 0) {
      years--;
      months += 12;
    }

    return {'years': years, 'months': months, 'days': days};
  }

  static Map<String, dynamic> calculateBMI(double weight, double height) {
    if (weight <= 0 || height <= 0) return {'bmi': 0.0, 'category': 'Invalid'};
    double bmi = weight / (height * height);
    String category;
    
    if (bmi < 18.5) {
      category = 'Underweight';
    } else if (bmi < 25) {
      category = 'Normal weight';
    } else if (bmi < 30) {
      category = 'Overweight';
    } else {
      category = 'Obese';
    }
    
    return {'bmi': bmi, 'category': category};
  }
}

class CalculatorType {
  final String name;
  final String description;
  final String icon;
  final String route;

  const CalculatorType({
    required this.name,
    required this.description,
    required this.icon,
    required this.route,
  });
}

class CalculatorData {
  static const List<CalculatorType> calculators = [
    CalculatorType(
      name: 'EMI Calculator',
      description: 'Calculate loan EMI',
      icon: '🏠',
      route: '/calculator/emi',
    ),
    CalculatorType(
      name: 'RD Calculator',
      description: 'Recurring Deposit',
      icon: '💰',
      route: '/calculator/rd',
    ),
    CalculatorType(
      name: 'FD Calculator',
      description: 'Fixed Deposit',
      icon: '🏦',
      route: '/calculator/fd',
    ),
    CalculatorType(
      name: 'SIP Monthly',
      description: 'Monthly SIP Investment',
      icon: '📈',
      route: '/calculator/sip-monthly',
    ),
    CalculatorType(
      name: 'SIP Total',
      description: 'Total Amount SIP',
      icon: '💰',
      route: '/calculator/sip-total',
    ),
    CalculatorType(
      name: 'Unit Price',
      description: 'Price per unit',
      icon: '🏷️',
      route: '/calculator/unit',
    ),
    CalculatorType(
      name: 'ROI Calculator',
      description: 'Return on Investment',
      icon: '💹',
      route: '/calculator/roi',
    ),
    CalculatorType(
      name: 'PPF Calculator',
      description: 'Public Provident Fund',
      icon: '🎯',
      route: '/calculator/ppf',
    ),
    CalculatorType(
      name: 'Tip Calculator',
      description: 'Calculate tip amount',
      icon: '🍽️',
      route: '/calculator/tip',
    ),
    CalculatorType(
      name: 'APY Calculator',
      description: 'Annual Percentage Yield',
      icon: '📊',
      route: '/calculator/apy',
    ),
    CalculatorType(
      name: 'Sales Calculator',
      description: 'Calculate selling price',
      icon: '🛒',
      route: '/calculator/sales',
    ),
    CalculatorType(
      name: 'Age Calculator',
      description: 'Calculate your age',
      icon: '🎂',
      route: '/calculator/age',
    ),
    CalculatorType(
      name: 'BMI Calculator',
      description: 'Body Mass Index',
      icon: '⚖️',
      route: '/calculator/bmi',
    ),
  ];
}