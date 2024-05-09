import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:student_hub/data/models/domain/notification_detail.dart';
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
        context
            .read<NotificationBloc>()
            .add(NotificationUpdated(notificationId: notification.id));
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
                              "At ${notification.createdAt}",
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
      return const Icon(Icons.settings);
    } else if (typeNotifyFlag == "1") {
      return const Icon(Icons.settings);
    } else if (typeNotifyFlag == "2") {
      return const Icon(Icons.settings);
    } else if (typeNotifyFlag == "3") {
      return const Icon(Icons.accessibility);
    } else if (typeNotifyFlag == "4") {
      return const Icon(Icons.settings);
    }

    return Icon(Icons.error);
  }

  Widget _buildContent() {
    if (notification.typeNotifyFlag == "0") {
      return const Icon(Icons.settings);
    } else if (notification.typeNotifyFlag == "1") {
      return const Icon(Icons.settings);
    } else if (notification.typeNotifyFlag == "2") {
      return const Icon(Icons.settings);
    } else if (notification.typeNotifyFlag == "3") {
      return Text(
          "Message content: ${notification.message?.content ?? notification.content}");
    } else if (notification.typeNotifyFlag == "4") {
      return const Icon(Icons.settings);
    }

    return Placeholder(
      fallbackHeight: 20,
    );
  }
}
