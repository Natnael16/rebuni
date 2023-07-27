part of 'get_discussions_bloc.dart';

abstract class GetDiscussionsState extends Equatable {
  const GetDiscussionsState();
  
  @override
  List<Object> get props => [];
}

class GetDiscussionsInitial extends GetDiscussionsState {}

class GetDiscussionsLoading extends GetDiscussionsState {}

class GetDiscussionsSuccess extends GetDiscussionsState {
  final List<Discussion> discussionList;

  GetDiscussionsSuccess(this.discussionList);
}

class GetDiscussionsFailure extends GetDiscussionsState {
  final String errorMessage;

  GetDiscussionsFailure(this.errorMessage);
}
