import 'package:electro_app_team/models/profile_model.dart';

class ProfileDataState {}

class ProfileDataInitial extends ProfileDataState {}

class ProfileDataLoading extends ProfileDataState {}

class ProfileDataSuccess extends ProfileDataState {
  final ProfileModel profileModel;
  ProfileDataSuccess(this.profileModel);
}

class ProfileDataFailed extends ProfileDataState {
  final String message;
  ProfileDataFailed(this.message);
}
