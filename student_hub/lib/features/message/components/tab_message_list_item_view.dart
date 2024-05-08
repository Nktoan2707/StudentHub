// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

import 'package:student_hub/data/models/domain/message_detail.dart';
import 'package:student_hub/features/message/pages/tab_message_detail_page.dart';
import 'package:student_hub/widgets/components/text_custom.dart';
import 'package:student_hub/widgets/components/ui_extension.dart';

class TabMessageListItemView extends StatelessWidget {
  MessageContent messageContent;
  TabMessageListItemView({
    Key? key,
    required this.messageContent,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    final String date = formatter.format(messageContent.createdAt!);
    String prefix =
        messageContent.messageType == BubbleMessageType.sender ? "You: " : "";
    String content = prefix + messageContent.content!;
    String titleName = messageContent.me!.id == messageContent.sender!.id
        ? messageContent.receiver!.fullname
        : messageContent.sender!.fullname;
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed(TabMessageDetailPage.pageId, arguments: {"messageInit" : messageContent});
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
                          'https://cdn3.iconfinder.com/data/icons/incognito-avatars/154/incognito-face-user-man-avatar-512.png'),
                      const SizedBox(
                        width: 8,
                      ),
                      SizedBox(
                        width: MediaQuery.sizeOf(context).width - 48 - 60,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  width: 160,
                                  height: 30,
                                  child: Text(
                                    titleName,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 24),
                                      
                                  ),
                                ),
                                Text(date),
                              ],
                            ),
                            Text(
                              content,
                              maxLines: 2,
                              softWrap: true,
                            )
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
