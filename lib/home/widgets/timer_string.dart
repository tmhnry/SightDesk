import 'package:flutter/material.dart';

class TimerString extends StatefulWidget {
  final Duration duration;
  const TimerString(this.duration, {Key? key}) : super(key: key);

  @override
  _TimerStringState createState() => _TimerStringState();
}

class _TimerStringState extends State<TimerString>
    with TickerProviderStateMixin {
  late final AnimationController _controller;
  String get timerString {
    Duration duration = _controller.duration! * _controller.value;
    if (duration.inDays > 1) {
      return '${duration.inDays} days  ${(duration.inHours % 24).toString().padLeft(2, '0')} hours  ${(duration.inMinutes % 60).toString().padLeft(2, '0')} min';
    }
    return '${duration.inHours}:${(duration.inMinutes % 60).toString().padLeft(2, '0')}:${(duration.inSeconds % 60).toString().padLeft(2, '0')}';
  }

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
    );
    _controller.reverse(from: 1.0);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return FittedBox(
          child: new Text(
            _controller.value == 0 ? 'Start Exam' : timerString,
            style: TextStyle(
              color: Color.fromRGBO(255, 255, 255, 0.667),
              fontSize: 18,
            ),
          ),
        );
      },
    );
  }
}
