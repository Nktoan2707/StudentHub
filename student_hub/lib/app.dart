import 'package:flutter/material.dart';
import 'package:student_hub/features/authentication/pages/home_page.dart';
import 'package:student_hub/features/authentication/pages/login_page.dart';
import 'package:student_hub/features/authentication/pages/sign_up_step_1_page.dart';
import 'package:student_hub/features/dashboard/pages/dashboard_main_page.dart';
import 'package:student_hub/features/profile/pages/company_not_have_profile_input_page.dart';
import 'package:student_hub/features/profile/pages/student_profile_input_step3_page.dart';
import 'package:student_hub/features/profile/pages/welcome_page.dart';
import 'package:student_hub/router/app_router.dart';



class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return const AppView();
  }
}

class AppView extends StatefulWidget {
  const AppView({super.key});


  @override
  State<AppView> createState() => _AppViewState();
}

class _AppViewState extends State<AppView> {
  final AppRouter _appRouter = AppRouter();


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "TODO List",
      theme: ThemeData.from(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromRGBO(32, 63, 129, 1.0),
        ),
      ),
      // initialRoute: HomePage.pageId,
      // onGenerateRoute: _appRouter.onGenerateRoute,
      home: const StudentProfileInputStep3Page(),
    );
  }

  @override
  void dispose() {
    _appRouter.dispose();
    super.dispose();
  }
}

