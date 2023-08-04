part of 'get_replies_bloc.dart';

abstract class GetRepliesState extends Equatable {
  const GetRepliesState();

  @override
  List<Object> get props => [];
}

class GetRepliesInitial extends GetRepliesState {}

class GetRepliesSuccess extends GetRepliesState {
  final List<Reply> replies;

  const GetRepliesSuccess(this.replies);
}

class GetRepliesLoading extends GetRepliesState {}

class GetRepliesFailure extends GetRepliesState {
  final String errorMessage;

  const GetRepliesFailure(this.errorMessage);
}
