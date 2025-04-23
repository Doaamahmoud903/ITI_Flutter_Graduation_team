import 'package:electro_app_team/cubits/Privacy/change_password_State.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:electro_app_team/services/change_password_service.dart';
import 'package:electro_app_team/models/change_password_response_model.dart';

class ChangePasswordCubit extends Cubit<ChangePasswordState> {
  final ChangePasswordService service;

  ChangePasswordCubit({required this.service}) : super(ChangePasswordInitial());

  Future<void> changePassword({
    required String currentPassword,
    required String newPassword,
    required String token,
  }) async {
    emit(ChangePasswordLoading());
    try {
      final result = await service.changePassword(
        currentPassword: currentPassword,
        newPassword: newPassword,
        token: token,
      );
      emit(ChangePasswordSuccess(result.message));
    } catch (e) {
      emit(ChangePasswordFailure(e.toString()));
    }
  }
}
