import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:freehandnotes/freehandnotes.dart';
import 'package:freehandnotes/src/stroke_options.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<StrokeOptions>(
      create: (_) => StrokeOptions(),
      child: MaterialApp(
        title: 'Freehand Notes Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          useMaterial3: true,
        ),
        home: Scaffold(
          appBar: AppBar(title: const Text("Freehand Notes Demo"),),
          body: const FreehandNotesPage(),
        ),
      ),
    );
  }
}
