import 'package:flutter/material.dart';
import 'package:student_hub/features/message/pages/tab_message_page.dart';
import 'package:student_hub/features/project/pages/dashboard_main_page.dart';
import 'package:student_hub/features/project/pages/project_detail_page.dart';
import 'package:student_hub/features/project/pages/student_project_detail_page.dart';
import 'package:student_hub/features/project/pages/student_project_list_page.dart';
import 'package:student_hub/features/project/pages/student_searched_project_list_page.dart';
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
      initialRoute: TabMessagePage.pageId,
      onGenerateRoute: _appRouter.onGenerateRoute,
    );
  }

  @override
  void dispose() {
    _appRouter.dispose();
    super.dispose();
  }
}

