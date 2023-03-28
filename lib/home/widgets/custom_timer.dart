import 'package:flutter/material.dart';
import 'dart:math' as math;

class CustomTimer extends StatefulWidget {
  CustomTimer({
    this.width,
    this.height,
    this.value,
    required this.duration,
    required this.noStroke,
    required this.noButton,
  });
  final double? width;
  final double? height;
  final double? value;
  final Duration duration;
  final bool noStroke;
  final bool noButton;

  @override
  _CustomTimerState createState() => _CustomTimerState();
}

class _CustomTimerState extends State<CustomTimer>
    with TickerProviderStateMixin {
  late final AnimationController controller;
  String get timerString {
    Duration duration = controller.duration! * controller.value;
    if (duration.inDays > 1) {
      return '${duration.inDays} days  ${(duration.inHours % 24).toString().padLeft(2, '0')} hours  ${(duration.inMinutes % 60).toString().padLeft(2, '0')} min';
    }
    return '${duration.inHours}:${(duration.inMinutes % 60).toString().padLeft(2, '0')}:${(duration.inSeconds % 60).toString().padLeft(2, '0')}';
  }

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: widget.duration,
    );
    final value = widget.value ?? 0.0;
    controller.reverse(from: value);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final globalWidth = MediaQuery.of(context).size.width;
    final width = widget.width ?? globalWidth;
    return Center(
      child: Container(
        padding: EdgeInsets.all(8.0 * width / globalWidth),
        width: width,
        height: widget.height ?? null,
        child: Column(
          children: [
            Expanded(
              child: Align(
                alignment: FractionalOffset.center,
                child: AspectRatio(
                  aspectRatio: 1.0,
                  child: Stack(
                    children: [
                      widget.noStroke
                          ? SizedBox()
                          : Positioned.fill(
                              child: AnimatedBuilder(
                                animation: controller,
                                builder: (context, child) => new CustomPaint(
                                  painter: TimerPainter(
                                    animation: controller,
                                    // backgroundColor: Colors.white,
                                    backgroundColor: Colors.white,
                                    color: Colors.purpleAccent,
                                    scale: width / globalWidth,
                                  ),
                                ),
                              ),
                            ),
                      Align(
                        alignment: FractionalOffset.center,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            widget.noStroke
                                ? SizedBox()
                                : Text(
                                    "Time Left",
                                    style: TextStyle(
                                      fontSize: 60 * width / globalWidth,
                                      // color: Colors.white,
                                      color: Color.fromRGBO(0, 0, 0, 0.33),
                                    ),
                                  ),
                            AnimatedBuilder(
                              animation: controller,
                              builder: (context, child) => FittedBox(
                                child: new Text(
                                  timerString,
                                  style: TextStyle(
                                    // fontFamily: 'Raleway',
                                    // color: Colors.white,
                                    color: Colors.purpleAccent,
                                    fontSize: 80 * width / globalWidth,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            widget.noButton
                ? SizedBox()
                : Container(
                    margin: EdgeInsets.all(8.0 * width / globalWidth),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        FloatingActionButton(
                          onPressed: () {
                            if (controller.isAnimating) {
                              controller.stop();
                            } else {
                              controller.reverse(
                                from: controller.value == 0.0
                                    ? 1.0
                                    : controller.value,
                              );
                            }
                          },
                          child: AnimatedBuilder(
                            animation: controller,
                            builder: (context, child) {
                              return new Icon(
                                controller.isAnimating
                                    ? Icons.pause
                                    : Icons.play_arrow,
                                color: Colors.black,
                                size: 24,
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}

class TimerPainter extends CustomPainter {
  TimerPainter({
    required this.animation,
    required this.backgroundColor,
    required this.color,
    required this.scale,
  }) : super(repaint: animation);
  final double scale;
  final Animation<double> animation;
  final Color backgroundColor, color;

  @override
  bool shouldRepaint(TimerPainter old) {
    return animation.value != old.animation.value ||
        color != old.color ||
        backgroundColor != old.backgroundColor;
  }

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = backgroundColor
      ..strokeWidth = 40.0 * scale
      ..strokeCap = StrokeCap.butt
      ..style = PaintingStyle.stroke;
    canvas.drawCircle(size.center(Offset.zero), size.width / 2.0, paint);
    paint.color = color;
    double progress = (1.0 - animation.value) * 2 * math.pi;
    canvas.drawArc(Offset.zero & size, math.pi * 1.5, -progress, false, paint);
  }
}
