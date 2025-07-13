import 'dart:async';
import 'dart:math';
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
  Duration _total = const Duration(hours: 8); // default 8 jam kerja

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
      _total = endTime.difference(DateTime(now.year, now.month, now.day));
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  double get _progress {
    if (_total.inSeconds == 0) return 0;
    return 1 - (_remaining.inSeconds / _total.inSeconds).clamp(0.0, 1.0);
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
        const SizedBox(height: 12),
        SizedBox(
          width: 120,
          height: 120,
          child: Stack(
            alignment: Alignment.center,
            children: [
              CustomPaint(
                size: const Size(120, 120),
                painter: _CirclePainter(
                  progress: _progress,
                  color: isFinished ? Colors.grey : Colors.redAccent,
                ),
              ),
              Text(
                _remaining.formatHHMMSS,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: isFinished ? Colors.grey : Colors.black,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _CirclePainter extends CustomPainter {
  final double progress;
  final Color color;

  _CirclePainter({required this.progress, required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final center = size.center(Offset.zero);
    final radius = size.width / 2;

    final backgroundPaint = Paint()
      ..color = Colors.grey.shade300
      ..strokeWidth = 8
      ..style = PaintingStyle.stroke;

    final progressPaint = Paint()
      ..color = color
      ..strokeWidth = 8
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    canvas.drawCircle(center, radius, backgroundPaint);

    final angle = 2 * pi * progress;
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -pi / 2,
      angle,
      false,
      progressPaint,
    );
  }

  @override
  bool shouldRepaint(covariant _CirclePainter oldDelegate) {
    return oldDelegate.progress != progress || oldDelegate.color != color;
  }
}
