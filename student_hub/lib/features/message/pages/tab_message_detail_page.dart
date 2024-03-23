import 'package:flutter/material.dart';
import 'package:student_hub/data/models/domain/message_detail.dart';
import 'package:student_hub/features/message/components/message_buble.dart';

import '../components/Avatar.dart';
import 'package:intl/intl.dart';

class TabMessageDetailPage extends StatefulWidget {
  static const String pageId = "/TabMessageDetailPage";

  @override
  State<TabMessageDetailPage> createState() => _TabMessageDetailPageState();
}

class _TabMessageDetailPageState extends State<TabMessageDetailPage> {
  final messageController = TextEditingController();
  final List messages = [
    MessageDetail(
        senderID: '12',
        senderName: 'Long đẹp trai',
        message: 'Hello bạn',
        messageType: BubbleMessageType.receiver,
        date: DateTime.now().subtract(const Duration(days: 3))),
    MessageDetail(
        senderID: '14',
        senderName: 'Hai pham',
        message: 'chào',
        messageType: BubbleMessageType.sender,
        date: DateTime.now().subtract(const Duration(days: 2)))
  ];

  @override
  void dispose() {
    messageController.dispose();
    super.dispose();
  }

  void _sendMessage() async {
    setState(() {
      final message = MessageDetail(
          senderID: '14',
          senderName: 'Hai pham',
          message: messageController.text,
          messageType: BubbleMessageType.sender,
          date: DateTime.now());

      messageController.clear();
      messages.add(message);
    });
  }

  @override
  Widget build(BuildContext context) {
    final viewInsets = MediaQuery.viewInsetsOf(context);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Column(
          children: [
            Avatar(
              imageUrl:
                  'https://i.pinimg.com/originals/f9/64/2a/f9642a97146f7c952c3f929d8e557655.jpg',
              radius: 18,
            ),
            // const SizedBox(height: 2.0),
            Text(
              "Long đẹp trai",
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.more_vert),
          ),
          const SizedBox(width: 8.0),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(
            left: 16.0,
            right: 16.0,
            top: 8.0,
            bottom: (viewInsets.bottom > 0) ? 8.0 : 0.0,
          ),
          child: Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: messages.length,
                  itemBuilder: (context, index) {
                    final message = messages[index];

                    var showImage = false;
                    if (messages.length == 1) {
                      showImage = true;
                    } else {
                      if (index == 0) {
                        showImage = true;
                      } else {
                        showImage =
                            messages[index - 1].senderID != message.senderID;

                        if (!showImage) {
                          DateTime lastMessageTime = messages[index - 1].date;
                          DateTime curMessageTime = message.date;
                          print(lastMessageTime.millisecondsSinceEpoch);
                          print(curMessageTime.millisecondsSinceEpoch);
                          print(
                              'dasdawe ${lastMessageTime.millisecondsSinceEpoch - curMessageTime.millisecondsSinceEpoch}');
                          showImage = curMessageTime.millisecondsSinceEpoch -
                                  lastMessageTime.millisecondsSinceEpoch >=
                              86400000;
                        }
                      }
                    }

                    return Column(
                      mainAxisAlignment:
                          (message.messageType == BubbleMessageType.receiver)
                              ? MainAxisAlignment.start
                              : MainAxisAlignment.end,
                      children: [
                        if (showImage &&
                            message.messageType == BubbleMessageType.receiver)
                          Row(
                            mainAxisAlignment: (message.messageType ==
                                    BubbleMessageType.receiver)
                                ? MainAxisAlignment.start
                                : MainAxisAlignment.end,
                            children: [
                              Avatar(
                                imageUrl:
                                    'https://i.pinimg.com/originals/f9/64/2a/f9642a97146f7c952c3f929d8e557655.jpg',
                                radius: 12,
                              ),
                              SizedBox(width: 8),
                              Text(message.senderName.length > 20
                                  ? message.senderName.substring(0, 20) + '...'
                                  : message.senderName),
                              SizedBox(width: 16),
                              Text(DateFormat('hh:mm:ss dd/MM/yyyy')
                                  .format(message.date)),
                            ],
                          ),

                        if (showImage &&
                            message.messageType == BubbleMessageType.sender)
                          Row(
                            mainAxisAlignment: (message.messageType ==
                                    BubbleMessageType.receiver)
                                ? MainAxisAlignment.start
                                : MainAxisAlignment.end,
                            children: [
                              Text(DateFormat('hh:mm:ss dd/MM/yyyy')
                                  .format(message.date)),
                              SizedBox(width: 16),
                              Text(message.senderName.length > 20
                                  ? message.senderName.substring(0, 20) + '...'
                                  : message.senderName),
                              SizedBox(width: 8),
                              Avatar(
                                imageUrl:
                                    'https://i.pinimg.com/originals/f9/64/2a/f9642a97146f7c952c3f929d8e557655.jpg',
                                radius: 12,
                              ),
                            ],
                          ),
                        MessageBubble(messageDetail: message),
                      ],
                    );
                  },
                ),
              ),
              Row(
                children: [
                  IconButton(
                    onPressed: () {
                      // TODO: Send an image
                    },
                    icon: Icon(Icons.attach_file),
                  ),
                  Expanded(
                    child: TextFormField(
                      controller: messageController,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Theme.of(context)
                            .colorScheme
                            .primary
                            .withAlpha(100),
                        hintText: 'Type a message',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16.0),
                          borderSide: BorderSide.none,
                        ),
                        suffixIcon: IconButton(
                          onPressed: () {
                            _sendMessage();
                          },
                          icon: Icon(Icons.send),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
