import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'yvlym',
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin<HomePage> {
  late AnimationController controller;
  late Animation<double> animation;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1100),
    );
    animation = TweenSequence<double>([
      TweenSequenceItem(
        tween: Tween(begin: 0.0, end: 1.0),
        weight: 0.5,
      ),
      TweenSequenceItem(
        tween: Tween(begin: 1.0, end: 0.0),
        weight: 0.5,
      )
    ]).animate(controller);
  }

  @override
  void dispose() {
    controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Background(animation: animation),
          Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: const EdgeInsets.only(
                top: 19,
                left: 19,
              ),
              child: SunAndMoon(animation: animation),
            ),
          ),
          Positioned(
            top: 13,
            right: -7,
            child: Cloud(
              animation: animation,
            ),
          ),
          Positioned(
            bottom: 32,
            left: -13,
            child: Cloud2(
              animation: animation,
            ),
          ),
          Positioned(
            top: 230,
            right: -64,
            child: Cloud3(
              animation: animation,
            ),
          ),
          Positioned(
            top: 350,
            left: -19,
            child: Cloud3(
              animation: animation,
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: const EdgeInsets.only(
                bottom: 19,
                right: 19,
              ),
              child: Knob(controller: controller),
            ),
          ),
          const Greeting(),
        ],
      ),
    );
  }
}

class Greeting extends StatelessWidget {
  const Greeting({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder(
      duration: const Duration(milliseconds: 2400),
      tween: Tween<double>(begin: 1.0, end: 0.0),
      curve: const Interval(0.75, 1.0, curve: Curves.ease),
      child: Container(
        color: Colors.white,
        alignment: Alignment.center,
        child: SizedBox(
          height: 40,
          width: 120,
          child: Stack(
            alignment: Alignment.center,
            children: [
              TweenAnimationBuilder<double>(
                duration: const Duration(milliseconds: 900),
                tween: Tween<double>(begin: -90.0, end: 0.0),
                curve: Curves.ease,
                child: const Align(
                  alignment: Alignment.center,
                  child: Text(
                    '/fraeme',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                builder: (context, top, child) {
                  return Positioned.fill(
                    top: top,
                    child: child!,
                  );
                },
              ),
              TweenAnimationBuilder<double>(
                duration: const Duration(milliseconds: 1800),
                tween: Tween<double>(begin: -240.0, end: 0.0),
                curve: const Interval(0.5, 1.0, curve: Curves.easeInOutCirc),
                child: Align(
                  alignment: Alignment.center,
                  child: Container(
                    width: 120,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      border: Border(
                        left: BorderSide(
                          width: 5,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ),
                builder: (context, right, child) {
                  return Positioned.fill(
                    right: right,
                    child: child!,
                  );
                },
              ),
            ],
          ),
        ),
      ),
      builder: (context, opacity, child) {
        return opacity != .0
            ? Opacity(opacity: opacity, child: child)
            : Visibility(visible: false, child: child!);
      },
    );
  }
}

class Background extends StatelessWidget {
  Background({
    super.key,
    required this.animation,
  })  : primary = ColorTween(
          begin: Colors.white,
          end: Colors.black,
        ).chain(CurveTween(curve: Curves.ease)).animate(animation),
        secondary = ColorTween(
          begin: Colors.black,
          end: Colors.white,
        ).chain(CurveTween(curve: Curves.ease)).animate(animation);

  final Animation<double> animation;
  final Animation<Color?> primary;
  final Animation<Color?> secondary;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animation,
      builder: (context, child) {
        return Container(
          padding: const EdgeInsets.all(19),
          color: primary.value,
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: secondary.value!,
                width: 3,
              ),
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(19.0),
                topRight: Radius.circular(19.0),
              ),
            ),
          ),
        );
      },
    );
  }
}

class Cloud extends StatelessWidget {
  Cloud({super.key, required this.animation})
      : primary = ColorTween(
          begin: Colors.white,
          end: Colors.black,
        ).chain(CurveTween(curve: Curves.ease)).animate(animation),
        secondary = ColorTween(
          begin: Colors.black,
          end: Colors.white,
        ).chain(CurveTween(curve: Curves.ease)).animate(animation);

  final Animation<double> animation;
  final Animation<Color?> primary;
  final Animation<Color?> secondary;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      width: 300,
      child: AnimatedBuilder(
          animation: animation,
          builder: (context, _) {
            return Column(
              children: [
                Expanded(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Expanded(
                        flex: 7,
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              width: 0.0,
                              style: BorderStyle.none,
                            ),
                            color: secondary.value,
                            borderRadius: BorderRadius.circular(100),
                          ),
                        ),
                      ),
                      const Spacer(flex: 1),
                      Expanded(
                        flex: 2,
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              width: 0.0,
                              style: BorderStyle.none,
                            ),
                            color: secondary.value,
                            borderRadius: BorderRadius.circular(100),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const Spacer(flex: 2),
                      Expanded(
                        flex: 3,
                        child: _ConcaveCloud(
                          primary: primary.value!,
                          secondary: secondary.value!,
                        ),
                      ),
                      const Spacer(flex: 5),
                    ],
                  ),
                ),
                Expanded(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Expanded(
                        flex: 1,
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              width: 0.0,
                              style: BorderStyle.none,
                            ),
                            color: secondary.value,
                            borderRadius: BorderRadius.circular(200),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const Spacer(flex: 6),
                      Expanded(
                        flex: 2,
                        child: _ConcaveCloud(
                          primary: primary.value!,
                          secondary: secondary.value!,
                        ),
                      ),
                      const Spacer(flex: 2),
                    ],
                  ),
                ),
                Expanded(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const Spacer(flex: 1),
                      Expanded(
                        flex: 3,
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              width: 0.0,
                              style: BorderStyle.none,
                            ),
                            color: secondary.value,
                            borderRadius: BorderRadius.circular(200),
                          ),
                        ),
                      ),
                      const Spacer(flex: 1),
                      Expanded(
                        flex: 5,
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              width: 0.0,
                              style: BorderStyle.none,
                            ),
                            color: secondary.value,
                            borderRadius: BorderRadius.circular(200),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          }),
    );
  }
}

class Cloud2 extends StatelessWidget {
  Cloud2({super.key, required this.animation})
      : primary = ColorTween(
          begin: Colors.white,
          end: Colors.black,
        ).chain(CurveTween(curve: Curves.ease)).animate(animation),
        secondary = ColorTween(
          begin: Colors.black,
          end: Colors.white,
        ).chain(CurveTween(curve: Curves.ease)).animate(animation);

  final Animation<double> animation;
  final Animation<Color?> primary;
  final Animation<Color?> secondary;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      width: 300,
      child: AnimatedBuilder(
          animation: animation,
          builder: (context, _) {
            return Column(
              children: [
                Expanded(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Expanded(
                        flex: 4,
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              width: 0.0,
                              style: BorderStyle.none,
                            ),
                            color: secondary.value,
                            borderRadius: BorderRadius.circular(100),
                          ),
                        ),
                      ),
                      const Spacer(flex: 2),
                      Expanded(
                        flex: 4,
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              width: 0.0,
                              style: BorderStyle.none,
                            ),
                            color: secondary.value,
                            borderRadius: BorderRadius.circular(100),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const Spacer(flex: 1),
                      Expanded(
                        flex: 2,
                        child: _ConcaveCloud(
                          primary: primary.value!,
                          secondary: secondary.value!,
                        ),
                      ),
                      const Spacer(flex: 4),
                      Expanded(
                        flex: 2,
                        child: _ConcaveCloud(
                          primary: primary.value!,
                          secondary: secondary.value!,
                        ),
                      ),
                      const Spacer(flex: 1),
                    ],
                  ),
                ),
                Expanded(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Expanded(
                        flex: 1,
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              width: 0.0,
                              style: BorderStyle.none,
                            ),
                            color: secondary.value,
                            borderRadius: BorderRadius.circular(200),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const Spacer(flex: 4),
                      Expanded(
                        flex: 2,
                        child: _ConcaveCloud(
                          primary: primary.value!,
                          secondary: secondary.value!,
                        ),
                      ),
                      const Spacer(flex: 4),
                    ],
                  ),
                ),
                Expanded(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Expanded(
                        flex: 7,
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              width: 0.0,
                              style: BorderStyle.none,
                            ),
                            color: secondary.value,
                            borderRadius: BorderRadius.circular(200),
                          ),
                        ),
                      ),
                      const Spacer(flex: 3),
                    ],
                  ),
                ),
              ],
            );
          }),
    );
  }
}

class Cloud3 extends StatelessWidget {
  Cloud3({super.key, required this.animation})
      : primary = ColorTween(
          begin: Colors.white,
          end: Colors.black,
        ).chain(CurveTween(curve: Curves.ease)).animate(animation),
        secondary = ColorTween(
          begin: Colors.black,
          end: Colors.white,
        ).chain(CurveTween(curve: Curves.ease)).animate(animation);

  final Animation<double> animation;
  final Animation<Color?> primary;
  final Animation<Color?> secondary;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 70,
      width: 300,
      child: AnimatedBuilder(
          animation: animation,
          builder: (context, _) {
            return Column(
              children: [
                Expanded(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const Spacer(flex: 1),
                      Expanded(
                        flex: 8,
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              width: 3.0,
                              style: BorderStyle.none,
                            ),
                            color: secondary.value,
                            borderRadius: BorderRadius.circular(100),
                          ),
                        ),
                      ),
                      const Spacer(flex: 1),
                    ],
                  ),
                ),
                Expanded(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const Spacer(flex: 4),
                      Expanded(
                        flex: 4,
                        child: _ConcaveCloud(
                          primary: primary.value!,
                          secondary: secondary.value!,
                        ),
                      ),
                      const Spacer(flex: 2),
                    ],
                  ),
                ),
                Expanded(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Expanded(
                        flex: 2,
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              width: 0.0,
                              style: BorderStyle.none,
                            ),
                            color: secondary.value,
                            borderRadius: BorderRadius.circular(200),
                          ),
                        ),
                      ),
                      const Spacer(flex: 1),
                      Expanded(
                        flex: 7,
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              width: 0.0,
                              style: BorderStyle.none,
                            ),
                            color: secondary.value,
                            borderRadius: BorderRadius.circular(200),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          }),
    );
  }
}

class _ConcaveCloud extends StatelessWidget {
  const _ConcaveCloud({
    Key? key,
    required this.primary,
    required this.secondary,
  }) : super(key: key);

  final Color primary;
  final Color secondary;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(
            width: 0.0,
            color: secondary,
          ),
          bottom: BorderSide(
            width: 0.0,
            color: secondary,
          ),
        ),
      ),
      child: ClipRect(
        child: CustomPaint(
          painter: _ConcaveCloudPaint(
            primary,
            secondary,
          ),
        ),
      ),
    );
  }
}

class _ConcaveCloudPaint extends CustomPainter {
  final Color primary;
  final Color secondary;

  _ConcaveCloudPaint(this.primary, this.secondary);

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawPaint(Paint()..color = secondary);

    final paint = Paint()..color = primary;
    final rightRect = Rect.fromCenter(
      center: Offset(size.width, size.height / 2),
      width: size.height,
      height: size.height,
    );
    canvas.drawArc(rightRect, pi / 2, pi, false, paint);
    final leftRect = Rect.fromCenter(
      center: Offset(0.0, size.height / 2),
      width: size.height,
      height: size.height,
    );
    canvas.drawArc(leftRect, pi * 1.5, pi, false, paint);
  }

  @override
  bool shouldRepaint(_ConcaveCloudPaint oldDelegate) {
    return oldDelegate.primary != primary || oldDelegate.secondary != secondary;
  }
}

class SunAndMoon extends StatelessWidget {
  SunAndMoon({
    super.key,
    required this.animation,
  })  : positions = Tween(begin: 60.0, end: 0.0)
            .chain(CurveTween(curve: Curves.ease))
            .animate(animation),
        length = Tween(begin: 80.0, end: 111.0)
            .chain(CurveTween(curve: Curves.ease))
            .animate(animation),
        opacity = Tween(begin: 0.0, end: 1.0)
            .chain(
              CurveTween(curve: const Interval(0.6, 0.6, curve: Curves.ease)),
            )
            .animate(animation),
        position = Tween(
          begin: const Offset(0.8, -0.8),
          end: const Offset(0.27, -0.27),
        )
            .chain(CurveTween(
              curve: const Interval(
                0.6,
                1.0,
                curve: Curves.ease,
              ),
            ))
            .animate(animation);

  final Animation<double> animation;
  final Animation<double> positions;
  final Animation<double> length;
  final Animation<double> opacity;
  final Animation<Offset> position;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150,
      width: 150,
      child: Stack(
        children: [
          Flow(
            delegate: _SunAndMoonRingsFlow(position: positions),
            children: List.generate(8, (index) {
              return Container(
                height: 20,
                width: 20,
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(width: 2),
                  borderRadius: BorderRadius.circular(100),
                ),
              );
            }),
          ),
          Center(
            child: AnimatedBuilder(
              animation: length,
              builder: (context, _) {
                return Container(
                  height: length.value,
                  width: length.value,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(width: 2),
                    borderRadius: BorderRadius.circular(100),
                  ),
                );
              },
            ),
          ),
          Center(
            child: FadeTransition(
              opacity: opacity,
              child: SlideTransition(
                position: position,
                child: Container(
                  height: 90,
                  width: 90,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    border: Border.all(
                      width: 0.0,
                      style: BorderStyle.none,
                    ),
                    borderRadius: BorderRadius.circular(100),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class _SunAndMoonRingsFlow extends FlowDelegate {
  _SunAndMoonRingsFlow({
    required this.position,
  }) : super(repaint: position);

  final Animation<double> position;

  @override
  void paintChildren(FlowPaintingContext context) {
    List.generate(context.childCount, (index) {
      return ((2 * pi) / context.childCount) * (index + 1);
    }).asMap().forEach((index, rotation) {
      final parentCenter = Alignment.center.alongSize(context.size);
      final childCenter =
          Alignment.center.alongSize(context.getChildSize(index)!);
      final transform = Matrix4.identity()
        ..translate(
          parentCenter.dx - childCenter.dx,
          parentCenter.dy - childCenter.dy,
        )
        ..rotateZ(rotation)
        ..translate(position.value);

      context.paintChild(
        index,
        transform: Matrix4.identity()
          ..translate(
            childCenter.dx,
            childCenter.dy,
          )
          ..multiply(transform)
          ..translate(
            -childCenter.dx,
            -childCenter.dy,
          ),
      );
    });
  }

  @override
  bool shouldRepaint(_SunAndMoonRingsFlow oldDelegate) {
    return oldDelegate.position != position;
  }
}

class Knob extends StatelessWidget {
  static const Widget frontside = Text(
    '日',
    style: TextStyle(
      color: Colors.black,
      fontSize: 54,
    ),
  );

  static final Widget backside = Transform(
    alignment: Alignment.center,
    transform: Matrix4.identity()..rotateY(pi),
    child: const Text(
      '月',
      style: TextStyle(
        color: Colors.black,
        fontSize: 54,
      ),
    ),
  );

  final AnimationController controller;
  final Animation<double> rotation;

  Knob({
    super.key,
    required this.controller,
  }) : rotation = Tween(
          begin: 0.0,
          end: (2 * pi),
        ).animate(controller);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        if (!controller.isAnimating) {
          if (controller.value == 0.0) {
            await controller.animateTo(0.5, curve: Curves.ease);
          } else if (controller.value == 0.5) {
            await controller.animateTo(1.0, curve: Curves.ease);
          } else if (controller.value == 1.0) {
            controller.value = 0.0;
            await controller.animateTo(0.5, curve: Curves.ease);
          }
        }
      },
      onPanUpdate: (details) async {
        if (!controller.isAnimating) {
          final possibleChange = -(details.delta.dx / 190);
          final possibleTarget = controller.value + possibleChange;
          final backward = possibleChange.isNegative;

          if (backward) {
            if (possibleTarget < controller.lowerBound) {
              await controller.reverse();
              controller.value = controller.upperBound;

              final change = controller.lowerBound - possibleTarget;
              final target = controller.upperBound - change;
              await controller.animateBack(target);
            } else {
              await controller.animateBack(possibleTarget);
            }
          } else {
            if (possibleTarget > controller.upperBound) {
              await controller.forward();
              controller.value = controller.lowerBound;

              final change = possibleTarget - controller.upperBound;
              final target = controller.lowerBound + change;
              await controller.animateTo(target);
            } else {
              await controller.animateTo(possibleTarget);
            }
          }
        }
      },
      onPanEnd: (_) async {
        if (controller.value >= 0.0 && controller.value < 0.25) {
          await controller.animateBack(0.0, curve: Curves.ease);
        } else if (controller.value >= 0.25 && controller.value < 0.5) {
          await controller.animateTo(0.5, curve: Curves.ease);
        } else if (controller.value >= 0.5 && controller.value < 0.75) {
          await controller.animateBack(0.5, curve: Curves.ease);
        } else if (controller.value >= 0.75 && controller.value < 1.0) {
          await controller.animateTo(1.0, curve: Curves.ease);
        }
      },
      child: Container(
        color: Colors.transparent,
        padding: const EdgeInsets.all(16.0),
        margin: const EdgeInsets.only(
          right: 8.0,
          bottom: 8.0,
        ),
        child: AnimatedBuilder(
            animation: rotation,
            builder: (context, _) {
              return Transform(
                alignment: Alignment.center,
                transform: Matrix4.identity()
                  ..setEntry(3, 2, 0.001)
                  ..rotateY(rotation.value),
                child: Transform.rotate(
                  alignment: Alignment.center,
                  angle: 0.0,
                  child: PhysicalModel(
                    color: Colors.black,
                    elevation: 7,
                    shadowColor: Colors.black,
                    borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(19.0),
                      bottomLeft: Radius.circular(19.0),
                    ),
                    child: Container(
                      height: 140,
                      width: 115,
                      decoration: BoxDecoration(
                        border: Border.all(
                          width: 3,
                          color: Colors.black,
                        ),
                        borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(19.0),
                          topRight: Radius.circular(19.0),
                        ),
                        color: Colors.white,
                      ),
                      child: Stack(
                        children: [
                          Align(
                            alignment: Alignment.topRight,
                            child: List.generate(
                              8,
                              (index) => index + 1,
                            ).fold(Container(), (previous, current) {
                              return Container(
                                height: current * 4,
                                width: current * 4,
                                padding: const EdgeInsets.all(2),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    width: 1.0,
                                    color: Colors.black,
                                  ),
                                  borderRadius: BorderRadius.circular(100),
                                ),
                                child: previous,
                              );
                            }),
                          ),
                          Align(
                            alignment: Alignment.bottomLeft,
                            child: List.generate(
                              12,
                              (index) => index + 1,
                            ).fold(Container(), (previous, current) {
                              return Container(
                                height: current * 4,
                                width: current * 4,
                                padding: const EdgeInsets.all(2),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    width: 1.0,
                                    color: Colors.black,
                                  ),
                                  borderRadius: BorderRadius.circular(100),
                                ),
                                child: previous,
                              );
                            }),
                          ),
                          Center(
                            child: controller.value < 0.25 ||
                                    controller.value >= 0.75
                                ? frontside
                                : backside,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            }),
      ),
    );
  }
}
