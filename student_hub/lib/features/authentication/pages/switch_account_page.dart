import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:student_hub/common/enums.dart';
import 'package:student_hub/features/authentication/bloc/authentication_bloc.dart';
import 'package:student_hub/features/company_profile/pages/company_profile_input_page.dart';
import 'package:student_hub/features/main_tab_bar_page.dart';
import 'package:student_hub/features/profile_student/bloc/student_profile_bloc.dart';
import 'package:student_hub/features/profile_student/pages/student_profile_input_step_1_page.dart';
import 'package:student_hub/widgets/components/themeModel.dart';

import '../../company_profile/bloc/company_profile_bloc.dart';

class SwitchAccountPage extends StatefulWidget {
  static const String pageId = "/SwitchAccountPage";

  const SwitchAccountPage({super.key});

  @override
  State<SwitchAccountPage> createState() => _SwitchAccountPageState();

  static _SwitchAccountPageState? of(BuildContext context) =>
      context.findAncestorStateOfType<_SwitchAccountPageState>();
}

class _SwitchAccountPageState extends State<SwitchAccountPage> {
  bool showSettings = false;
  Brightness brightness = Brightness.light;

  void updateBrightness(Brightness newBrightness) {
    setState(() {
      brightness = newBrightness;
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text(
          'StudentHub',
          style: TextStyle(fontSize: 25, color: Colors.black),
        ),
        centerTitle: false,
        backgroundColor: Colors.grey,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (context, state) {
          if (state is AuthenticationSwitchProfileFailure) {
            return Center(
              child: Text(
                "Logging Out...",
                style: TextStyle(fontSize: 30),
              ),
            );
          }

          return SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: BlocBuilder<AuthenticationBloc, AuthenticationState>(
              builder: (context, state) {
                if (state is AuthenticationSwitchProfileSuccess) {
                  return Center(
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                    ),
                  );
                }

                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _buildSwitchProfile(),
                    const Divider(
                      thickness: 3,
                      height: 10,
                    ),

                    // Vertical List
                    BlocBuilder<AuthenticationBloc, AuthenticationState>(
                      builder: (context, state) {
                        return ListView(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          children: [
                            ListTile(
                              leading: const Icon(Icons.account_circle),
                              title: const Text("Profile"),
                              onTap: () {
                                if (state
                                    is AuthenticationAuthenticateSuccess) {
                                  switch (state.userRole) {
                                    case UserRole.student:
                                      context
                                          .read<StudentProfileBloc>()
                                          .add(StudentProfileFetched());
                                      Navigator.of(context)
                                          .pushReplacementNamed(
                                              StudentProfileInputStep1Page
                                                  .pageId);
                                      break;
                                    case UserRole.company:
                                      context
                                          .read<CompanyProfileBloc>()
                                          .add(CompanyProfileResetState());
                                      Navigator.of(context)
                                          .pushReplacementNamed(
                                              CompanyProfileInputPage.pageId);
                                      break;
                                  }
                                }
                              },
                            ),
                            ListTile(
                              leading: const Icon(Icons.settings),
                              title: const Text("Setting"),
                              onTap: () {
                                setState(() {
                                  showSettings = !showSettings; 
                                });
                              },
                            ),
                            if (showSettings) SettingsWidget(),
                            ListTile(
                              leading: const Icon(Icons.logout),
                              title: const Text("Log out"),
                              onTap: () {
                                context
                                    .read<AuthenticationBloc>()
                                    .add(AuthenticationLoggedOut());
                              },
                            ),
                          ],
                        );
                      },
                    ),
                  ],
                );
              },
            ),
          );
        },
      ),
    );
  }

  Widget _buildSwitchProfile() {
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
      builder: (context, state) {
        if (state is AuthenticationAuthenticateSuccess) {
          UserRole currentUserRole = state.userRole;

          List<UserRole> switchRoleFieldItems = UserRole.values.toList()
            ..remove(currentUserRole);

          return Column(
            children: [
              Ink(
                child: ListTile(
                  leading: const Icon(Icons.account_box),
                  title: Text(state.user.fullname),
                  subtitle: Text(
                    toBeginningOfSentenceCase(currentUserRole.name),
                  ),
                  onTap: () {},
                ),
              ),
              const Divider(
                thickness: 3,
                height: 10,
              ),
              ListView.separated(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                padding: EdgeInsets.zero,
                itemCount: switchRoleFieldItems.length,
                itemBuilder: (context, index) {
                  return Ink(
                    child: ListTile(
                      leading: const Icon(Icons.switch_account),
                      title: Text(state.user.fullname),
                      subtitle: Text(
                        toBeginningOfSentenceCase(
                            switchRoleFieldItems[index].name),
                      ),
                      onTap: () {
                        setState(() {
                          context.read<AuthenticationBloc>().add(
                              AuthenticationProfileSwitched(
                                  userRole: switchRoleFieldItems[index]));
                        });
                      },
                    ),
                  );
                },
                separatorBuilder: (context, index) {
                  return const Divider(
                    thickness: 3,
                    height: 10,
                  );
                },
              ),
            ],
          );
        }

        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}

class SettingsWidget extends StatefulWidget {
  const SettingsWidget({super.key});

  @override
  State<SettingsWidget> createState() => _SettingsWidgetState();
}

class _SettingsWidgetState extends State<SettingsWidget> {
  String currentLanguage = 'English';

  @override
  Widget build(BuildContext context) {
    var theme = Provider.of<ThemeModel>(context, listen: false);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SwitchListTile(
          title: Text('Dark Mode'),
          value: theme.isDark,
          onChanged: (bool value) {
            theme.toggleTheme();
          },
        ),
        ListTile(
          title: Text('Language'),
          trailing: DropdownButton<String>(
            value: currentLanguage, 
            onChanged: (String? newValue) {
              setState(() {
                currentLanguage = newValue!;
              });
            },
            items: <String>['English', 'Vietnamese']
                .map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  void _applyDarkMode(bool value) {
    final Brightness newBrightness = value ? Brightness.dark : Brightness.light;
    SwitchAccountPage.of(context)!.updateBrightness(newBrightness);
  }
}
