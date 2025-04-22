import 'package:dio/dio.dart';
import 'package:electro_app_team/cubits/profile%20data/get_profile_data_state.dart';
import 'package:electro_app_team/models/profile_model.dart';
import 'package:electro_app_team/services/profile_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GetProfileDataCubit extends Cubit<ProfileDataState> {
  GetProfileDataCubit() : super(ProfileDataInitial());
  final ProfileService profileService = ProfileService(dio: Dio());

  Future<void> getProfileData(String token) async {
    try {
      emit(ProfileDataLoading());
      ProfileModel profileModel = await profileService.getProfileData(token);
      emit(ProfileDataSuccess(profileModel));
    } on Exception catch (e) {
      emit(ProfileDataFailed(e.toString()));
    }
  }
}
