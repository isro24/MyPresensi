import 'package:my_presensi/data/models/request/admin/admin_location_request_model.dart';

sealed class AdminLocationEvent {}

class GetAllLocationsEvent extends AdminLocationEvent {}

class CreateLocationEvent extends AdminLocationEvent {
  final AdminLocationRequestModel request;
  CreateLocationEvent(this.request);
}

class UpdateLocationEvent extends AdminLocationEvent {
  final int id;
  final AdminLocationRequestModel request;
  UpdateLocationEvent(this.id, this.request);
}

class DeleteLocationEvent extends AdminLocationEvent {
  final int id;
  DeleteLocationEvent(this.id);
}
