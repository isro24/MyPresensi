import 'package:my_presensi/data/models/response/admin/admin_location_response_model.dart';

sealed class AdminLocationState {}

class AdminLocationInitial extends AdminLocationState {}

class AdminLocationLoading extends AdminLocationState {}

class AdminLocationLoaded extends AdminLocationState {
  final List<LocationData> locations;
  AdminLocationLoaded(this.locations);
}

class AdminLocationSuccess extends AdminLocationState {
  final String message;
  AdminLocationSuccess(this.message);
}

class AdminLocationError extends AdminLocationState {
  final String message;
  AdminLocationError(this.message);
}
