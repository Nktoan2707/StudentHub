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
                  // Proposals tab with ListView
                  ListView.builder(
                    itemCount: 5, // Replace with actual data length
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
                                    width: MediaQuery.sizeOf(context).width / 2 - 32),
                                InkCustomButton(
                                    title: 'Hire',
                                    width: MediaQuery.sizeOf(context).width / 2 - 32)
                              ],
                            ),
                            const Divider(
                              color: Colors.black,
                              height: 50,
                              thickness: 2
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                  Center(child: Text('Detail')), // Detail content
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
}
