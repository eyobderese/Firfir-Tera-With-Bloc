import 'package:firfir_tera/Domain/Repository%20Interface/userRepositery.dart';
import 'package:firfir_tera/presentation/pages/admin/bloc/admin_event.dart';
import 'package:firfir_tera/presentation/pages/admin/bloc/admin_state.dart';
import 'package:firfir_tera/application/bloc/admin/userDto.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AdminBloc extends Bloc<AdminEvent, AdminState> {
  final UserRepository userRepository;

  AdminBloc({required this.userRepository}) : super(AdminInitial()) {
    on<LoadUsers>(_onLoadUsers);
    on<PromotUser>(_onPromoteUser);
    on<DemotUser>(_onDemoteUser);
    on<AddAdmin>(_onAddAdmin);
    on<DeleteUser>(_onDelete);
  }

  void _onLoadUsers(LoadUsers event, Emitter<AdminState> emit) async {
    emit(AdminLoading());
    try {
      final users = await userRepository.getUserDtoAll();
      emit(AdminLoaded(users));
    } catch (e) {
      emit(AdminError('Failed to load users'));
    }
  }

  void _onDelete(DeleteUser event, Emitter<AdminState> emit) async {
    emit(AdminLoading());
    try {
      await userRepository.deleteUser(event.userId);
      final users = await userRepository.getUserDtoAll();
      emit(AdminLoaded(users));
    } catch (e) {
      emit(AdminError('Failed to delete user'));
    }
  }

  void _onPromoteUser(PromotUser event, Emitter<AdminState> emit) async {
    emit(AdminLoading());
    try {
      await userRepository.promoteUser(event.userId);
      final users = await userRepository.getUserDtoAll();
      emit(AdminLoaded(users));
    } catch (e) {
      emit(AdminError('Failed to promote user'));
    }
  }

  void _onDemoteUser(DemotUser event, Emitter<AdminState> emit) async {
    emit(AdminLoading());
    try {
      await userRepository.demoteUser(event.userId);
      final users = await userRepository.getUserDtoAll();
      emit(AdminLoaded(users));
    } catch (e) {
      emit(AdminError('Failed to demote user'));
    }
  }

  void _onAddAdmin(AddAdmin event, Emitter<AdminState> emit) async {
    emit(AdminLoading());
    try {
      await userRepository.addAdmin(event.userId);
      final users = await userRepository.getUserDtoAll();
      emit(AdminLoaded(users));
    } catch (e) {
      emit(AdminError('Failed to add admin'));
    }
  }
}
