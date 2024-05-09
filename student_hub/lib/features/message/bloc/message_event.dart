
part of 'message_bloc.dart';

abstract class MessageEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class MessageProjectListFetchEvent extends MessageEvent {
  final int projectId;

  MessageProjectListFetchEvent({required this.projectId});

  @override
  String toString() {
    return "[EVENT] MessageProjectListFetchEvent ${projectId.toString()}";
  }
}

class MessageSentEvent extends MessageEvent {
  final MessageSent messageSent;

  MessageSentEvent({required this.messageSent});

  @override
  String toString() {
    return "[EVENT] MessageSentEvent $messageSent}";
  }
}

class MessageGetListOfUserEvent extends MessageEvent {
  final int projectId;
  final int userId;

  MessageGetListOfUserEvent({required this.projectId, required this.userId});

  @override
  String toString() {
    return "[EVENT] MessageGetListOfUserEvent userId $userId}";
  }
}

class MessageGetListOfMeEvent extends MessageEvent {
}

class MessageInterviewSentEvent extends MessageEvent {
  final InterviewSent interviewSent;

  MessageInterviewSentEvent({required this.interviewSent});

  @override
  String toString() {
    return "[EVENT] MessageInterviewSentEvent $interviewSent}";
  }
}

