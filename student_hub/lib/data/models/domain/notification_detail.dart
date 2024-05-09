import 'dart:convert';

class NotificationDetail {
  int id;
  DateTime createdAt;
  DateTime updatedAt;
  dynamic deletedAt;
  int receiverId;
  int senderId;
  int messageId;
  String title;
  String notifyFlag;
  String typeNotifyFlag;
  String content;
  Message? message;
  Receiver? sender;
  Receiver? receiver;

  NotificationDetail({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.deletedAt,
    required this.receiverId,
    required this.senderId,
    required this.messageId,
    required this.title,
    required this.notifyFlag,
    required this.typeNotifyFlag,
    required this.content,
    required this.message,
    required this.sender,
    required this.receiver,
  });

  factory NotificationDetail.fromRawJson(String str) => NotificationDetail.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory NotificationDetail.fromJson(Map<String, dynamic> json) => NotificationDetail(
    id: json["id"],
    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
    deletedAt: json["deletedAt"],
    receiverId: json["receiverId"],
    senderId: json["senderId"],
    messageId: json["messageId"],
    title: json["title"],
    notifyFlag: json["notifyFlag"],
    typeNotifyFlag: json["typeNotifyFlag"],
    content: json["content"],
    message: Message.fromJson(json["message"]),
    sender: Receiver.fromJson(json["sender"]),
    receiver: Receiver.fromJson(json["receiver"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "createdAt": createdAt.toIso8601String(),
    "updatedAt": updatedAt.toIso8601String(),
    "deletedAt": deletedAt,
    "receiverId": receiverId,
    "senderId": senderId,
    "messageId": messageId,
    "title": title,
    "notifyFlag": notifyFlag,
    "typeNotifyFlag": typeNotifyFlag,
    "content": content,
    "message": message?.toJson(),
    "sender": sender?.toJson(),
    "receiver": receiver?.toJson(),
  };
}

class Message {
  int id;
  DateTime createdAt;
  DateTime updatedAt;
  dynamic deletedAt;
  int senderId;
  int receiverId;
  int projectId;
  Interview? interview;
  String content;
  int messageFlag;

  Message({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.deletedAt,
    required this.senderId,
    required this.receiverId,
    required this.projectId,
    required this.interview,
    required this.content,
    required this.messageFlag,
  });

  factory Message.fromRawJson(String str) => Message.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Message.fromJson(Map<String, dynamic> json) => Message(
    id: json["id"],
    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
    deletedAt: json["deletedAt"],
    senderId: json["senderId"],
    receiverId: json["receiverId"],
    projectId: json["projectId"],
    interview: json["interview"] == null ? null : Interview.fromJson(json["interview"]),
    content: json["content"],
    messageFlag: json["messageFlag"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "createdAt": createdAt.toIso8601String(),
    "updatedAt": updatedAt.toIso8601String(),
    "deletedAt": deletedAt,
    "senderId": senderId,
    "receiverId": receiverId,
    "projectId": projectId,
    "interview": interview?.toJson(),
    "content": content,
    "messageFlag": messageFlag,
  };
}

class Interview {
  int id;
  DateTime createdAt;
  DateTime updatedAt;
  DateTime deletedAt;
  String title;
  DateTime startTime;
  DateTime endTime;
  int disableFlag;
  MeetingRoom meetingRoom;

  Interview({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.deletedAt,
    required this.title,
    required this.startTime,
    required this.endTime,
    required this.disableFlag,
    required this.meetingRoom,
  });

  factory Interview.fromRawJson(String str) => Interview.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Interview.fromJson(Map<String, dynamic> json) => Interview(
    id: json["id"],
    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
    deletedAt: DateTime.parse(json["deletedAt"]),
    title: json["title"],
    startTime: DateTime.parse(json["startTime"]),
    endTime: DateTime.parse(json["endTime"]),
    disableFlag: json["disableFlag"],
    meetingRoom: MeetingRoom.fromJson(json["meetingRoom"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "createdAt": createdAt.toIso8601String(),
    "updatedAt": updatedAt.toIso8601String(),
    "deletedAt": deletedAt.toIso8601String(),
    "title": title,
    "startTime": startTime.toIso8601String(),
    "endTime": endTime.toIso8601String(),
    "disableFlag": disableFlag,
    "meetingRoom": meetingRoom.toJson(),
  };
}

class MeetingRoom {
  int id;
  DateTime createdAt;
  DateTime updatedAt;
  dynamic deletedAt;
  String meetingRoomCode;
  String meetingRoomId;
  dynamic expiredAt;

  MeetingRoom({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.deletedAt,
    required this.meetingRoomCode,
    required this.meetingRoomId,
    required this.expiredAt,
  });

  factory MeetingRoom.fromRawJson(String str) => MeetingRoom.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory MeetingRoom.fromJson(Map<String, dynamic> json) => MeetingRoom(
    id: json["id"],
    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
    deletedAt: json["deletedAt"],
    meetingRoomCode: json["meeting_room_code"],
    meetingRoomId: json["meeting_room_id"],
    expiredAt: json["expired_at"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "createdAt": createdAt.toIso8601String(),
    "updatedAt": updatedAt.toIso8601String(),
    "deletedAt": deletedAt,
    "meeting_room_code": meetingRoomCode,
    "meeting_room_id": meetingRoomId,
    "expired_at": expiredAt,
  };
}

class Receiver {
  int id;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic deletedAt;
  String email;
  String fullname;
  bool? verified;
  bool? isConfirmed;

  Receiver({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.deletedAt,
    required this.email,
    required this.fullname,
    required this.verified,
    required this.isConfirmed,
  });

  factory Receiver.fromRawJson(String str) => Receiver.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Receiver.fromJson(Map<String, dynamic> json) => Receiver(
    id: json["id"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    deletedAt: json["deletedAt"],
    email: json["email"],
    fullname: json["fullname"],
    verified: json["verified"],
    isConfirmed: json["isConfirmed"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "deletedAt": deletedAt,
    "email": email,
    "fullname": fullname,
    "verified": verified,
    "isConfirmed": isConfirmed,
  };
}
