import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:student_hub/common/enums.dart';
import 'package:student_hub/data/models/domain/project.dart';
import 'package:student_hub/features/project_company/bloc/company_project_bloc.dart';
import 'package:student_hub/features/project_company/bloc/company_project_event.dart';
import 'package:student_hub/features/project_company/bloc/company_project_state.dart';
import 'package:student_hub/widgets/components/ui_extension.dart';
import 'package:student_hub/widgets/components/top_navigation_bar.dart';

import 'company_post_project_step_2_page.dart';

class CompanyPostProjectStep1Page extends StatefulWidget {
  static const String pageId = "/CompanyPostProjectStep1Page";

  const CompanyPostProjectStep1Page({super.key});

  @override
  State<CompanyPostProjectStep1Page> createState() =>
      _CompanyPostProjectStep1PageState();
}

class _CompanyPostProjectStep1PageState
    extends State<CompanyPostProjectStep1Page> {
  Project postProject = Project(
      projectId: 0,
      createdAt: "",
      updatedAt: null,
      deletedAt: null,
      companyId: "",
      projectScopeFlag: ProjectScopeFlag.LessThanOneMonth,
      title: "",
      description: "",
      numberOfStudents: 0,
      typeFlag: 0,
      countProposals: 0,
      isFavorite: false,
      countHired: 0,
      countMessages: 0);
  bool isFirstLoad = true;

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic>? projectInfo =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    int projectId = 0;
    // ignore: unrelated_type_equality_checks
    if (projectInfo != null) {
      projectId = projectInfo!['projectId'];
    }

    if (isFirstLoad && projectId != 0) {
      context
          .read<CompanyProjectBloc>()
          .add(CompanyProjectGetDetail(projectId: projectId));
      isFirstLoad = false;
    }

    return BlocBuilder<CompanyProjectBloc, CompanyProjectState>(
      builder: (context, state) {
        if (projectId != 0) {
          if (state is CompanyProjectDetailFailure) {
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
                body: const Center(
                  child: Text(
                    "Error orcur. Please come back later",
                    textAlign: TextAlign.center,
                  ),
                ));
          }

          if (state is! CompanyProjectDetailSuccess) {
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
                body: Center(
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                  ),
                ));
          }
          postProject = state.project;
        }

        return Scaffold(
          appBar: const TopNavigationBar(),
          body: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                const SizedBox(
                  height: 40,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    RichText(
                      text: const TextSpan(
                        style: TextStyle(color: Colors.black),
                        children: [
                          TextSpan(
                            text: "1/4   Let's start with a strong title",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                        "This helps your post stand out to the right students. It's the first thing they'll see, so make it impressive!"),
                    SizedBox(height: 10,),
                    _title(
                      initialText: postProject.title,
                      onChanged: (p0) {
                        postProject.title = p0;
                      },
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    RichText(
                      text: const TextSpan(
                        style: TextStyle(color: Colors.black),
                        children: [
                          TextSpan(
                            text: "Example titles",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    RichText(
                      text: const TextSpan(
                        style: TextStyle(color: Colors.black),
                        children: [
                          WidgetSpan(
                            child: Padding(
                              padding: EdgeInsets.only(right: 5, bottom: 5),
                              child: Icon(Icons.fiber_manual_record, size: 5),
                            ),
                          ),
                          TextSpan(
                            text:
                                'Build responsive WordPress site with booking/payment functionality\n',
                          ),
                          WidgetSpan(
                            child: Padding(
                              padding: EdgeInsets.only(right: 5, bottom: 5),
                              child: Icon(Icons.fiber_manual_record, size: 5),
                            ),
                          ),
                          TextSpan(
                            text:
                                'Facebook ad specialist need for product launch\n',
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    NextScope(project: postProject),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _title extends StatefulWidget {
  const _title({required this.onChanged, required this.initialText});

  final String initialText;
  final Function(String) onChanged;

  @override
  State<_title> createState() => _titleState();
}

class _titleState extends State<_title> {
  TextEditingController textController = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    textController.text = widget.initialText;
  }
  Widget build(BuildContext context) {
    return TextField(
      controller: textController,
      key: const Key('signup_fullnameInput_textField'),
      onChanged: (title) {
        widget.onChanged(title);
      },
      decoration: InputDecoration(
        labelText: "write a title for jour post",
        errorText: false ? 'invalid title' : null,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}

class NextScope extends StatefulWidget {
  NextScope({super.key, required this.project});

  Project project;
  @override
  State<NextScope> createState() => _NextScopeState();
}

class _NextScopeState extends State<NextScope> {
  @override
  Widget build(BuildContext context) {
    return false
        ? const CircularProgressIndicator()
        : ElevatedButton(
            key: const Key('postProject_continue_raisedButton'),
            style: ElevatedButton.styleFrom(
              elevation: 5,
              shadowColor: Colors.black,
              backgroundColor: Colors.white,
              foregroundColor: Colors.black,
              minimumSize: const Size.fromHeight(30),
              shape: const RoundedRectangleBorder(
                side: BorderSide(width: 2),
              ),
            ),
            onPressed: true
                ? () {
                    print(widget.project.title);
                    if (widget.project.title.isEmpty) {
                      ScaffoldMessenger.of(context)
                        ..hideCurrentSnackBar()
                        ..showSnackBar(
                          const SnackBar(
                            content: Text('Please fill in title'),
                            duration: Duration(seconds: 1),
                          ),
                        );
                    } else {
                      print(widget.project.toJson());
                      Navigator.of(context).pushNamed(
                          CompanyPostProjectStep2Page.pageId,
                          arguments: widget.project);
                    }
                  }
                : null,
            child: const Text('Next Scope'),
          );
  }
}
