part of 'get_replies_bloc.dart';

abstract class GetRepliesEvent extends Equatable {
  const GetRepliesEvent();

  @override
  List<Object> get props => [];
}

class GetReplies extends GetRepliesEvent {
  final String id;
  final bool isAnswer;

  GetReplies(this.id,this.isAnswer);
}
