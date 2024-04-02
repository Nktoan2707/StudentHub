import 'package:flutter/material.dart';
import 'package:student_hub/data/models/domain/message_detail.dart';
import 'package:student_hub/data/models/domain/schedule_detail.dart';
import 'package:student_hub/features/message/pages/video_call_page.dart';
import 'package:student_hub/widgets/components/ui_extension.dart';

class MessageBubble extends StatelessWidget {
  const MessageBubble({
    super.key,
    required this.messageDetail,
  });

  final MessageDetail messageDetail;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    final alignment = (messageDetail.messageType == BubbleMessageType.sender)
        ? Alignment.centerRight
        : Alignment.centerLeft;

    final color = (messageDetail.messageType == BubbleMessageType.sender)
        ? Theme.of(context).colorScheme.primary
        : Theme.of(context).colorScheme.secondary;

    final textColor = (messageDetail.messageType == BubbleMessageType.sender)
        ? Theme.of(context).colorScheme.onPrimary
        : Theme.of(context).colorScheme.onSecondary;

    return Align(
      alignment: alignment,
      child: Column(
        children: [
          Container(
            constraints: BoxConstraints(maxWidth: size.width * 0.66),
            padding: const EdgeInsets.all(8.0),
            margin: const EdgeInsets.all(4.0),
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(
                8.0,
              ),
            ),
            child: Text(
              messageDetail.message,
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: textColor,
                  ),
            ),
          ),
        ],
      ),
    );
  }
}

class MessageSchedule extends StatelessWidget {
  const MessageSchedule({
    super.key,
    required this.scheduleDetail,
  });

  final ScheduleDetail scheduleDetail;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Column(
      children: [
        Container(
          constraints: BoxConstraints(maxWidth: size.width * 0.8),
          padding: const EdgeInsets.all(8.0),
          margin: const EdgeInsets.all(4.0),
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.black,
              width: 2,
              style: BorderStyle.solid,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    scheduleDetail.title,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  Text(scheduleDetail.duration)
                ],
              ),
              const Text(
                'Start time:',
              ),
              Text(
                ' ${scheduleDetail.startTime}',
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
              ),
              const Text(
                'End time:',
              ),
              Text(
                ' ${scheduleDetail.endTime}',
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  InkCustomButton(
                    title: 'Join',
                    width: 150,
                    padding: 0,
                    height: 40,
                    onTap: () {
                      Navigator.of(context).pushNamed(VideoCallPage.pageId);
                    },
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.edit),
                    padding: EdgeInsets.zero,
                  )
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
