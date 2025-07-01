import 'package:intl/intl.dart';

extension DateTimeExt on DateTime {
  String get formatTanggal {
    const hariIndo = [
      'Minggu', 'Senin', 'Selasa', 'Rabu', 'Kamis', 'Jumat', 'Sabtu'
    ];
    const bulanIndo = [
      '', 'Januari', 'Februari', 'Maret', 'April', 'Mei', 'Juni',
      'Juli', 'Agustus', 'September', 'Oktober', 'November', 'Desember'
    ];

    final hari = hariIndo[weekday % 7]; 
    return '$hari, $day ${bulanIndo[month]} $year';
  }

  String get formatJam {
    final jam = hour.toString().padLeft(2, '0');
    final menit = minute.toString().padLeft(2, '0');
    return '$jam:$menit WIB';
  }
}

extension TimeFormatExt on String {
  String get formatJamWIB {
    try {
      final parsedTime = DateFormat("HH:mm:ss").parse(this);
      return '${DateFormat("HH.mm").format(parsedTime)} WIB';
    } catch (e) {
      return this;
    }
  }
}

extension DurationFormatter on Duration {
  String get formatHHMMSS {
    final hours = inHours.toString().padLeft(2, '0');
    final minutes = inMinutes.remainder(60).toString().padLeft(2, '0');
    final seconds = inSeconds.remainder(60).toString().padLeft(2, '0');
    return '$hours:$minutes:$seconds';
  }
}


