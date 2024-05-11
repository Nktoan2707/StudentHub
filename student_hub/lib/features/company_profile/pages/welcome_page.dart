import 'package:flutter/material.dart';
import 'package:student_hub/features/main_tab_bar_page.dart';

import 'package:student_hub/widgets/components/ui_extension.dart';

class WelcomePage extends StatefulWidget {
  static const String pageId = "/WelcomePage";

  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  final _currentIndex = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const TopNavigationBar(),
      body: GestureDetector(
        onTap: () {
          FocusScopeNode currentFocus = FocusScope.of(context);
          if (!currentFocus.hasPrimaryFocus) {
            currentFocus.unfocus();
          }
        },
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 40,
              ),
              Center(
                child: Image.network(
                    'https://i.pinimg.com/originals/f9/64/2a/f9642a97146f7c952c3f929d8e557655.jpg'),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                'Welcome!',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 24, // Chỉnh kích thước phù hợp
                ),
                textAlign: TextAlign.center,
              ),
              const PrimaryText(
                  textAlign: TextAlign.center,
                  title:
                      'Let\'s start with your first project post'),
              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  InkCustomButton(
                    title: 'Get started!',
                    onTap: getStartedButtonDidTap,
                    padding: 10,
                  ),
                ],
              ),
              const SizedBox(
                height: 50,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void getStartedButtonDidTap() {
    Navigator.of(context).pushNamedAndRemoveUntil(
                    MainTabBarPage.pageId, (Route<dynamic> route) => false);

  }
}
