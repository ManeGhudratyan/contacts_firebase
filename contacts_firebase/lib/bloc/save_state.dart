part of 'save_bloc.dart';

sealed class SaveState extends Equatable {
  const SaveState({this.error, this.name, this.phoneNumber});
  final String? error;
  final String? name;
  final int? phoneNumber;

  @override
  List<Object?> get props => [error, name, phoneNumber];
}

final class SaveInitial extends SaveState {}

final class SaveFailed extends SaveState {
  const SaveFailed(String error) : super(error: error);
}

final class SaveLoading extends SaveState {}

final class SaveLoaded extends SaveState {
  const SaveLoaded(String name, int phoneNumber)
      : super(name: name, phoneNumber: phoneNumber);
}

final class UpdateDataLoading extends SaveState {}

final class UpdateDataLoaded extends SaveState {
  const UpdateDataLoaded(String name, int phoneNumber)
      : super(name: name, phoneNumber: phoneNumber);
}

final class UpdateFailed extends SaveState {
  const UpdateFailed(String error) : super(error: error);
}

final class DeleteUserFromDBLoaded extends SaveState {
  const DeleteUserFromDBLoaded(String name, int phoneNumber)
      : super(name: name, phoneNumber: phoneNumber);
}

final class DeleteFailed extends SaveState {
  const DeleteFailed(String error) : super(error: error);
}
