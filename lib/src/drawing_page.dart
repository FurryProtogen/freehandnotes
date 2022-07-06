import 'dart:async';

import 'package:flutter/material.dart';
import 'package:perfect_freehand/perfect_freehand.dart';
import 'package:provider/provider.dart';

import "sketcher.dart";
import "stroke.dart";
import 'stroke_options.dart';

class DrawingPage extends StatefulWidget {
  const DrawingPage({Key? key}) : super(key: key);

  @override
  State<DrawingPage> createState() => _DrawingPageState();
}

class _DrawingPageState extends State<DrawingPage> {
  StreamController<Stroke> currentLineStreamController = StreamController<Stroke>.broadcast();
  StreamController<List<Stroke>> linesStreamController = StreamController<List<Stroke>>.broadcast();

  void onScaleStart(ScaleStartDetails details) {
    final StrokeOptions provider = Provider.of<StrokeOptions>(context, listen: false);
    final box = context.findRenderObject() as RenderBox;
    final offset = box.globalToLocal(details.focalPoint);
    final point = Point(offset.dx, offset.dy);
    final points = [point];
    provider.line = Stroke(points);
    currentLineStreamController.add(provider.line!);
  }

  void onScaleUpdate(ScaleUpdateDetails details) {
    final StrokeOptions provider = Provider.of<StrokeOptions>(context, listen: false);
    final box = context.findRenderObject() as RenderBox;
    final offset = box.globalToLocal(details.focalPoint);
    final point = Point(offset.dx, offset.dy);
    final points = [...provider.line!.points, point];
    provider.line = Stroke(points);
    currentLineStreamController.add(provider.line!);
  }

  void onScaleEnd(ScaleEndDetails details) {
    final StrokeOptions provider = Provider.of<StrokeOptions>(context, listen: false);
    provider.lines = List.from(provider.lines)..add(provider.line!);
    linesStreamController.add(provider.lines);
  }

  Widget buildCurrentPath(BuildContext context) {
    final StrokeOptions provider = Provider.of<StrokeOptions>(context);
    return GestureDetector(
      onScaleStart: onScaleStart,
      onScaleUpdate: onScaleUpdate,
      onScaleEnd: onScaleEnd,
      child: RepaintBoundary(
        child: SizedBox.expand(
            child: StreamBuilder<Stroke>(
                stream: currentLineStreamController.stream,
                builder: (context, snapshot) {
                  return CustomPaint(
                    painter: Sketcher(
                      lines: provider.line == null ? [] : [provider.line!],
                      options: provider,
                    ),
                  );
                })),
      ),
    );
  }

  Widget buildAllPaths(BuildContext context) {
    return RepaintBoundary(
      child: SizedBox.expand(
        child: StreamBuilder<List<Stroke>>(
          stream: linesStreamController.stream,
          builder: (context, snapshot) {
            return CustomPaint(
              painter: Sketcher(
                options: Provider.of<StrokeOptions>(context),
              ),
            );
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          buildAllPaths(context),
          buildCurrentPath(context),
        ],
      ),
    );
  }

  @override
  void dispose() {
    linesStreamController.close();
    currentLineStreamController.close();
    super.dispose();
  }
}
