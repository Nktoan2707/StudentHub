

import 'package:flutter/material.dart';

class AppRouter {
  // final HomeBloc _homeBloc = HomeBloc(taskRepository: TaskRepository());

  Route? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      // case SplashPage.pageId:
      //   return MaterialPageRoute(builder: (_) => const SplashPage());
      //
      // case TaskListPage.pageId:
      //   return MaterialPageRoute(
      //       builder: (_) => BlocProvider.value(
      //             value: _homeBloc,
      //             child: TaskListPage(),
      //           ));
      //
      // case HomePage.pageId:
      //   return MaterialPageRoute(
      //       builder: (_) =>
      //           BlocProvider.value(value: _homeBloc, child: const HomePage()));
      //
      // case AddTaskPage.pageId:
      //   return MaterialPageRoute(
      //       builder: (_) => BlocProvider.value(
      //           value: _homeBloc, child: const AddTaskPage()));
      //
      // case SearchTaskPage.pageId:
      //   return MaterialPageRoute(
      //       builder: (_) => BlocProvider.value(
      //           value: _homeBloc, child: const SearchTaskPage()));

      default:
        return null;
    }
  }

  void dispose() {
    // _homeBloc.close();
  }
}
