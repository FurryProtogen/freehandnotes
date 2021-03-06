import 'package:flutter/material.dart';
import 'package:freehandnotes/src/drawing_page.dart';
import 'package:freehandnotes/src/stroke_options.dart';

class FreehandNotes extends StatelessWidget {
  const FreehandNotes({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const DrawingPage();
  }
}


class FreehandNotesOptionsFAB extends StatefulWidget {
  final Color? buttonColor;
  final Color? iconColor;

  final String? stringSettings;
  final String? stringSize;
  final String? stringThinning;
  final String? stringAdvancedSettings;
  final String? stringStreamline;
  final String? stringSmoothing;
  final String? stringTaperStart;
  final String? stringTaperEnd;
  final String? stringClear;
  final String? stringResetSettings;

  const FreehandNotesOptionsFAB({Key? key, this.buttonColor, this.iconColor, this.stringSettings, this.stringSize, this.stringThinning, this.stringAdvancedSettings, this.stringStreamline, this.stringSmoothing, this.stringTaperStart, this.stringTaperEnd, this.stringClear, this.stringResetSettings}) : super(key: key);

  @override
  State<FreehandNotesOptionsFAB> createState() => _FreehandNotesOptionsFABState();
}

class _FreehandNotesOptionsFABState extends State<FreehandNotesOptionsFAB> {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: widget.buttonColor,
      onPressed: (){
        showModalBottomSheet(
          context: context,
          shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(30),),),
          isScrollControlled: true,
          isDismissible: true,
          enableDrag: true,
          constraints: const BoxConstraints(
            maxWidth: 500,
            minHeight: 300,
          ),
          builder: (context) {
            return _BottomSheet(
              strokeOptionsSliders: StrokeOptionsSliders(
                stringSize: widget.stringSize,
                stringThinning: widget.stringThinning,
                stringAdvancedSettings: widget.stringAdvancedSettings,
                stringStreamline: widget.stringStreamline,
                stringSmoothing: widget.stringSmoothing,
                stringTaperStart: widget.stringTaperStart,
                stringTaperEnd: widget.stringTaperEnd,
                stringClear: widget.stringClear,
                stringResetSettings: widget.stringResetSettings,
              ),
              stringSettings: widget.stringSettings,
            );
          },
        );
      },
      child: Icon(Icons.edit, color: widget.iconColor,),
    );
  }
}

class _BottomSheet extends StatefulWidget {
  final Widget strokeOptionsSliders;
  final String? stringSettings;
  const _BottomSheet({Key? key, required this.strokeOptionsSliders, this.stringSettings}) : super(key: key);

  @override
  State<_BottomSheet> createState() => _BottomSheetState();
}

class _BottomSheetState extends State<_BottomSheet> {
  bool isFullScreen = false;
  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder(
      tween: Tween<double>(begin: isFullScreen ? MediaQuery.of(context).size.height*.7 : 0, end: isFullScreen ? MediaQuery.of(context).size.height-40 : MediaQuery.of(context).size.height*.7),
      curve: Curves.easeInOut,
      duration: Duration(milliseconds: isFullScreen ? 85 : 85),
      builder: (context, double i, child) {
        return SizedBox(
          height: i,
          child: child,
        );
      },
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 8, top: 8, left: 16),
            child:  Row(
              children: [
                Expanded(
                  child: SizedBox(
                    height: 30,
                    child: Text(widget.stringSettings ?? 'settings', style: const TextStyle(fontSize: 20,)),
                  ),
                ),
                IconButton(
                  onPressed: (){setState(() {
                    isFullScreen = !isFullScreen;
                  });},
                  icon: const Icon(Icons.fullscreen, size: 30,),
                ),
                IconButton(
                  onPressed: (){Navigator.pop(context);},
                  icon: const Icon(Icons.close, size: 30,),
                ),
              ],
            ),
          ),
          const Divider(thickness: 2,),
          Expanded(
            child:  Padding(
              padding: const EdgeInsets.fromLTRB(8,0,8,0),
              child: widget.strokeOptionsSliders,
            ),
          ),
        ],
      ),
    );
  }
}
