import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cupertino_datetime_picker/flutter_cupertino_datetime_picker.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:student_hub/data/models/domain/message_detail.dart';
import 'package:student_hub/data/models/domain/schedule_detail.dart';
import 'package:student_hub/data/models/domain/user.dart';
import 'package:student_hub/features/message/bloc/message_bloc.dart';
import 'package:student_hub/features/message/components/message_buble.dart';
import 'package:student_hub/widgets/components/ui_extension.dart';

import '../components/Avatar.dart';
import 'package:intl/intl.dart';

class TabMessageDetailPage extends StatefulWidget {
  static const String pageId = "/TabMessageDetailPage";

  const TabMessageDetailPage({super.key});

  @override
  State<TabMessageDetailPage> createState() => _TabMessageDetailPageState();
}

class _TabMessageDetailPageState extends State<TabMessageDetailPage> {
  Timer? timer;
  late MessageContent initMessageContent ;
  final messageController = TextEditingController();
  final PanelController panelController = PanelController();

  // final List messages = [
  //   MessageDetail(
  //       senderID: '12',
  //       senderName: 'Long đẹp trai',
  //       message: 'Hello bạn',
  //       messageType: BubbleMessageType.receiver,
  //       date: DateTime.now().subtract(const Duration(days: 3))),
  //   MessageDetail(
  //       senderID: '14',
  //       senderName: 'Hai pham',
  //       message: 'chào',
  //       messageType: BubbleMessageType.sender,
  //       date: DateTime.now().subtract(const Duration(days: 2))),
  //   ScheduleDetail(
  //     title: 'Catch up meeting',
  //     senderID: '14',
  //     duration: '60 minutes',
  //     senderName: 'Hai pham',
  //     startTime: DateTime.now().add(const Duration(days: 3)),
  //     endTime: DateTime.now().add(const Duration(days: 4)),
  //     status: ScheduleDetailStatus.progressing,
  //     messageType: BubbleMessageType.sender,
  //     date: DateTime.now().subtract(const Duration(days: 1)),
  //   )
  // ];

  List messages = [];
  late User chatUser;

  @override
  void initState() {
    timer = Timer.periodic(Duration(seconds: 1), (Timer t) {
      context.read<MessageBloc>().add(MessageGetListOfUserEvent(
          projectId: initMessageContent.project!.projectId!,
          userId: chatUser.id));
    });
    super.initState();
  }

  @override
  void dispose() {
    timer?.cancel();
    messageController.dispose();
    super.dispose();
  }

  void _sendMessage() async {
    setState(() {
      // final message = MessageContent(
      //     senderID: '14',
      //     senderName: 'Hai pham',
      //     message: messageController.text,
      //     messageType: BubbleMessageType.sender,
      //     date: DateTime.now());

      messageController.clear();
      // messages.add(message);
    });
  }

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> messageInfo =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
    initMessageContent = messageInfo['messageInit'];
  
    chatUser = initMessageContent.me!.id == initMessageContent.sender!.id
        ? initMessageContent.receiver!
        : initMessageContent.sender!;

    final panelHeightOpen = MediaQuery.of(context).size.height * 0.8;
    final panelHeightClosed = MediaQuery.of(context).size.height * 0.0;
    final viewInsets = MediaQuery.viewInsetsOf(context);
    String titleName = chatUser.fullname;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Column(
          children: [
            const Avatar(
              imageUrl:
                  'https://cdn3.iconfinder.com/data/icons/incognito-avatars/154/incognito-face-user-man-avatar-512.png',
              radius: 18,
            ),
            // const SizedBox(height: 2.0),
            Text(
              titleName,
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {
              settingButtonDidTap();
            },
            icon: const Icon(Icons.more_vert),
          ),
          const SizedBox(width: 8.0),
        ],
      ),
      body: BlocBuilder<MessageBloc, MessageState>(
        builder: (context, state) {
          if (state is MessageProjectListFetchSuccess) {
            messages = state.listMessage;
          }

          return SlidingUpPanel(
            backdropEnabled: true,
            isDraggable: false,
            minHeight: panelHeightClosed,
            maxHeight: panelHeightOpen,
            parallaxEnabled: false,
            parallaxOffset: 0.5,
            renderPanelSheet: false,
            controller: panelController,
            panelBuilder: (scrollController) => _ScheduleFloatingPanel(
              panelController: panelController,
              messages: messages,
            ),
            collapsed: null,
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
                    if (state is! MessageProjectListFetchSuccess)
                      Expanded(child: Center(child: const CircularProgressIndicator())),
                    if (state is MessageProjectListFetchSuccess)
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
                                showImage = messages[index - 1].sender!.id !=
                                    message.sender!.id;

                                if (!showImage) {
                                  DateTime lastMessageTime =
                                      messages[index - 1].createdAt!;
                                  DateTime curMessageTime = message.createdAt!;
                                  showImage =
                                      curMessageTime.millisecondsSinceEpoch -
                                              lastMessageTime
                                                  .millisecondsSinceEpoch >=
                                          86400000;
                                }
                              }

                              if (message is MessageContent) {
                                return Column(
                                  mainAxisAlignment: (message.messageType ==
                                          BubbleMessageType.receiver)
                                      ? MainAxisAlignment.start
                                      : MainAxisAlignment.end,
                                  children: [
                                    if (showImage &&
                                        message.messageType ==
                                            BubbleMessageType.receiver)
                                      Row(
                                        mainAxisAlignment:
                                            (message.messageType ==
                                                    BubbleMessageType.receiver)
                                                ? MainAxisAlignment.start
                                                : MainAxisAlignment.end,
                                        children: [
                                          const Avatar(
                                            imageUrl:
                                                'https://cdn3.iconfinder.com/data/icons/incognito-avatars/154/incognito-face-user-man-avatar-512.png',
                                            radius: 12,
                                          ),
                                          const SizedBox(width: 8),
                                          Text(message.sender!.fullname.length >
                                                  20
                                              ? '${message.sender!.fullname.substring(0, 20)}...'
                                              : message.sender!.fullname),
                                          const SizedBox(width: 16),
                                          Text(DateFormat('hh:mm:ss dd/MM/yyyy')
                                              .format(message.createdAt!)),
                                        ],
                                      ),
                                    if (showImage &&
                                        message.messageType ==
                                            BubbleMessageType.sender)
                                      Row(
                                        mainAxisAlignment:
                                            (message.messageType ==
                                                    BubbleMessageType.receiver)
                                                ? MainAxisAlignment.start
                                                : MainAxisAlignment.end,
                                        children: [
                                          Text(DateFormat('hh:mm:ss dd/MM/yyyy')
                                              .format(message.createdAt!)),
                                          const SizedBox(width: 16),
                                          Text(message.sender!.fullname.length >
                                                  20
                                              ? '${message.sender!.fullname.substring(0, 20)}...'
                                              : message.sender!.fullname),
                                          const SizedBox(width: 8),
                                          const Avatar(
                                            imageUrl:
                                                'https://cdn3.iconfinder.com/data/icons/incognito-avatars/154/incognito-face-user-man-avatar-512.png',
                                            radius: 12,
                                          ),
                                        ],
                                      ),
                                    MessageBubble(messageDetail: message),
                                  ],
                                );
                              }

                              if (message is ScheduleDetail) {
                                return Column(
                                  mainAxisAlignment: (message.messageType ==
                                          BubbleMessageType.receiver)
                                      ? MainAxisAlignment.start
                                      : MainAxisAlignment.end,
                                  children: [
                                    if (showImage &&
                                        message.messageType ==
                                            BubbleMessageType.receiver)
                                      Row(
                                        mainAxisAlignment:
                                            (message.messageType ==
                                                    BubbleMessageType.receiver)
                                                ? MainAxisAlignment.start
                                                : MainAxisAlignment.end,
                                        children: [
                                          const Avatar(
                                            imageUrl:
                                                'https://cdn3.iconfinder.com/data/icons/incognito-avatars/154/incognito-face-user-man-avatar-512.png',
                                            radius: 12,
                                          ),
                                          const SizedBox(width: 8),
                                          // Text(message.sender!.fullname.length > 20
                                          //     ? '${message.sender!.fullname.substring(0, 20)}...'
                                          //     : message.sender!.fullname),
                                          const SizedBox(width: 16),
                                          // Text(DateFormat('hh:mm:ss dd/MM/yyyy')
                                          //     .format(message.createdAt!)),
                                        ],
                                      ),
                                    if (showImage &&
                                        message.messageType ==
                                            BubbleMessageType.sender)
                                      Row(
                                        mainAxisAlignment:
                                            (message.messageType ==
                                                    BubbleMessageType.receiver)
                                                ? MainAxisAlignment.start
                                                : MainAxisAlignment.end,
                                        children: [
                                          // Text(DateFormat('hh:mm:ss dd/MM/yyyy')
                                          //     .format(message.createdAt!)),
                                          const SizedBox(width: 16),
                                          // Text(message.sender!.fullname.length >
                                          //         20
                                          //     ? '${message.sender!.fullname.substring(0, 20)}...'
                                          //     : message.sender!.fullname),
                                          const SizedBox(width: 8),
                                          const Avatar(
                                            imageUrl:
                                                'https://cdn3.iconfinder.com/data/icons/incognito-avatars/154/incognito-face-user-man-avatar-512.png',
                                            radius: 12,
                                          ),
                                        ],
                                      ),
                                    MessageSchedule(scheduleDetail: message),
                                  ],
                                );
                              }
                            }
                            return null;
                          },
                        ),
                      ),
                    SizedBox(
                      height: 100,
                      child: Row(
                        children: [
                          IconButton(
                            onPressed: () {
                              // TODO: Send an image
                            },
                            icon: const Icon(Icons.attach_file),
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
                                  icon: const Icon(Icons.send),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 100,
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  void settingButtonDidTap() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return SingleChildScrollView(
          child: Wrap(
            children: [
              ListTile(
                leading: const Icon(Icons.view_list),
                title: const Text('Schedule on interview'),
                onTap: () {
                  Navigator.pop(context);
                  scheduleButtonDidTap();
                },
              ),
              ListTile(
                leading: const Icon(Icons.cancel),
                title: const Text('Cancel'),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void scheduleButtonDidTap() {
    panelController.open();
  }
}

class _ScheduleFloatingPanel extends StatefulWidget {
  final PanelController panelController;

  const _ScheduleFloatingPanel(
      {required this.panelController, required this.messages});
  final List messages;
  @override
  State<_ScheduleFloatingPanel> createState() => _ScheduleFloatingPanelState();
}

class _ScheduleFloatingPanelState extends State<_ScheduleFloatingPanel> {
  TextEditingController titleController = TextEditingController();
  TextEditingController startTimeController = TextEditingController();
  TextEditingController endTimeController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      elevation: 0,
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            IconButton(
              padding: EdgeInsets.zero,
              onPressed: () {
                widget.panelController.close();
              },
              icon: const FaIcon(FontAwesomeIcons.circleXmark),
              constraints: const BoxConstraints(),
            ),
            const SizedBox(
              height: 10,
            ),
            const HeaderText(title: 'Schedule a video call interview'),
            const Divider(
              thickness: 3,
              height: 40,
            ),
            const PrimaryText(
              title: "Title",
            ),
            const SizedBox(
              height: 12,
            ),
            TextField(
              style: const TextStyle(color: Colors.black),
              cursorColor: Colors.black,
              decoration: const InputDecoration(
                constraints: BoxConstraints(maxHeight: 30),
                hintStyle: TextStyle(color: Colors.black),
                border: OutlineInputBorder(),
              ),
              controller: titleController,
            ),
            const SizedBox(
              height: 18,
            ),
            const PrimaryText(
              title: "Start time",
            ),
            const SizedBox(
              height: 12,
            ),
            Row(
              children: [
                TextField(
                  style: const TextStyle(color: Colors.black),
                  cursorColor: Colors.black,
                  decoration: const InputDecoration(
                    constraints: BoxConstraints(maxHeight: 30, maxWidth: 200),
                    hintStyle: TextStyle(color: Colors.black),
                    border: OutlineInputBorder(),
                  ),
                  controller: startTimeController,
                ),
                IconButton(
                  onPressed: () {
                    dateTimePickerWidget(context, startTimeController);
                  },
                  icon: const Icon(Icons.calendar_month),
                ),
              ],
            ),
            const SizedBox(
              height: 18,
            ),
            const PrimaryText(
              title: "End time",
            ),
            const SizedBox(
              height: 12,
            ),
            Row(
              children: [
                TextField(
                  style: const TextStyle(color: Colors.black),
                  cursorColor: Colors.black,
                  decoration: const InputDecoration(
                    constraints: BoxConstraints(maxHeight: 30, maxWidth: 200),
                    hintStyle: TextStyle(color: Colors.black),
                    border: OutlineInputBorder(),
                  ),
                  controller: endTimeController,
                ),
                IconButton(
                  onPressed: () {
                    dateTimePickerWidget(context, endTimeController);
                  },
                  icon: const Icon(Icons.calendar_month),
                ),
              ],
            ),
            const Text(
              "Duration: 60 minutes",
            ),
            const SizedBox(
              height: 36,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InkCustomButton(
                  title: "Cancel",
                  padding: 4,
                  width: MediaQuery.of(context).size.width * 0.4,
                ),
                InkCustomButton(
                  title: "Send Invite",
                  padding: 4,
                  width: MediaQuery.of(context).size.width * 0.4,
                  onTap: () {},
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  dateTimePickerWidget(
      BuildContext context, TextEditingController textController) {
    return DatePicker.showDatePicker(
      context,
      dateFormat: 'dd MMMM yyyy HH:mm',
      initialDateTime: DateTime.now(),
      minDateTime: DateTime(2000),
      maxDateTime: DateTime(3000),
      onMonthChangeStartWithFirstDate: true,
      onConfirm: (dateTime, List<int> index) {
        setState(() {
          textController.text =
              DateFormat('hh:mm:ss dd/MM/yyyy').format(dateTime);
        });
      },
    );
  }
}
