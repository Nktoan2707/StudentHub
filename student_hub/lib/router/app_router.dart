import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:student_hub/data/data_providers/authentication_repository.dart';
import 'package:student_hub/data/data_providers/company_repository.dart';
import 'package:student_hub/data/data_providers/student_repository.dart';
import 'package:student_hub/features/authentication/bloc/authentication_bloc.dart';
import 'package:student_hub/features/login/bloc/login_bloc.dart';
import 'package:student_hub/features/login/pages/home_page.dart';
import 'package:student_hub/features/login/pages/login_page.dart';
import 'package:student_hub/features/profile_company/bloc/company_profile_bloc.dart';
import 'package:student_hub/features/profile_student/bloc/student_profile_bloc.dart';
import 'package:student_hub/features/profile_company/pages/company_profile_input_page.dart';
import 'package:student_hub/features/profile_student/pages/welcome_page.dart';
import 'package:student_hub/features/signup/bloc/signup_bloc.dart';
import 'package:student_hub/features/signup/pages/sign_up_step_1_page.dart';
import 'package:student_hub/features/signup/pages/sign_up_step_2_page.dart';
import 'package:student_hub/features/authentication/pages/switch_account_page.dart';
import 'package:student_hub/features/main_tab_bar_page.dart';
import 'package:student_hub/features/message/components/tab_message_list_item_view.dart';
import 'package:student_hub/features/message/pages/tab_message_detail_page.dart';
import 'package:student_hub/features/message/pages/tab_message_page.dart';
import 'package:student_hub/features/message/pages/video_call_page.dart';
import 'package:student_hub/features/notification/pages/notification_page.dart';
import 'package:student_hub/features/project_company/pages/company_dashboard_page.dart';
import 'package:student_hub/features/profile_student/pages/student_profile_input_step_1_page.dart';
import 'package:student_hub/features/profile_student/pages/student_profile_input_step_2_page.dart';
import 'package:student_hub/features/profile_student/pages/student_profile_input_step_3_page.dart';
import 'package:student_hub/features/project_company/pages/company_post_project_step_1_page.dart';
import 'package:student_hub/features/project_company/pages/company_post_project_step_2_page.dart.dart';
import 'package:student_hub/features/project_company/pages/company_post_project_step_3_page.dart.dart';
import 'package:student_hub/features/project_company/pages/company_post_project_step_4_page.dart';
import 'package:student_hub/features/project_company/pages/company_project_detail_page.dart';
import 'package:student_hub/features/project_student/pages/student_dashboard_page.dart';
import 'package:student_hub/features/project_student/pages/student_project_detail_page.dart';
import 'package:student_hub/features/project_student/pages/student_project_list_page.dart';
import 'package:student_hub/features/project_student/pages/student_saved_project_list_page.dart';
import 'package:student_hub/features/project_student/pages/student_searched_project_list_page.dart';
import 'package:student_hub/features/project_student/pages/student_submit_proposal_page.dart';

class AppRouter {
  final LoginBloc _loginBloc;
  final SignupBloc _signupBloc;
  final CompanyProfileBloc _companyProfileBloc;

  AppRouter(AuthenticationRepository authenticationRepository)
      : _loginBloc =
            LoginBloc(authenticationRepository: authenticationRepository),
        _signupBloc =
            SignupBloc(authenticationRepository: authenticationRepository),
  _companyProfileBloc = CompanyProfileBloc(companyRepository: CompanyRepository());

  Route? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      //Feature Authentication
      case SwitchAccountPage.pageId:
        return MaterialPageRoute(builder: (_) => const SwitchAccountPage());

      //Feature Login
      case HomePage.pageId:
        return MaterialPageRoute(
            builder: (_) =>
                BlocProvider.value(value: _loginBloc, child: const HomePage()));

      case LoginPage.pageId:
        return MaterialPageRoute(
            builder: (_) => BlocProvider.value(
                value: _loginBloc, child: const LoginPage()));

      //Feature Signup

      case SignUpStep1Page.pageId:
        return MaterialPageRoute(
            builder: (_) => BlocProvider.value(
                value: _signupBloc, child: const SignUpStep1Page()));

      case SignUpStep2Page.pageId:
        return MaterialPageRoute(
            builder: (_) => BlocProvider.value(
                value: _signupBloc, child: const SignUpStep2Page()));

      // Feature Profile
      case CompanyProfileInputPage.pageId:
         return MaterialPageRoute(
            builder: (_) => BlocProvider.value(
                value: _companyProfileBloc, child: const CompanyProfileInputPage()));

      case StudentProfileInputStep1Page.pageId:
        return MaterialPageRoute(
            builder: (_) => const StudentProfileInputStep1Page());

      case StudentProfileInputStep2Page.pageId:
        return MaterialPageRoute(
            builder: (_) => const StudentProfileInputStep2Page());

      case StudentProfileInputStep3Page.pageId:
        return MaterialPageRoute(
            builder: (_) => const StudentProfileInputStep3Page());

      case WelcomePage.pageId:
        return MaterialPageRoute(builder: (_) => const WelcomePage());

      //Feature Project
      case MainTabBarPage.pageId:
        return MaterialPageRoute(builder: (_) => const MainTabBarPage());

      case CompanyDashboardPage.pageId:
        return MaterialPageRoute(builder: (_) => const CompanyDashboardPage());
      case CompanyProjectDetailPage.pageId:
        return MaterialPageRoute(
            builder: (_) => const CompanyProjectDetailPage());
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

      case CompanyPostProjectStep1Page.pageId:
        return MaterialPageRoute(
            builder: (_) => const CompanyPostProjectStep1Page());
      case CompanyPostProjectStep2Page.pageId:
        return MaterialPageRoute(
            builder: (_) => const CompanyPostProjectStep2Page());
      case CompanyPostProjectStep3Page.pageId:
        return MaterialPageRoute(
            builder: (_) => const CompanyPostProjectStep3Page());
      case CompanyPostProjectStep4Page.pageId:
        return MaterialPageRoute(
            builder: (_) => const CompanyPostProjectStep4Page());

      //Feature Message
      case TabMessagePage.pageId:
        return MaterialPageRoute(builder: (_) => const TabMessagePage());
      case TabMessageDetailPage.pageId:
        return MaterialPageRoute(builder: (_) => TabMessageDetailPage());
      case VideoCallPage.pageId:
        return MaterialPageRoute(builder: (_) => const VideoCallPage());

      //Feature Notification
      case NotificationPage.pageId:
        return MaterialPageRoute(builder: (_) => const NotificationPage());
      default:
        return null;
    }
  }

  void dispose() {
    _signupBloc.close();
    _loginBloc.close();
    _companyProfileBloc.close();
  }
}
