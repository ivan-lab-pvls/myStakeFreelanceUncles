import 'dart:math';

import 'package:flutter/material.dart';

class FlipCardController {
  FlipCardWidgetState? _state;

  Future flipCard() async => _state?.flipCard();
  Future flipbackCard() async => _state?.flipbackCard();
}

class FlipCardWidget extends StatefulWidget {
  final FlipCardController controller;
  final Widget back;
  final Widget front;

  const FlipCardWidget(
      {super.key,
      required this.back,
      required this.front,
      required this.controller});

  @override
  State<FlipCardWidget> createState() => FlipCardWidgetState();
}

class FlipCardWidgetState extends State<FlipCardWidget>
    with TickerProviderStateMixin {
  late AnimationController controller;
  bool isFront = true;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
        duration: const Duration(milliseconds: 500), vsync: this);

    widget.controller._state = this;
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  Future flipCard() async {
    await controller.forward();

    isFront = !isFront;

  }
  Future flipbackCard() async {
    isFront = !isFront;
    await controller.reverse();
    print('object');
    //controller.reset();
  }

  @override
  Widget build(BuildContext context) => AnimatedBuilder(
        animation: controller,
        builder: (context, child) {
          final angle = controller.value * -pi;
          final transform = Matrix4.identity()
            ..setEntry(3, 2, 0.001)
            ..rotateY(angle);
          return Transform(
              transform: transform,
              alignment: Alignment.center,
              child: isFrontImage(angle.abs())
                  ? widget.front
                  : Transform(
                      transform: Matrix4.identity()..rotateY(pi),
                      alignment: Alignment.center,
                      child: widget.back,
                    ),
          );
        },
      );

  bool isFrontImage(double angle) {
    final degrees90 = pi / 2;
    final degrees270 = 3 * pi / 2;
    return angle <= degrees90 || angle >= degrees270;
  }
}
