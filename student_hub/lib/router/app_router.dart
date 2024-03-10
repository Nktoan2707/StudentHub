import 'package:flutter/material.dart';
import 'package:student_hub/features/authentication/pages/home_page.dart';
import 'package:student_hub/features/authentication/pages/login_page.dart';
import 'package:student_hub/features/authentication/pages/sign_up_step_1_page.dart';
import 'package:student_hub/features/authentication/pages/sign_up_step_2_page.dart';
import 'package:student_hub/features/authentication/pages/switch_account_page.dart';
import 'package:student_hub/features/dashboard/pages/dashboard_main_page.dart';
import 'package:student_hub/features/profile/pages/company_already_have_profile_input_page.dart';
import 'package:student_hub/features/profile/pages/company_not_have_profile_input_page.dart';
import 'package:student_hub/features/profile/pages/student_profile_input_step_1_page.dart';
import 'package:student_hub/features/profile/pages/student_profile_input_step_2_page.dart';
import 'package:student_hub/features/profile/pages/student_profile_input_step_3_page.dart';
import 'package:student_hub/features/profile/pages/welcome_page.dart';

class AppRouter {
  // final HomeBloc _homeBloc = HomeBloc(taskRepository: TaskRepository());

  Route? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case HomePage.pageId:
        return MaterialPageRoute(builder: (_) => const HomePage());

      case LoginPage.pageId:
        return MaterialPageRoute(builder: (_) => const LoginPage());

      case SignUpStep1Page.pageId:
        return MaterialPageRoute(builder: (_) => const SignUpStep1Page());

      case SignUpStep2Page.pageId:
        return MaterialPageRoute(builder: (_) => const SignUpStep2Page());

      case SwitchAccountPage.pageId:
        return MaterialPageRoute(builder: (_) => const SwitchAccountPage());

      case CompanyNotHaveProfileInputPage.pageId:
        return MaterialPageRoute(builder: (_) => const CompanyNotHaveProfileInputPage());

      case CompanyAlreadyHaveProfileInputPage.pageId:
        return MaterialPageRoute(builder: (_) => const CompanyAlreadyHaveProfileInputPage());

      case WelcomePage.pageId:
        return MaterialPageRoute(builder: (_) => const WelcomePage());

      case DashboardMainPage.pageId:
        return MaterialPageRoute(builder: (_) => const DashboardMainPage());

      case StudentProfileInputStep1Page.pageId:
        return MaterialPageRoute(builder: (_) => const StudentProfileInputStep1Page());

      case StudentProfileInputStep2Page.pageId:
        return MaterialPageRoute(builder: (_) => const StudentProfileInputStep2Page());

      case StudentProfileInputStep3Page.pageId:
        return MaterialPageRoute(builder: (_) => const StudentProfileInputStep3Page());

      default:
        return null;
    }
  }

  void dispose() {
    // _homeBloc.close();
  }
}
