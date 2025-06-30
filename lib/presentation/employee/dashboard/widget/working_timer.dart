import 'dart:async';
import 'package:flutter/material.dart';
import 'package:my_presensi/core/extension/extension.dart';

class WorkingTimer extends StatefulWidget {
  final String? endTimeString; 

  const WorkingTimer({super.key, this.endTimeString});

  @override
  State<WorkingTimer> createState() => _WorkingTimerState();
}

class _WorkingTimerState extends State<WorkingTimer> {
  Timer? _timer;
  Duration _remaining = Duration.zero;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    _updateTime();
    _timer = Timer.periodic(const Duration(seconds: 1), (_) => _updateTime());
  }

  void _updateTime() {
    if (widget.endTimeString == null) return;

    final now = DateTime.now();
    final parts = widget.endTimeString!.split(":").map(int.parse).toList();
    final endTime = DateTime(now.year, now.month, now.day, parts[0], parts[1], parts[2]);
    final diff = endTime.difference(now);

    setState(() {
      _remaining = diff.isNegative ? Duration.zero : diff;
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.endTimeString == null) return const SizedBox();

    final isFinished = _remaining == Duration.zero;

    return Column(
      children: [
        Text(
          isFinished ? 'Waktu Kerja Selesai' : 'Sisa Waktu Kerja',
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 4),
        Text(
          _remaining.formatHHMMSS,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: isFinished ? Colors.grey : Colors.red,
          ),
        ),
      ],
    );
  }
}
