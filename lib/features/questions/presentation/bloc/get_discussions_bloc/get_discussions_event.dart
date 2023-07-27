part of 'get_discussions_bloc.dart';

abstract class GetDiscussionsEvent extends Equatable {
  const GetDiscussionsEvent();

  @override
  List<Object> get props => [];
}

class GetDiscussions extends GetDiscussionsEvent {
  final String questionId;

  GetDiscussions(this.questionId);

}
