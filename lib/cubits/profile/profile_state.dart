import 'package:electro_app_team/models/profile_model.dart';

abstract class ProfileState {}

class ProfileInitial extends ProfileState {}

class ProfileLoading extends ProfileState {}

class ProfileLoaded extends ProfileState {
  final ProfileResponse profileResponse;

  ProfileLoaded(this.profileResponse);
}

class ProfileError extends ProfileState {
  final String message;

  ProfileError(this.message);
}
