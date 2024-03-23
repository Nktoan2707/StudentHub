import 'package:flutter/material.dart';
import 'package:student_hub/data/models/domain/message_detail.dart';

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

    final textColor = (messageDetail.messageType== BubbleMessageType.sender)
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