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
  List<Stroke> lines = <Stroke>[];
  Stroke? line;
  StreamController<Stroke> currentLineStreamController = StreamController<Stroke>.broadcast();
  StreamController<List<Stroke>> linesStreamController = StreamController<List<Stroke>>.broadcast();


  /*Future<void> updateSizeOption(double size) async {
    setState(() {
      widget.options.value.size = size;
    });
  }*/

  void onPanStart(DragStartDetails details) {
    final box = context.findRenderObject() as RenderBox;
    final offset = box.globalToLocal(details.globalPosition);
    final point = Point(offset.dx, offset.dy);
    final points = [point];
    line = Stroke(points);
    currentLineStreamController.add(line!);
  }

  void onPanUpdate(DragUpdateDetails details) {
    final box = context.findRenderObject() as RenderBox;
    final offset = box.globalToLocal(details.globalPosition);
    final point = Point(offset.dx, offset.dy);
    final points = [...line!.points, point];
    line = Stroke(points);
    currentLineStreamController.add(line!);
  }

  void onPanEnd(DragEndDetails details) {
    lines = List.from(lines)..add(line!);
    linesStreamController.add(lines);
  }

  Widget buildCurrentPath(BuildContext context) {
    final settingsProvider = Provider.of<StrokeOptions>(context);

    return GestureDetector(
      onPanStart: onPanStart,
      onPanUpdate: onPanUpdate,
      onPanEnd: onPanEnd,
      child: RepaintBoundary(
        child: SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: StreamBuilder<Stroke>(
                stream: currentLineStreamController.stream,
                builder: (context, snapshot) {
                  return CustomPaint(
                    painter: Sketcher(
                      lines: line == null ? [] : [line!],
                      options: settingsProvider,
                    ),
                  );
                })),
      ),
    );
  }

  Widget buildAllPaths(BuildContext context) {
    final settingsProvider = Provider.of<StrokeOptions>(context);

    return RepaintBoundary(
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: StreamBuilder<List<Stroke>>(
          stream: linesStreamController.stream,
          builder: (context, snapshot) {
            return CustomPaint(
              painter: Sketcher(
                lines: lines,
                options: settingsProvider,
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
