import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:student_hub/common/splash_screen.dart';
import 'package:student_hub/data/data_providers/authentication_repository.dart';
import 'package:student_hub/data/data_providers/user_repository.dart';
import 'package:student_hub/features/authentication/bloc/authentication_bloc.dart';
import 'package:student_hub/features/login/pages/home_page.dart';
import 'package:student_hub/router/app_router.dart';
import 'package:student_hub/widgets/pages/splash_page.dart';

import 'features/main_tab_bar_page.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  final AuthenticationRepository _authenticationRepository =
      AuthenticationRepository();

  late final AppRouter _appRouter;
  final _navigatorKey = GlobalKey<NavigatorState>();

  NavigatorState get _navigator => _navigatorKey.currentState!;

  @override
  void initState() {
    super.initState();
    _appRouter = AppRouter(_authenticationRepository);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthenticationBloc(
          authenticationRepository: _authenticationRepository,
          userRepository: UserRepository()),
      child: MaterialApp(
        navigatorKey: _navigatorKey,
        title: "Student Hub",
        theme: ThemeData.from(
          colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromRGBO(32, 63, 129, 1.0),
          ),
        ),
        builder: (context, child) {
          return BlocListener<AuthenticationBloc, AuthenticationState>(
            listener: (_, state) {
              if (state is AuthenticationAuthenticateSuccess) {
                _navigator.pushNamedAndRemoveUntil<void>(
                  MainTabBarPage.pageId,
                  (route) => false,
                );
              } else if (state is AuthenticationAuthenticateFailure) {
                _navigator.pushNamedAndRemoveUntil<void>(
                  MainTabBarPage.pageId,
                  (route) => false,
                );
              }
            },
            child: child,
          );
        },
        initialRoute: SplashPage.pageId,
        onGenerateRoute: _appRouter.onGenerateRoute,
      ),
    );
  }

  @override
  void dispose() {
    _authenticationRepository.dispose();
    _appRouter.dispose();
    super.dispose();
  }
}
