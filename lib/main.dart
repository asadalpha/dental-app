import 'package:dental_app/core/theme/app_theme.dart';
import 'package:dental_app/core/utils/page_transitions.dart';
import 'package:dental_app/features/dashboard/screens/dashboard_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'features/auth/providers/auth_provider.dart';
import 'features/dashboard/providers/checklist_provider.dart';
import 'features/onboarding/screens/onboarding_screen.dart';
import 'features/auth/screens/login_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => ChecklistProvider()),
      ],
      child: MaterialApp(
        title: 'IntelliDent AI',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.light,
        initialRoute: '/onboarding',
        onGenerateRoute: (settings) {
          Widget page;
          switch (settings.name) {
            case '/onboarding':
              page = const OnboardingScreen();
              break;
            case '/login':
              page = const LoginScreen();
              break;
            case '/home':
              page = const DashboardScreen();
              break;
            default:
              page = const OnboardingScreen();
          }

          return FadeRoute(page: page);
        },
      ),
    );
  }
}
