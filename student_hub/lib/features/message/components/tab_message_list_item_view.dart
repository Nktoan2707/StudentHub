import 'package:flutter/material.dart';
import 'package:student_hub/data/models/domain/project.dart';
import 'package:student_hub/features/message/pages/tab_message_detail_page.dart';
import 'package:student_hub/features/project/pages/student_project_detail_page.dart';
import 'package:student_hub/widgets/components/text_custom.dart';
import 'package:student_hub/widgets/components/ui_extension.dart';

class TabMessageListItemView extends StatelessWidget {
  const TabMessageListItemView({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed(TabMessageDetailPage.pageId);
      },
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Image.network(
                          height: 48,
                          width: 48,
                          'https://i.pinimg.com/originals/f9/64/2a/f9642a97146f7c952c3f929d8e557655.jpg'),
                      SizedBox(
                        width: 8,
                      ),
                      Container(
                        width: MediaQuery.sizeOf(context).width - 48 - 60,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                PrimaryText(title: "Luis Pham"),
                                Text("6/6/2024"),
                              ],
                            ),
                            Text("Senior frontend developer (Fintech)"),
                            SizedBox(
                              height: 4,
                            ),
                            Text(
                              "Clear expectation about your project or deliverables",
                              maxLines: 2,
                              softWrap: true,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
