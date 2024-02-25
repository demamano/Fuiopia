import 'package:fuiopia/data/models/models.dart';
import 'package:equatable/equatable.dart';

abstract class ProfileState extends Equatable {
  @override
  List<Object> get props => [];
}

class ProfileLoading extends ProfileState {}

class ProfileLoaded extends ProfileState {
  final UserModel loggedUser;

  ProfileLoaded(this.loggedUser);

  @override
  List<Object> get props => [loggedUser];

  @override
  String toString() {
    return "{ProfileLoaded: loggedUser:${loggedUser.toString()}}";
  }
}

class ProfileLoadFailure extends ProfileState {
  final String error;

  ProfileLoadFailure(this.error);

  @override
  List<Object> get props => [error];
}
