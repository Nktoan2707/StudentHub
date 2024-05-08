import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:student_hub/data/data_providers/authentication_repository.dart';
import 'package:student_hub/data/data_providers/company_repository.dart';
import 'package:student_hub/data/data_providers/message_repository.dart';
import 'package:student_hub/data/data_providers/project_repository.dart';
import 'package:student_hub/data/data_providers/proposal_repository.dart';
import 'package:student_hub/data/data_providers/student_repository.dart';
import 'package:student_hub/data/data_providers/user_repository.dart';
import 'package:student_hub/data/models/domain/user.dart';
import 'package:student_hub/features/company_profile/bloc/company_profile_bloc.dart';
import 'package:student_hub/features/company_profile/pages/company_profile_input_page.dart';
import 'package:student_hub/features/dashboard_student/bloc/dashboard_student_bloc.dart';
import 'package:student_hub/features/dashboard_student_accept_proposal/bloc/dashboard_student_accept_proposal_bloc.dart';
import 'package:student_hub/features/dashboard_student_accept_proposal/pages/dashboard_student_accept_page.dart';
import 'package:student_hub/features/login/bloc/login_bloc.dart';
import 'package:student_hub/features/login/pages/home_page.dart';
import 'package:student_hub/features/login/pages/login_page.dart';
import 'package:student_hub/features/message/bloc/message_bloc.dart';
import 'package:student_hub/features/profile_student/bloc/student_profile_bloc.dart';

import 'package:student_hub/features/profile_student/pages/welcome_page.dart';
import 'package:student_hub/features/project_company/bloc/company_project_bloc.dart';
import 'package:student_hub/features/project_company/bloc/proposal/company_proposal_bloc.dart';
import 'package:student_hub/features/project_student/bloc/project_student_bloc.dart';
import 'package:student_hub/features/signup/bloc/signup_bloc.dart';
import 'package:student_hub/features/signup/pages/sign_up_page.dart';
import 'package:student_hub/features/signup/pages/sign_up_choose_role_page.dart';
import 'package:student_hub/features/authentication/pages/switch_account_page.dart';
import 'package:student_hub/features/main_tab_bar_page.dart';
import 'package:student_hub/features/message/pages/tab_message_detail_page.dart';
import 'package:student_hub/features/message/pages/tab_message_page.dart';
import 'package:student_hub/features/message/pages/video_call_page.dart';
import 'package:student_hub/features/notification/pages/notification_page.dart';
import 'package:student_hub/features/project_company/pages/company_dashboard_page.dart';
import 'package:student_hub/features/profile_student/pages/student_profile_input_step_1_page.dart';
import 'package:student_hub/features/profile_student/pages/student_profile_input_step_2_page.dart';
import 'package:student_hub/features/profile_student/pages/student_profile_input_step_3_page.dart';
import 'package:student_hub/features/project_company/pages/company_post_project_step_1_page.dart';
import 'package:student_hub/features/project_company/pages/company_post_project_step_2_page.dart';
import 'package:student_hub/features/project_company/pages/company_post_project_step_3_page.dart';
import 'package:student_hub/features/project_company/pages/company_post_project_step_4_page.dart';
import 'package:student_hub/features/project_company/pages/company_project_detail_page.dart';
import 'package:student_hub/features/dashboard_student/pages/student_dashboard_page.dart';
import 'package:student_hub/features/project_student/pages/student_project_detail_page.dart';
import 'package:student_hub/features/project_student/pages/student_project_list_page.dart';
import 'package:student_hub/features/project_student/pages/student_saved_project_list_page.dart';
import 'package:student_hub/features/project_student/pages/student_searched_project_list_page.dart';
import 'package:student_hub/features/submit_proposal_student/bloc/submit_proposal_student_bloc.dart';
import 'package:student_hub/features/submit_proposal_student/pages/student_submit_proposal_page.dart';
import 'package:student_hub/widgets/pages/splash_page.dart';

class AppRouter {
  final LoginBloc _loginBloc;
  final SignupBloc _signupBloc;
  final CompanyProfileBloc _companyProfileBloc;
  final CompanyProjectBloc _companyProjectBloc;
  final CompanyProjectBloc _companyProjectDetailBloc;
  final CompanyProjectBloc _companyProjectEditBloc;
  final ProjectStudentBloc _projectStudentBloc;
  final StudentProfileBloc _studentProfileBloc;
  final CompanyProposalBloc _companyProposalBloc;
  final SubmitProposalStudentBloc _submitProposalStudent;
  final DashboardStudentBloc _dashboardStudentBloc;
  final DashboardStudentAcceptProposalBloc _dashboardStudentAcceptProposalBloc;
  final MessageBloc _projectMessageList;
  final AuthenticationRepository _authenticationRepository;

  AppRouter(AuthenticationRepository authenticationRepository)
      : _loginBloc =
            LoginBloc(authenticationRepository: authenticationRepository),
        _signupBloc =
            SignupBloc(authenticationRepository: authenticationRepository),
        _companyProfileBloc = CompanyProfileBloc(
            companyRepository: CompanyRepository(),
            userRepository: UserRepository(),
            authenticationRepository: authenticationRepository),
        _companyProjectBloc = CompanyProjectBloc(
            projectRepository: ProjectRepository(),
            authenticationRepository: authenticationRepository,
            userRepository: UserRepository()),
        _companyProjectDetailBloc = CompanyProjectBloc(
            projectRepository: ProjectRepository(),
            authenticationRepository: authenticationRepository,
            userRepository: UserRepository()),
        _companyProjectEditBloc = CompanyProjectBloc(
            projectRepository: ProjectRepository(),
            authenticationRepository: authenticationRepository,
            userRepository: UserRepository()),
        _projectStudentBloc = ProjectStudentBloc(
            projectRepository: ProjectRepository(),
            authenticationRepository: authenticationRepository,
            userRepository: UserRepository()),
        _studentProfileBloc = StudentProfileBloc(
            studentRepository: StudentRepository(),
            userRepository: UserRepository(),
            authenticationRepository: authenticationRepository),
        _companyProposalBloc = CompanyProposalBloc(
            proposalRepository: ProposalRepository(),
            userRepository: UserRepository(),
            authenticationRepository: authenticationRepository),
        _submitProposalStudent = SubmitProposalStudentBloc(
            proposalRepository: ProposalRepository(),
            userRepository: UserRepository(),
            authenticationRepository: authenticationRepository),
        _dashboardStudentBloc = DashboardStudentBloc(
            proposalRepository: ProposalRepository(),
            userRepository: UserRepository(),
            authenticationRepository: authenticationRepository),
        _dashboardStudentAcceptProposalBloc =
            DashboardStudentAcceptProposalBloc(
                proposalRepository: ProposalRepository(),
                userRepository: UserRepository(),
                authenticationRepository: authenticationRepository),
        _projectMessageList = MessageBloc(
            userRepository: UserRepository(),
            authenticationRepository: authenticationRepository,
            messageRepository: MessageRepository()),
        _authenticationRepository = authenticationRepository;

  Route? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      //Feature Authentication
      case SwitchAccountPage.pageId:
        return MaterialPageRoute(
            builder: (_) => MultiBlocProvider(providers: [
                  BlocProvider.value(value: _companyProfileBloc),
                  BlocProvider.value(value: _studentProfileBloc),
                ], child: const SwitchAccountPage()));

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
      case SignUpChooseRolePage.pageId:
        return MaterialPageRoute(
            builder: (_) => BlocProvider.value(
                value: _signupBloc, child: const SignUpChooseRolePage()));

      case SignUpPage.pageId:
        return MaterialPageRoute(
            builder: (_) => BlocProvider.value(
                value: _signupBloc, child: const SignUpPage()),
            settings: settings);

      // Feature Profile Company
      case CompanyProfileInputPage.pageId:
        return MaterialPageRoute(
            builder: (_) => BlocProvider.value(
                value: _companyProfileBloc,
                child: const CompanyProfileInputPage()));

      // Feature Profile Student
      case StudentProfileInputStep1Page.pageId:
        return MaterialPageRoute(
            builder: (_) => BlocProvider.value(
                value: _studentProfileBloc,
                child: const StudentProfileInputStep1Page()),
            settings: settings);
      case StudentProfileInputStep2Page.pageId:
        return MaterialPageRoute(
            builder: (_) => BlocProvider.value(
                value: _studentProfileBloc,
                child: const StudentProfileInputStep2Page()),
            settings: settings);
      case StudentProfileInputStep3Page.pageId:
        return MaterialPageRoute(
            builder: (_) => BlocProvider.value(
                value: _studentProfileBloc,
                child: const StudentProfileInputStep3Page()),
            settings: settings);
      case WelcomePage.pageId:
        return MaterialPageRoute(builder: (_) => const WelcomePage());

      //Feature Project Company
      case MainTabBarPage.pageId:
        return MaterialPageRoute(
            builder: (_) => MultiBlocProvider(providers: [
                  BlocProvider.value(
                    value: _projectStudentBloc,
                  ),
                  BlocProvider.value(
                    value: _companyProjectBloc,
                  ),
                  BlocProvider.value(
                    value: _dashboardStudentBloc,
                  ),
                ], child: const MainTabBarPage()));
      case CompanyDashboardPage.pageId:
        return MaterialPageRoute(
            builder: (_) => BlocProvider.value(
                value: _companyProjectBloc,
                child: const CompanyDashboardPage()));
      case CompanyProjectDetailPage.pageId:
        return MaterialPageRoute(
            builder: (_) => MultiBlocProvider(providers: [
                  BlocProvider.value(
                    value: _companyProjectDetailBloc,
                  ),
                  BlocProvider.value(
                    value: _companyProposalBloc,
                  ),
                  BlocProvider.value(
                    value: _projectMessageList,
                  ),
                ], child: const CompanyProjectDetailPage()),
            settings: settings);
      case CompanyPostProjectStep1Page.pageId:
        return MaterialPageRoute(
            builder: (_) => BlocProvider.value(
                value: _companyProjectEditBloc,
                child: const CompanyPostProjectStep1Page()),
            settings: settings);
      case CompanyPostProjectStep2Page.pageId:
        return MaterialPageRoute(
            builder: (_) => BlocProvider.value(
                value: _companyProjectBloc,
                child: const CompanyPostProjectStep2Page()),
            settings: settings);
      case CompanyPostProjectStep3Page.pageId:
        return MaterialPageRoute(
            builder: (_) => BlocProvider.value(
                value: _companyProjectBloc,
                child: const CompanyPostProjectStep3Page()),
            settings: settings);
      case CompanyPostProjectStep4Page.pageId:
        return MaterialPageRoute(
            builder: (_) => BlocProvider.value(
                value: _companyProjectBloc,
                child: const CompanyPostProjectStep4Page()),
            settings: settings);

      //Feature Project Student
      case StudentProjectListPage.pageId:
        return MaterialPageRoute(
            builder: (_) => BlocProvider.value(
                value: _projectStudentBloc,
                child: const StudentProjectListPage()));
      case StudentProjectDetailPage.pageId:
        return MaterialPageRoute(
            builder: (_) => BlocProvider.value(
                value: _projectStudentBloc,
                child: const StudentProjectDetailPage()),
            settings: settings);
      case StudentSavedProjectListPage.pageId:
        return MaterialPageRoute(
            builder: (_) => BlocProvider.value(
                value: _projectStudentBloc,
                child: const StudentSavedProjectListPage()));
      case StudentSearchedProjectListPage.pageId:
        return MaterialPageRoute(
            builder: (_) => BlocProvider.value(
                value: _projectStudentBloc,
                child: const StudentSearchedProjectListPage()));
      case StudentSubmitProposalPage.pageId:
        return MaterialPageRoute(
            builder: (_) => BlocProvider.value(
                value: _submitProposalStudent,
                child: const StudentSubmitProposalPage()),
            settings: settings);
      case StudentDashboardPage.pageId:
        return MaterialPageRoute(
            builder: (_) => BlocProvider.value(
                value: _dashboardStudentBloc,
                child: const StudentDashboardPage()));
      case DashboardStudentAcceptPage.pageId:
        return MaterialPageRoute(
            builder: (_) => BlocProvider.value(
                value: _dashboardStudentAcceptProposalBloc,
                child: const DashboardStudentAcceptPage()),
            settings: settings);

      //Feature Message
      case TabMessagePage.pageId:
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                  create: (context) => (MessageBloc(
                      userRepository: UserRepository(),
                      authenticationRepository: _authenticationRepository,
                      messageRepository: MessageRepository())),
                  child: TabMessagePage(),
                ),
            settings: settings);
      case TabMessageDetailPage.pageId:
        return MaterialPageRoute(builder: (_) => BlocProvider(
                  create: (context) => (MessageBloc(
                      userRepository: UserRepository(),
                      authenticationRepository: _authenticationRepository,
                      messageRepository: MessageRepository())),
                  child: const TabMessageDetailPage(),
                ),
            settings: settings);
      case VideoCallPage.pageId:
        return MaterialPageRoute(builder: (_) => const VideoCallPage());

      //Feature Notification
      case NotificationPage.pageId:
        return MaterialPageRoute(builder: (_) => const NotificationPage());

      case SplashPage.pageId:
        return MaterialPageRoute(builder: (_) => const SplashPage());
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
