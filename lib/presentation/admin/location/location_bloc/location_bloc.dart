import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_presensi/data/repository/admin/admin_location_repository.dart';
import 'location_event.dart';
import 'location_state.dart';

class AdminLocationBloc extends Bloc<AdminLocationEvent, AdminLocationState> {
  final AdminLocationRepository adminLocationRepository;

  AdminLocationBloc({required this.adminLocationRepository}) : super(AdminLocationInitial()) {
    on<GetAllLocationsEvent>(_onGetAll);
    on<CreateLocationEvent>(_onCreate);
    on<UpdateLocationEvent>(_onUpdate);
    on<DeleteLocationEvent>(_onDelete);
  }

  Future<void> _onGetAll(GetAllLocationsEvent event, Emitter<AdminLocationState> emit) async {
    emit(AdminLocationLoading());
    final result = await adminLocationRepository.getAllLocations();
    result.fold(
      (failure) => emit(AdminLocationError(failure)),
      (locations) => emit(AdminLocationLoaded(locations)),
    );
  }

  Future<void> _onCreate(CreateLocationEvent event, Emitter<AdminLocationState> emit) async {
    emit(AdminLocationLoading());
    final result = await adminLocationRepository.createLocation(event.request);
    result.fold(
      (failure) => emit(AdminLocationError(failure)),
      (message) {
        emit(AdminLocationSuccess(message));
        add(GetAllLocationsEvent());
      },
    );
  }

  Future<void> _onUpdate(UpdateLocationEvent event, Emitter<AdminLocationState> emit) async {
    emit(AdminLocationLoading());
    final result = await adminLocationRepository.updateLocation(event.id, event.request);
    result.fold(
      (failure) => emit(AdminLocationError(failure)),
      (message) {
        emit(AdminLocationSuccess(message));
        add(GetAllLocationsEvent());
      },
    );
  }

  Future<void> _onDelete(DeleteLocationEvent event, Emitter<AdminLocationState> emit) async {
    emit(AdminLocationLoading());
    final result = await adminLocationRepository.deleteLocation(event.id);
    result.fold(
      (failure) => emit(AdminLocationError(failure)),
      (message) {
        emit(AdminLocationSuccess(message));
        add(GetAllLocationsEvent());
      },
    );
  }
}
