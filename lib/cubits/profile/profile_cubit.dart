import 'package:electro_app_team/cubits/profile/profile_state.dart';
import 'package:electro_app_team/models/profile_model.dart';
import 'package:electro_app_team/services/profile_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final ProfileService profileService;

  ProfileCubit(this.profileService) : super(ProfileInitial());

  Future<void> fetchProfile(String token) async {
    try {
      emit(ProfileLoading());
      final profile = await profileService.getProfile(token);

      if (profile != null) {
        emit(ProfileLoaded(profile));
      } else {
        emit(ProfileError("Failed to load profile"));
      }
    } catch (e) {
      emit(ProfileError("An error occurred: ${e.toString()}"));
    }
  }
}
