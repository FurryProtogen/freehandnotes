import 'package:flutter/material.dart';
import 'package:freehandnotes/src/stroke.dart';
import 'package:provider/provider.dart';

class StrokeOptionsSliders extends StatefulWidget {
  final String? stringSize;
  final String? stringThinning;
  final String? stringStreamline;
  final String? stringSmoothing;
  final String? stringTaperStart;
  final String? stringTaperEnd;
  final String? stringClear;

  const StrokeOptionsSliders({Key? key, this.stringSize, this.stringThinning, this.stringStreamline, this.stringSmoothing, this.stringTaperStart, this.stringTaperEnd, this.stringClear}) : super(key: key);

  @override
  State<StrokeOptionsSliders> createState() => _StrokeOptionsSlidersState();
}

class _StrokeOptionsSlidersState extends State<StrokeOptionsSliders> {
  @override
  Widget build(BuildContext context) {
    final settingsProvider = Provider.of<StrokeOptions>(context);

    return Scrollbar(
      radius: const Radius.circular(30),
      child: ListView(
        children: [
          SizedBox(
            height: (55 / (MediaQuery.of(context).size.width/55 < colorCards.length ? MediaQuery.of(context).size.width/55 : colorCards.length.toDouble()) / colorCards.length).round()*70,
            child: GridView.count(
              shrinkWrap: true,
              crossAxisCount: (MediaQuery.of(context).size.width/55 < colorCards.length ? MediaQuery.of(context).size.width/55 : colorCards.length).round(),
              physics: const NeverScrollableScrollPhysics(),
              children: colorCards,
            ),
          ),
          const Divider(),
          _MenuSettingText(
            title: widget.stringSize ?? 'size',
            value: settingsProvider.size.round().toString(),
          ),
          Slider(
              value: settingsProvider.size,
              min: 1,
              max: 50,
              divisions: 100,
              label: settingsProvider.size.round().toString(),
              onChanged: (double value) => {
                setState(() {
                  settingsProvider.size = value;
                })
              }),
          _MenuSettingText(
            title: widget.stringThinning ?? 'thinning',
            value: settingsProvider.thinning.toStringAsFixed(2).toString(),
          ),
          Slider(
              value: settingsProvider.thinning,
              min: -1,
              max: 1,
              divisions: 100,
              label: settingsProvider.thinning.toStringAsFixed(2),
              onChanged: (double value) => {
                setState(() {
                  settingsProvider.thinning = value;
                })
              }),
          _MenuSettingText(
            title: widget.stringStreamline ?? 'streamline',
            value: settingsProvider.streamline.toStringAsFixed(2).toString(),
          ),
          Slider(
              value: settingsProvider.streamline,
              min: 0,
              max: 1,
              divisions: 100,
              label: settingsProvider.streamline.toStringAsFixed(2),
              onChanged: (double value) => {
                setState(() {
                  settingsProvider.streamline = value;
                })
              }),
          _MenuSettingText(
            title: widget.stringSmoothing ?? 'smoothing',
            value: settingsProvider.smoothing.toStringAsFixed(2),
          ),
          Slider(
              value: settingsProvider.smoothing,
              min: 0,
              max: 1,
              divisions: 100,
              label: settingsProvider.smoothing.toStringAsFixed(2),
              onChanged: (double value) => {
                setState(() {
                  settingsProvider.smoothing = value;
                })
              }),
          _MenuSettingText(
            title: widget.stringTaperStart ?? 'taper start',
            value: settingsProvider.taperStart.round().toString(),
          ),
          Slider(
              value: settingsProvider.taperStart,
              min: 0,
              max: 100,
              divisions: 100,
              label: settingsProvider.taperStart.round().toString(),
              onChanged: (double value) => {
                setState(() {
                  settingsProvider.taperStart = value;
                })
              }),
          _MenuSettingText(
            title: widget.stringTaperEnd ?? 'taper end',
            value: settingsProvider.taperEnd.round().toString(),
          ),
          Slider(
              value: settingsProvider.taperEnd,
              min: 0,
              max: 100,
              divisions: 100,
              label: settingsProvider.taperEnd.round().toString(),
              onChanged: (double value) => {
                setState(() {
                  settingsProvider.taperEnd = value;
                })
              }),
          Text(
            widget.stringClear ?? 'Clear',
            textAlign: TextAlign.start,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
          ),
          GestureDetector(
            onTap: settingsProvider.clearAll,
            child: const Padding(
              padding: EdgeInsets.symmetric(vertical: 8.0),
              child: CircleAvatar(
                  child: Icon(
                    Icons.delete,
                    size: 20.0,
                    color: Colors.white,
                  )),
            ),
          ),
        ],
      ),
    );
  }

  List<_CardColorPicker> colorCards = const <_CardColorPicker> [
    _CardColorPicker(
      color: Colors.black,
    ),
    _CardColorPicker(
      color: Colors.red,
    ),
    _CardColorPicker(
      color: Colors.orange,
    ),
    _CardColorPicker(
      color: Colors.yellow,
    ),
    _CardColorPicker(
      color: Colors.green,
    ),
    _CardColorPicker(
      color: Colors.blue,
    ),
    _CardColorPicker(
      color: Colors.purple,
    ),
  ];
}

class _MenuSettingText extends StatelessWidget {
  final String title;
  final String value;
  const _MenuSettingText({Key? key, required this.title, required this.value}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        text: title,
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: Colors.black),
        children: <TextSpan> [
          TextSpan(
            text: ' - $value',
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.normal),
          ),
        ],
      ),
    );
  }
}

class _CardColorPicker extends StatelessWidget {
  final Color color;
  const _CardColorPicker({Key? key, required this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 55,
      height: 55,
      child: Card(
        color: color,
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: (){Provider.of<StrokeOptions>(context, listen: false).color = color;},
        ),
      ),
    );
  }
}

class StrokeOptions extends ChangeNotifier {
  ///The list containting all lines.
  List<Stroke> get lines => _lines;
  List<Stroke> _lines = <Stroke>[];
  set lines(List<Stroke> value) {_lines = value; notifyListeners();}

  ///Line variable
  Stroke? get line => _line;
  Stroke? _line;
  set line(Stroke? value) {_line = value; notifyListeners();}

  ///Remove all lines.
  void clearAll() {
    lines = [];
    line = null;
    notifyListeners();
  }

  /// The color of the stroke.
  Color get color => _color;
  Color _color = Colors.black;
  set color(Color value) {_color = value; notifyListeners();}

  /// The base size (diameter) of the stroke.
  double get size => _size;
  double _size = 10;
  set size(double value) {_size = value; notifyListeners();}

  /// The effect of pressure on the stroke's size.
  double get thinning => _thinning;
  double _thinning = 0.60;
  set thinning(double value) {_thinning = value; notifyListeners();}

  /// Controls the density of points along the stroke's edges.
  double get smoothing => _smoothing;
  double _smoothing = 1.0;
  set smoothing(double value) {_smoothing = value; notifyListeners();}

  /// Controls the level of variation allowed in the input points.
  double get streamline => _streamline;
  double _streamline = 0.85;
  set streamline(double value) {_streamline = value; notifyListeners();}

  /// Whether to simulate pressure or use the point's provided pressures.
  bool get simulatePressure => _simulatePressure;
  bool _simulatePressure = true;
  set simulatePressure(bool value) {_simulatePressure = value; notifyListeners();}

  /// The distance to taper the front of the stroke.
  double get taperStart => _taperStart;
  double _taperStart = 0.0;
  set taperStart(double value) {_taperStart = value; notifyListeners();}

  /// The distance to taper the end of the stroke.
  double get taperEnd => _taperEnd;
  double _taperEnd = 0.0;
  set taperEnd(double value) {_taperEnd = value; notifyListeners();}

  /// Whether to add a cap to the start of the stroke.
  bool get capStart => _capStart;
  bool _capStart = true;
  set capStart(bool value) {_capStart = value; notifyListeners();}

  /// Whether to add a cap to the end of the stroke.
  bool get capEnd => _capEnd;
  bool _capEnd = true;
  set capEnd(bool value) {_capEnd = value; notifyListeners();}

  /// Whether the line is complete.
  bool get isComplete => _isComplete;
  bool _isComplete = false;
  set isComplete(bool value) {_isComplete = value; notifyListeners();}
}
