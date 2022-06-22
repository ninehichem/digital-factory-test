part of 'randomevent_cubit.dart';

@immutable
abstract class RandomeventState {}

class RandomeventInitial extends RandomeventState {}

class RandomeventLoading extends RandomeventState {}

class RandomeventSuccess extends RandomeventState {
  EventModel? eventModel;

  RandomeventSuccess(this.eventModel);
}

class RandomeventFailure extends RandomeventState {
  final String errmsg;
  RandomeventFailure(this.errmsg);
}
