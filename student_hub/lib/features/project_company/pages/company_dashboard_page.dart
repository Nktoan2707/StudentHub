import 'package:flutter/material.dart';
import 'package:student_hub/features/project_company/pages/company_post_project_step_1_page.dart';
import 'package:student_hub/features/project_company/pages/company_project_detail_page.dart';

import 'package:student_hub/widgets/components/ui_extension.dart';

class CompanyDashboardPage extends StatefulWidget {
  static const String pageId = "/CompanyDashboardPage";

  const CompanyDashboardPage({super.key});

  @override
  State<CompanyDashboardPage> createState() => _CompanyDashboardPageState();
}

class _CompanyDashboardPageState extends State<CompanyDashboardPage> {
  int itemCount = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            children: <Widget>[
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const PrimaryText(title: 'Your projects'),
                  InkCustomButton(
                    title: 'Post a project',
                    onTap: postJobButtonDidTap,
                    height: 30,
                    width: 150,
                  )
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black, width: 2.0),
                  borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Container(
                      width: 100,
                      height: 40,
                      color: Colors.white,
                      child: const Center(child: Text('All projects')),
                    ),
                    Container(
                      width: 150,
                      height: 40,
                      color: Colors.white,
                      child: const Center(child: Text('Archieved projects')),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              ListView.builder(
                shrinkWrap: true,
                itemCount: itemCount,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                       Navigator.of(context).pushNamed(CompanyProjectDetailPage.pageId);
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('Senior frontend developer (Fintech)'),
                            const Spacer(),
                            IconButton(
                              icon: const Icon(Icons.more_horiz),
                              onPressed: () {
                                actionMenuButtonDidTap(index);
                              },
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        RichText(
                          text: const TextSpan(
                            style: TextStyle(color: Colors.black),
                            children: [
                              TextSpan(
                                text: "Students are looking for\n",
                              ),
                              WidgetSpan(
                                child: Padding(
                                  padding: EdgeInsets.only(
                                      right: 5, left: 15, bottom: 5),
                                  child: Icon(Icons.fiber_manual_record, size: 5),
                                ),
                              ),
                              TextSpan(
                                text:
                                    'Clear expectation about your project or deliverables\n',
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('0 Proposals'),
                            Text('8 Messages'),
                            Text('2 Hired'),
                          ],
                        ),
                        const Divider(
                          thickness: 2,
                          color: Colors.black,
                        ),
                      ],
                    ),
                  );
                },
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

  void postJobButtonDidTap() {
    Navigator.of(context).pushNamed(CompanyPostProjectStep1Page.pageId);
  }

  void actionMenuButtonDidTap(int id) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return const SingleChildScrollView(
          child: Wrap(
            children: [
              ListTile(
                leading: Icon(Icons.view_list),
                title: Text('View Proposals'),
              ),
              ListTile(
                leading: Icon(Icons.message),
                title: Text('View messages'),
              ),
              ListTile(
                leading: Icon(Icons.person_2),
                title: Text('View hired'),
              ),
              Divider(color: Colors.black, height: 10, thickness: 1),
              ListTile(
                leading: Icon(Icons.task),
                title: Text('View job posting'),
              ),
              ListTile(
                leading: Icon(Icons.edit),
                title: Text('Edit posting'),
              ),
              ListTile(
                leading: Icon(Icons.remove),
                title: Text('Remove posting'),
              ),
              Divider(color: Colors.black, height: 10, thickness: 1),
              ListTile(
                leading: Icon(Icons.start),
                title: Text('Start working this project'),
              ),
            ],
          ),
        );
      },
    );
  }
}
