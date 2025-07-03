part of 'admin_profile_bloc.dart';

sealed class AdminProfileState {}

final class AdminProfileInitial extends AdminProfileState {}

final class AdminProfileLoading extends AdminProfileState {}

final class AdminProfileUpdating extends AdminProfileState {}

final class AdminProfileLoaded extends AdminProfileState {
  final AdminProfileResponseModel profile;

  AdminProfileLoaded({required this.profile});
}

final class AdminProfileUpdated extends AdminProfileState {
  final AdminProfileResponseModel profile;

  AdminProfileUpdated({required this.profile});
}

final class AdminProfileError extends AdminProfileState {
  final String message;

  AdminProfileError({required this.message});
}

final class AdminProfileUpdateError extends AdminProfileState {
  final String message;
  final AdminProfileResponseModel previousProfile;

  AdminProfileUpdateError({required this.message, required this.previousProfile});
}
