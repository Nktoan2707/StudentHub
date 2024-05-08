// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:student_hub/data/models/domain/project.dart';
import 'package:student_hub/data/models/domain/user.dart';

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


MessageContent messageContentFromJson(String str) => MessageContent.fromJson(json.decode(str));

String messageContentToJson(MessageDetail data) => json.encode(data.toJson());

class MessageContent {
    int? id;
    DateTime? createdAt;
    String? content;
    User? sender;
    User? receiver;
    Interview? interview;
    BubbleMessageType? messageType;
    User? me;
    Project? project;

    MessageContent({
        this.id,
        this.createdAt,
        this.content,
        this.sender,
        this.receiver,
        this.interview,
        this.messageType,
        this.me,
        this.project
    });

    factory MessageContent.fromJson(Map<String, dynamic> json) => MessageContent(
        id: json["id"],
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        content: json["content"],
        sender: json["sender"] == null ? null : User.fromMap(json["sender"]),
        receiver: json["receiver"] == null ? null : User.fromMap(json["receiver"]),
        interview: json["interview"] == null ? null : Interview.fromJson(json["interview"]),
        messageType: json["sender"] == null ? BubbleMessageType.receiver : 
        User.fromMap(json["sender"]).id ==  json["me"].id ?  BubbleMessageType.sender :  BubbleMessageType.receiver,
        me: json["me"],
        project: json["project"] == null ? null : Project.fromMap(json["project"])
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "createdAt": createdAt?.toIso8601String(),
        "content": content,
        "sender": sender?.toJson(),
        "receiver": receiver?.toJson(),
        "interview": interview?.toJson(),
    };
}

class Interview {
    int? id;
    DateTime? createdAt;
    DateTime? updatedAt;
    dynamic deletedAt;
    String? title;
    DateTime? startTime;
    DateTime? endTime;
    int? disableFlag;
    int? meetingRoomId;
    MeetingRoom? meetingRoom;

    Interview({
        this.id,
        this.createdAt,
        this.updatedAt,
        this.deletedAt,
        this.title,
        this.startTime,
        this.endTime,
        this.disableFlag,
        this.meetingRoomId,
        this.meetingRoom,
    });

    factory Interview.fromJson(Map<String, dynamic> json) => Interview(
        id: json["id"],
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
        deletedAt: json["deletedAt"],
        title: json["title"],
        startTime: json["startTime"] == null ? null : DateTime.parse(json["startTime"]),
        endTime: json["endTime"] == null ? null : DateTime.parse(json["endTime"]),
        disableFlag: json["disableFlag"],
        meetingRoomId: json["meetingRoomId"],
        meetingRoom: json["meetingRoom"] == null ? null : MeetingRoom.fromJson(json["meetingRoom"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "deletedAt": deletedAt,
        "title": title,
        "startTime": startTime?.toIso8601String(),
        "endTime": endTime?.toIso8601String(),
        "disableFlag": disableFlag,
        "meetingRoomId": meetingRoomId,
        "meetingRoom": meetingRoom?.toJson(),
    };
}

class MeetingRoom {
    int? id;
    DateTime? createdAt;
    DateTime? updatedAt;
    dynamic deletedAt;
    String? meetingRoomCode;
    String? meetingRoomId;
    DateTime? expiredAt;

    MeetingRoom({
        this.id,
        this.createdAt,
        this.updatedAt,
        this.deletedAt,
        this.meetingRoomCode,
        this.meetingRoomId,
        this.expiredAt,
    });

    factory MeetingRoom.fromJson(Map<String, dynamic> json) => MeetingRoom(
        id: json["id"],
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
        deletedAt: json["deletedAt"],
        meetingRoomCode: json["meeting_room_code"],
        meetingRoomId: json["meeting_room_id"],
        expiredAt: json["expired_at"] == null ? null : DateTime.parse(json["expired_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "deletedAt": deletedAt,
        "meeting_room_code": meetingRoomCode,
        "meeting_room_id": meetingRoomId,
        "expired_at": expiredAt?.toIso8601String(),
    };
}

class Receiver {
    int? id;
    String? fullname;

    Receiver({
        this.id,
        this.fullname,
    });

    factory Receiver.fromJson(Map<String, dynamic> json) => Receiver(
        id: json["id"],
        fullname: json["fullname"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "fullname": fullname,
    };
}

class MessageSent {
    int? projectId;
    String? content;
    int? messageFlag;
    int? senderId;
    int? receiverId;

    MessageSent({
        this.projectId,
        this.content,
        this.messageFlag,
        this.senderId,
        this.receiverId,
    });

    factory MessageSent.fromJson(Map<String, dynamic> json) => MessageSent(
        projectId: json["projectId"],
        content: json["content"],
        messageFlag: json["messageFlag"],
        senderId: json["senderId"],
        receiverId: json["receiverId"],
    );

    Map<String, dynamic> toJson() => {
        "projectId": projectId,
        "content": content,
        "messageFlag": messageFlag,
        "senderId": senderId,
        "receiverId": receiverId,
    };
}


