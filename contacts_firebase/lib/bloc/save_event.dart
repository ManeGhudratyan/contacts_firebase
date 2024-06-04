part of 'save_bloc.dart';

sealed class SaveEvent extends Equatable {
  const SaveEvent();

  @override
  List<Object> get props => [];
}

final class SaveDbEvent extends SaveEvent {
  final String name;
  final int phoneNumber;

  const SaveDbEvent(this.name, this.phoneNumber);
}

final class UpdateDbEvent extends SaveEvent {
  final String? userId;
  final String name;
  final int phoneNumber;

  const UpdateDbEvent(this.name, this.phoneNumber, {this.userId});
}

final class DeleteUserFromDBEvent extends SaveEvent {
  final String? userId;
  final String? name;
  final int? phoneNumber;

  const DeleteUserFromDBEvent({this.userId, this.name, this.phoneNumber});
}
