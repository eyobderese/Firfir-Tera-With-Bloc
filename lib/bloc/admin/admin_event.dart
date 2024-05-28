import 'package:equatable/equatable.dart';
import 'package:firfir_tera/model/user.dart';

abstract class AdminEvent extends Equatable {
  const AdminEvent();

  @override
  List<Object> get props => [];
}

class LoadUsers extends AdminEvent {}

class PromotUser extends AdminEvent {
  final String userId;

  const PromotUser(this.userId);

  @override
  List<Object> get props => [userId];
}

class DemotUser extends AdminEvent {
  final String userId;

  const DemotUser(this.userId);

  @override
  List<Object> get props => [userId];
}

class DeleteUser extends AdminEvent {
  final String userId;

  const DeleteUser(this.userId);

  @override
  List<Object> get props => [userId];
}

class AddAdmin extends AdminEvent {
  final String userId;

  const AddAdmin(this.userId);

  @override
  List<Object> get props => [userId];
}
