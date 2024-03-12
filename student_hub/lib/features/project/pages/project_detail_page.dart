import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:student_hub/widgets/components/ink_custom_button.dart';
import 'package:student_hub/widgets/components/ui_extension.dart';

class ProjectDetailPage extends StatefulWidget {
  static const String pageId = "/ProjectDetailPage";

  const ProjectDetailPage({super.key});

  @override
  State<ProjectDetailPage> createState() => _ProjectDetailPageState();
}

class _ProjectDetailPageState extends State<ProjectDetailPage>
    with TickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 4, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopNavigationBar(),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(16, 4, 16, 0),
        child: Column(
          children: [
            HeaderText(title: 'Senior Frontend Developer (Fintech)'),
            TabBar(
              controller: _tabController,
              tabs: const <Widget>[
                Tab(text: 'Proposals'), // Proposals
                Tab(text: 'Detail'), // Detail
                Tab(text: 'Message'), // Message
                Tab(text: 'Hired'), // Hired
              ],
            ),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  ListView.builder(
                    itemCount: 5,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.fromLTRB(0, 4, 0, 0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ListTile(
                              contentPadding: EdgeInsets.zero,
                              title: Text('Hung Le'),
                              subtitle: Text('4th year student'),
                              leading: Image.network(
                                  'https://i.pinimg.com/originals/f9/64/2a/f9642a97146f7c952c3f929d8e557655.jpg'),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Full stack Engineer'),
                                Text('Excellent')
                              ],
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            Text(
                                'I have gone through your project and it seem like a great project. I will commit for your project...'),
                            SizedBox(
                              height: 16,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                InkCustomButton(
                                  title: 'Message',
                                  width:
                                      MediaQuery.sizeOf(context).width / 2 - 32,
                                  onTap: () {
                                    messageButtonDidTap(index);
                                  },
                                ),
                                InkCustomButton(
                                  title: 'Hire',
                                  width:
                                      MediaQuery.sizeOf(context).width / 2 - 32,
                                  onTap: () {
                                    sentHiredButtonDidTap(index);
                                  },
                                )
                              ],
                            ),
                            const Divider(
                                color: Colors.black, height: 50, thickness: 2),
                          ],
                        ),
                      );
                    },
                  ),
                  Column(
                    children: [
                      const Divider(
                          color: Colors.black, height: 50, thickness: 2),
                      PrimaryText(
                          title:
                              "Students are looking for\n\t - Clear expectation about your project or deliverables\n\t - The skills required for your project\n\t - Detail about your project"),
                      const Divider(
                          color: Colors.black, height: 50, thickness: 2),
                      Row(
                        children: [
                          Icon(
                            Icons.lock_clock,
                            size: 40,
                          ),
                          SizedBox(
                            width: 12,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Project scope:',
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14)),
                              Text(
                                '\t- 3 to 6 month',
                                textAlign: TextAlign.left,
                              )
                            ],
                          )
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.people,
                            size: 40,
                          ),
                          SizedBox(
                            width: 12,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Student required:',
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 14),
                              ),
                              Text('\t- 6 students', textAlign: TextAlign.left)
                            ],
                          )
                        ],
                      ),
                      Expanded(
                          child: Align(
                              alignment: Alignment.bottomRight,
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(0, 0, 0, 24),
                                child: InkCustomButton(
                                  title: 'Post job',
                                  height: 40,
                                  width: 120,
                                ),
                              ))),
                    ],
                  ), // Detail content
                  Center(child: Text('Message')), // Message content
                  Center(child: Text('Hired')), // Hired content
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void sentHiredButtonDidTap(int id) {
    showDialog(
      context: context,
      builder: (context) => SimpleDialog(
        title: const HeaderText(title: 'Hired offer'),
        contentPadding: const EdgeInsets.all(20.0),
        children: [
          const Text(
              textAlign: TextAlign.left,
              'Do you really want to send hired offer for student to do this project?'),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('Cancel')),
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('Send')),
            ],
          )
        ],
      ),
    );
  }

  void messageButtonDidTap(int id) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return SingleChildScrollView(
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
              const Divider(color: Colors.black, height: 10, thickness: 1),
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
              const Divider(color: Colors.black, height: 10, thickness: 1),
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
