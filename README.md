# Loan's EMI Lens Calculator App Architecture

## App Overview
A comprehensive financial calculator app featuring 12 different calculators with splash screen, intro screens, and modern UI design. Take control of your finances with Loan's EMI Lens, the ultimate loan and EMI calculator app designed to simplify your loan planning. Whether you're applying for a personal loan, car loan, home loan, or any type of EMI-based borrowing, this app provides quick, accurate, and easy-to-understand calculations in just a few taps.

## Install this App from Google PayStore.
[<img alt="Get it on Google Play" height="80" src="https://play.google.com/intl/en_us/badges/images/generic/en_badge_web_generic.png">](https://play.google.com/store/apps/details?id=in.innovateria.loanlens)

## Features
1. **Splash Screen** - Animated app introduction
2. **Intro Screens** - Feature walkthrough
3. **12 Calculator Types:**
    - EMI (Equated Monthly Installment)
    - RD (Recurring Deposit)
    - FD (Fixed Deposit)
    - SIP (Systematic Investment Plan)
    - Unit Price Calculator
    - ROI (Return on Investment)
    - PPF (Public Provident Fund)
    - TIP Calculator
    - APY (Annual Percentage Yield)
    - Sales Calculator
    - Age Calculator
    - BMI (Body Mass Index) Calculator

## Technical Architecture

### Core Components
1. **main.dart** - App entry point and routing
2. **theme.dart** - Already provided with purple theme
3. **splash_screen.dart** - Animated splash screen
4. **intro_screen.dart** - Feature introduction
5. **home_screen.dart** - Main dashboard with calculator grid
6. **calculator_screen.dart** - Generic calculator template
7. **models/calculator_model.dart** - Data models and calculations
8. **widgets/calculator_card.dart** - Reusable calculator card
9. **widgets/input_field.dart** - Custom input field
10. **widgets/result_display.dart** - Result display component

### Calculator Implementation Strategy
- Use a generic calculator screen template
- Pass calculator type and configuration
- Implement calculation logic in separate model classes
- Each calculator has its own input fields and result display

### UI/UX Design Principles
- Modern card-based design with rounded corners
- Gradient backgrounds and subtle shadows
- Animated transitions between screens
- Responsive grid layout for calculator selection
- Clean input forms with floating labels
- Prominent result displays with color coding

### Data Flow
1. User selects calculator type from home screen
2. Navigate to calculator screen with specific configuration
3. User inputs values through custom input fields
4. Real-time calculation updates as user types
5. Results displayed with clear formatting and explanations

## Implementation Steps
1. Update main.dart with proper title and navigation
2. Create splash screen with brand animation
3. Build intro screen with feature highlights
4. Implement home screen with calculator grid
5. Create generic calculator screen template
6. Build individual calculator logic and models
7. Create reusable UI components
8. Add animations and transitions
9. Test and debug all calculators
10. Compile and fix any issues

## File Structure
```
lib/
├── main.dart
├── theme.dart
├── screens/
│   ├── splash_screen.dart
│   ├── intro_screen.dart
│   ├── home_screen.dart
│   └── calculator_screen.dart
├── models/
│   └── calculator_model.dart
└── widgets/
    ├── calculator_card.dart
    ├── input_field.dart
    └── result_display.dart
```

## Technology Stack
- Flutter 3.6+
- Material Design 3
- Google Fonts (Inter)
- Built-in animations
- Local state management
