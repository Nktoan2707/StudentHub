// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

enum BubbleMessageType { sender, receiver } //sender: mình là người gửi, receiver: mình là người nhận

class MessageDetail {
  final String senderID;
  final String senderName;
  final String message;
  final BubbleMessageType messageType;
  final DateTime date;

  MessageDetail(
      {required this.senderID,
      required this.senderName,
      required this.message,
      required this.messageType,
      required this.date});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'senderID': senderID,
      'senderName': senderName,
      'message': message,
      'messageType': messageType.index,
      'date': date.millisecondsSinceEpoch,
    };
  }

  factory MessageDetail.fromMap(Map<String, dynamic> map) {
    int val = map['messageType'];
    return MessageDetail(
      senderID: map['senderID'] as String,
      senderName: map['senderName'] as String,
      message: map['message'] as String,
      messageType:
          BubbleMessageType.values[val],
      date: DateTime.fromMillisecondsSinceEpoch(map['date'] as int),
    );
  }

  String toJson() => json.encode(toMap());

  factory MessageDetail.fromJson(String source) =>
      MessageDetail.fromMap(json.decode(source) as Map<String, dynamic>);
}
