import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:student_hub/common/enums.dart';
import 'package:student_hub/data/models/domain/message_detail.dart';
import 'package:student_hub/data/models/domain/notification_detail.dart';
import 'package:student_hub/data/models/domain/project.dart';
import 'package:student_hub/data/models/domain/user.dart';
import 'package:student_hub/features/message/pages/tab_message_detail_page.dart';
import 'package:student_hub/features/main_tab_bar_page.dart';
import 'package:student_hub/features/notification/bloc/notification_bloc.dart';

class NotificationPage extends StatefulWidget {
  static const String pageId = "/NotificationPage";

  const NotificationPage({super.key});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NotificationBloc, NotificationState>(
      builder: (context, state) {
        if (state is NotificationFetchInProgress ||
            state is NotificationUpdateInProgress) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is NotificationFetchSuccess) {
          if (state.notificationList.isEmpty) {
            return Center(
              child: Text(
                "You don't have any notification...",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            );
          }

          return Scaffold(
            body: SingleChildScrollView(
              padding: EdgeInsets.all(20),
              child: ListView.separated(
                scrollDirection: Axis.vertical,
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: state.notificationList.length,
                itemBuilder: (context, index) {
                  return _NotificationListViewItem(
                    notification: state.notificationList[index],
                  );
                },
                separatorBuilder: (BuildContext context, int index) {
                  return const Divider(
                    color: Colors.grey,
                    thickness: 3,
                  );
                },
              ),
            ),
          );
        }
        return Placeholder();
      },
    );
  }
}

class _NotificationListViewItem extends StatelessWidget {
  final NotificationDetail notification;

  const _NotificationListViewItem({super.key, required this.notification});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (notification.notifyFlag == "0") {
          context
              .read<NotificationBloc>()
              .add(NotificationUpdated(notificationId: notification.id));
        }
        if (notification.typeNotifyFlag == "0") {
          MainTabBarPage.myStreamController.add(1);
        } else if (notification.typeNotifyFlag == "1") {
          MainTabBarPage.myStreamController.add(2);
          if (notification.message != null) {
            Navigator.of(context)
                .pushNamed(TabMessageDetailPage.pageId, arguments: {
              "messageInit": MessageContent(
                project: Project(
                    projectId: notification.message!.projectId,
                    createdAt: "",
                    updatedAt: "",
                    deletedAt: "",
                    companyId: "",
                    projectScopeFlag: ProjectScopeFlag.LessThanOneMonth,
                    title: "",
                    description: "description",
                    numberOfStudents: 0,
                    typeFlag: 1,
                    countProposals: 1,
                    isFavorite: true,
                    countHired: 0,
                    countMessages: 0),
                me: User(id: notification.receiverId, fullname: ""),
                sender: User(
                    id: notification.senderId,
                    fullname: notification.sender!.fullname),
                receiver: User(id: notification.receiverId, fullname: ""),
              )
            });
          }
        } else if (notification.typeNotifyFlag == "2") {
          MainTabBarPage.myStreamController.add(1);
        } else if (notification.typeNotifyFlag == "3") {
          MainTabBarPage.myStreamController.add(2);
          if (notification.message != null) {
            Navigator.of(context)
                .pushNamed(TabMessageDetailPage.pageId, arguments: {
              "messageInit": MessageContent(
                project: Project(
                    projectId: notification.message!.projectId,
                    createdAt: "",
                    updatedAt: "",
                    deletedAt: "",
                    companyId: "",
                    projectScopeFlag: ProjectScopeFlag.LessThanOneMonth,
                    title: "",
                    description: "description",
                    numberOfStudents: 0,
                    typeFlag: 1,
                    countProposals: 1,
                    isFavorite: true,
                    countHired: 0,
                    countMessages: 0),
                me: User(id: notification.receiverId, fullname: ""),
                sender: User(
                    id: notification.senderId,
                    fullname: notification.sender!.fullname),
                receiver: User(id: notification.receiverId, fullname: ""),
              )
            });
          }
        } else if (notification.typeNotifyFlag == "4") {
          MainTabBarPage.myStreamController.add(1);
        }
      },
      child: Container(
        color: notification.notifyFlag == "0" ? Colors.grey : null,
        padding: EdgeInsets.all(20),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      getNotificationIcon(notification.typeNotifyFlag),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "At ${notification.createdAt.toLocal().toString().substring(0, 19)}",
                              style: TextStyle(
                                fontSize: 12,
                              ),
                            ),
                            Text(
                              notification.title,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            _buildContent(),
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

  Widget getNotificationIcon(String typeNotifyFlag) {
    if (typeNotifyFlag == "0") {
      return const Icon(Icons.waving_hand);
    } else if (typeNotifyFlag == "1") {
      return const Icon(Icons.video_call_outlined);
    } else if (typeNotifyFlag == "2") {
      return const Icon(Icons.touch_app_rounded);
    } else if (typeNotifyFlag == "3") {
      return const Icon(Icons.message_outlined);
    } else if (typeNotifyFlag == "4") {
      return const Icon(Icons.handshake_sharp);
    }

    return Icon(Icons.error);
  }

  Widget _buildContent() {
    if (notification.typeNotifyFlag == "0") {
      return Text(notification.content);
    } else if (notification.typeNotifyFlag == "1") {
      return Text(notification.content);
    } else if (notification.typeNotifyFlag == "2") {
      return Text(notification.content);
    } else if (notification.typeNotifyFlag == "3") {
      return Text(
          "Message content: ${notification.message?.content ?? notification.content}");
    } else if (notification.typeNotifyFlag == "4") {
      return Text(notification.content);
    }

    return Placeholder(
      fallbackHeight: 20,
    );
  }
}
