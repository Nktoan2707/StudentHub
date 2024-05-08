part of 'message_bloc.dart';

abstract class MessageState extends Equatable {

  @override
  List<Object?> get props => [];
}

class MessageInitial extends MessageState {

}

class MessageInprogress extends MessageState {

}

class MessageProjectListFetchSuccess extends MessageState {
  final List<MessageContent> listMessage;

  MessageProjectListFetchSuccess({required this.listMessage});

  @override
  String toString() {
    return "[EVENT] MessageProjectListFetchSuccess ${listMessage.toString()}";
  }
}

class MessageProjectListFetchFail extends MessageState {

}

class MessageProjectMakeContactSuccess extends MessageState {

}

class MessageProjectMakeContactFail extends MessageState {

}

