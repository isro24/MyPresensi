import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_presensi/data/repository/employee/employee_attendance_repository.dart';
import 'package:my_presensi/presentation/employee/attendance/employee_attendance_camera.dart';
import 'package:permission_handler/permission_handler.dart';

part 'camera_event.dart';
part 'camera_state.dart';

class CameraBloc extends Bloc<CameraEvent, CameraState> {
  final EmployeeAttendanceRepository employeeAttendanceRepository;
  late final List<CameraDescription> _cameras;

  CameraBloc({required this.employeeAttendanceRepository}) : super(CameraInitial()) {
    on<InitializeCamera>(_onInit);
    on<SwitchCamera>(_onSwitch);
    on<ToggleFlash>(_onToggleFlash);
    on<TakePicture>(_onTakePicture);
    on<TapToFocus>(_onTapToFocus);
    on<OpenCameraAndCapture>(_onOpenCamera);
    on<DeleteImage>(_onDeleteImage);
    on<ClearSnackbar>(_onClearSnackbar);
    on<RequestPermissions>(_onRequestPermissions);
  }

  Future<void> _onInit(InitializeCamera event, Emitter<CameraState> emit) async {
    _cameras = await availableCameras();
    await _setupController(emit, 1);
  }

  Future<void> _onSwitch(SwitchCamera event, Emitter<CameraState> emit) async {
    if (state is! CameraReady) return;
    final s = state as CameraReady;
    final next = (s.selectedIndex + 1) % _cameras.length;
    await _setupController(emit, next, previous: s);
  }

  Future<void> _onToggleFlash(ToggleFlash event, Emitter<CameraState> emit) async {
    if (state is! CameraReady) return;
    final s = state as CameraReady;
    final next = s.flashMode == FlashMode.off
        ? FlashMode.auto
        : s.flashMode == FlashMode.auto
            ? FlashMode.always
            : FlashMode.off;
    await s.controller.setFlashMode(next);
    emit(s.copyWith(flashMode: next));
  }

  Future<void> _onTakePicture(TakePicture event, Emitter<CameraState> emit) async {
    if (state is! CameraReady) return;
    final s = state as CameraReady;
    final file = await s.controller.takePicture();
    event.onPictureTaken(File(file.path));
  }

  Future<void> _onTapToFocus(TapToFocus event, Emitter<CameraState> emit) async {
    if (state is! CameraReady) return;
    final s = state as CameraReady;
    final relative = Offset(
      event.position.dx / event.previewSize.width,
      event.position.dy / event.previewSize.height,
    );
    await s.controller.setFocusPoint(relative);
    await s.controller.setExposurePoint(relative);
  }

  Future<void> _onOpenCamera(OpenCameraAndCapture event, Emitter<CameraState> emit) async {
    if (state is! CameraReady) {
      return;
    }
    await Navigator.push<File?>(
      event.context,
      MaterialPageRoute(
        builder: (_) => BlocProvider.value(
          value: this,
          child: const EmployeeAttendanceCamera(),
        ),
      ),
    );
  }

  Future<void> _onDeleteImage(DeleteImage event, Emitter<CameraState> emit) async {
    if (state is! CameraReady) return;
    final s = state as CameraReady;
    await s.imageFile?.delete();
    emit(CameraReady(
      controller: s.controller,
      selectedIndex: s.selectedIndex,
      flashMode: s.flashMode,
      imageFile: null,
      snackbarMessage: 'Gambar dihapus',
    ));
  }

  Future<void> _onClearSnackbar(ClearSnackbar event, Emitter<CameraState> emit) async {
    if (state is! CameraReady) return;
    emit((state as CameraReady).copyWith(
      snackbarMessage: null,
      clearSnackbar: true,
    ));
  }

  Future<void> _setupController(
    Emitter<CameraState> emit,
    int index, {
    CameraReady? previous,
  }) async {
    await previous?.controller.dispose();
    final controller = CameraController(
      _cameras[index],
      ResolutionPreset.max,
      enableAudio: false,
    );
    await controller.initialize();
    await controller.setFlashMode(previous?.flashMode ?? FlashMode.off);
    emit(CameraReady(
      controller: controller,
      selectedIndex: index,
      flashMode: previous?.flashMode ?? FlashMode.off,
      imageFile: previous?.imageFile,
      snackbarMessage: null,
    ));
  }

  @override
  Future<void> close() async {
    if (state is CameraReady) {
      await (state as CameraReady).controller.dispose();
    }
    return super.close();
  }

  Future<void> _onRequestPermissions(RequestPermissions event, Emitter<CameraState> emit) async {
    final statuses = await [
      Permission.camera,
      Permission.storage,
      Permission.manageExternalStorage,
    ].request();

    final denied = statuses.entries.where((e) => !e.value.isGranted).toList();
    if (denied.isNotEmpty && state is CameraReady) {
      emit((state as CameraReady).copyWith(
        snackbarMessage: 'Izin kamera atau penyimpanan ditolak.',
      ));
    }
  }
}
