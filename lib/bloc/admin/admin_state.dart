import 'package:equatable/equatable.dart';
import 'package:firfir_tera/bloc/admin/userDto.dart';

abstract class AdminState extends Equatable {
  const AdminState();

  @override
  List<Object> get props => [];
}

class AdminInitial extends AdminState {}

class AdminLoading extends AdminState {}

class AdminLoaded extends AdminState {
  final List<UserDto> users;

  const AdminLoaded(this.users);

  @override
  List<Object> get props => [users];
}

class AdminError extends AdminState {
  final String message;

  const AdminError(this.message);

  @override
  List<Object> get props => [message];
}
