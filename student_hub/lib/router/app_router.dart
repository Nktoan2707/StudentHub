import 'package:flutter/material.dart';
import 'package:student_hub/features/authentication/pages/home_page.dart';
import 'package:student_hub/features/authentication/pages/login_page.dart';
import 'package:student_hub/features/authentication/pages/sign_up_step_1_page.dart';
import 'package:student_hub/features/authentication/pages/sign_up_step_2_page.dart';
import 'package:student_hub/features/authentication/pages/switch_account_page.dart';
import 'package:student_hub/features/project/pages/dashboard_main_page.dart';
import 'package:student_hub/features/profile/pages/company_already_have_profile_input_page.dart';
import 'package:student_hub/features/profile/pages/company_not_have_profile_input_page.dart';
import 'package:student_hub/features/profile/pages/student_profile_input_step_1_page.dart';
import 'package:student_hub/features/profile/pages/student_profile_input_step_2_page.dart';
import 'package:student_hub/features/profile/pages/student_profile_input_step_3_page.dart';
import 'package:student_hub/features/profile/pages/welcome_page.dart';
import 'package:student_hub/features/project/pages/project_detail_page.dart';
import 'package:student_hub/features/project/pages/student_dashboard_page.dart';
import 'package:student_hub/features/project/pages/student_project_detail_page.dart';
import 'package:student_hub/features/project/pages/student_project_list_page.dart';
import 'package:student_hub/features/project/pages/student_saved_project_list_page.dart';
import 'package:student_hub/features/project/pages/student_searched_project_list_page.dart';
import 'package:student_hub/features/project/pages/student_submit_proposal_page.dart';

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
        return MaterialPageRoute(
            builder: (_) => const CompanyNotHaveProfileInputPage());

      case CompanyAlreadyHaveProfileInputPage.pageId:
        return MaterialPageRoute(
            builder: (_) => const CompanyAlreadyHaveProfileInputPage());

      case WelcomePage.pageId:
        return MaterialPageRoute(builder: (_) => const WelcomePage());

      case DashboardMainPage.pageId:
        return MaterialPageRoute(builder: (_) => const DashboardMainPage());

      case StudentProfileInputStep1Page.pageId:
        return MaterialPageRoute(
            builder: (_) => const StudentProfileInputStep1Page());

      case StudentProfileInputStep2Page.pageId:
        return MaterialPageRoute(
            builder: (_) => const StudentProfileInputStep2Page());

      case StudentProfileInputStep3Page.pageId:
        return MaterialPageRoute(
            builder: (_) => const StudentProfileInputStep3Page());

      case ProjectDetailPage.pageId:
        return MaterialPageRoute(builder: (_) => const ProjectDetailPage());

      case StudentProjectListPage.pageId:
        return MaterialPageRoute(
            builder: (_) => const StudentProjectListPage());

      case StudentProjectDetailPage.pageId:
        return MaterialPageRoute(
            builder: (_) => const StudentProjectDetailPage(),
            settings: settings);

      case StudentSavedProjectListPage.pageId:
        return MaterialPageRoute(
            builder: (_) => const StudentSavedProjectListPage());

      case StudentSearchedProjectListPage.pageId:
        return MaterialPageRoute(
            builder: (_) => const StudentSearchedProjectListPage());

      case StudentSubmitProposalPage.pageId:
        return MaterialPageRoute(
            builder: (_) => const StudentSubmitProposalPage());

      case StudentDashboardPage.pageId:
        return MaterialPageRoute(builder: (_) => const StudentDashboardPage());

      default:
        return null;
    }
  }

  void dispose() {
    // _homeBloc.close();
  }
}
