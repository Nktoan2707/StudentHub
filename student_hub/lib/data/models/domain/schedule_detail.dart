// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'message_detail.dart';

enum ScheduleDetailStatus { progressing, expired, cancel }

class ScheduleDetail {
  final String title;
  final String senderID;
  final String senderName;
  final String duration;
  final DateTime startTime;
  final DateTime endTime;
  final ScheduleDetailStatus status;
  final BubbleMessageType messageType;
  final DateTime date;

  ScheduleDetail({
    required this.title,
    required this.senderID,
    required this.senderName,
    required this.duration,
    required this.startTime,
    required this.endTime,
    required this.status,
    required this.messageType,
    required this.date,
  });
}
