import 'package:flutter/material.dart';
import 'package:freehandnotes/freehandnotes.dart';

class FreehandNotesPage extends StatelessWidget {
  const FreehandNotesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: FreehandNotes(),
      floatingActionButton: FreehandNotesOptionsFAB(),
    );
  }
}
