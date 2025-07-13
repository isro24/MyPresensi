import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:my_presensi/data/models/response/admin/admin_employee_attendance_response_model.dart';
import 'package:my_presensi/data/repository/admin/admin_employee_attendance_repository.dart';
import 'package:printing/printing.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:flutter/services.dart';

part 'employee_attendance_event.dart';
part 'employee_attendance_state.dart';

class EmployeeAttendanceBloc extends Bloc<EmployeeAttendanceEvent, EmployeeAttendanceState> {
  final AdminEmployeeAttendanceRepository adminEmployeeAttendanceRepository;

  EmployeeAttendanceBloc(this.adminEmployeeAttendanceRepository) : super(EmployeeAttendanceInitial()) {
    on<GetAllEmployeeAttendanceEvent>((event, emit) async {
      emit(EmployeeAttendanceLoading());
      final result = await adminEmployeeAttendanceRepository.getAllEmployeeAttendance();

      result.fold(
        (error) => emit(EmployeeAttendanceError(error)),
        (data) => emit(EmployeeAttendanceLoaded(data)),
      );
    });

    on<DeleteEmployeeAttendanceEvent>((event, emit) async {
      emit(EmployeeAttendanceLoading());
      final result = await adminEmployeeAttendanceRepository.deleteAttendance(event.id);

      result.fold(
        (error) => emit(EmployeeAttendanceError(error)),
        (message) => emit(EmployeeAttendanceDeleted(message)),
      );
    });

    on<ExportEmployeeAttendanceToPdfEvent>((event, emit) async {
    try {
      final pdf = pw.Document();

      final fontRegular = pw.Font.ttf(await rootBundle.load('assets/fonts/Roboto-Regular.ttf'));
      final fontBold = pw.Font.ttf(await rootBundle.load('assets/fonts/Roboto-Bold.ttf'));

      pdf.addPage(
        pw.MultiPage(
          theme: pw.ThemeData.withFont(
            base: fontRegular,
            bold: fontBold,
          ),
          build: (context) => [
            pw.Text(
              'Laporan Presensi Karyawan',
              style: pw.TextStyle(fontSize: 20, fontWeight: pw.FontWeight.bold),
            ),
            pw.SizedBox(height: 16),
            pw.TableHelper.fromTextArray(
              headers: ['No', 'Nama', 'NIP'],
              data: List.generate(event.data.length, (i) {
                final e = event.data[i];
                return [
                  (i + 1).toString(),
                  e.name,
                  e.nip,
                ];
              }),
            ),
          ],
        ),
      );

    await Printing.sharePdf(
      bytes: await pdf.save(),
      filename: 'presensi_karyawan.pdf',
    );


      emit(EmployeeAttendanceExportedToPdf());
    } catch (e, stackTrace) {
      debugPrint('Error saat export PDF: $e');
      debugPrintStack(stackTrace: stackTrace);
      emit(EmployeeAttendanceError('Gagal mengekspor PDF: ${e.toString()}'));
    }
  });
  }
}
