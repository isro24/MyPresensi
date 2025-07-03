part of 'admin_profile_bloc.dart';

sealed class AdminProfileEvent {}

class GetAdminProfileEvent extends AdminProfileEvent {}

class ResetAdminProfileStateEvent extends AdminProfileEvent {}

class UpdateAdminProfileEvent extends AdminProfileEvent {
  final int id;
  final File? photoFile;
  final AdminProfileRequestModel request;

  UpdateAdminProfileEvent({required this.id, required this.request, this.photoFile});
}
