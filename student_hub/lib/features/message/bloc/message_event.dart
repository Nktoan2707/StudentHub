
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


