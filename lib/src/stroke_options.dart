import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class StrokeOptionsSliders extends StatefulWidget {
  final String? stringSize;
  final String? stringThinning;
  final String? stringStreamline;
  final String? stringSmoothing;
  final String? stringTaperStart;
  final String? stringTaperEnd;

  const StrokeOptionsSliders({Key? key, this.stringSize, this.stringThinning, this.stringStreamline, this.stringSmoothing, this.stringTaperStart, this.stringTaperEnd}) : super(key: key);

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
          Text(
            widget.stringSize ?? 'size',
            textAlign: TextAlign.start,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
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
          Text(
            widget.stringThinning ?? 'thinning',
            textAlign: TextAlign.start,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
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
          Text(
            widget.stringStreamline ?? 'streamline',
            textAlign: TextAlign.start,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
          ),
          StatefulBuilder(
            builder: (context, setState) {
              return Slider(
                  value: settingsProvider.streamline,
                  min: 0,
                  max: 1,
                  divisions: 100,
                  label: settingsProvider.streamline.toStringAsFixed(2),
                  onChanged: (double value) => {
                    setState(() {
                      settingsProvider.streamline = value;
                    })
                  });
            },
          ),
          Text(
            widget.stringSmoothing ?? 'smoothing',
            textAlign: TextAlign.start,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
          ),
          StatefulBuilder(
            builder: (context, setState) {
              return Slider(
                  value: settingsProvider.smoothing,
                  min: 0,
                  max: 1,
                  divisions: 100,
                  label: settingsProvider.smoothing.toStringAsFixed(2),
                  onChanged: (double value) => {
                    setState(() {
                      settingsProvider.smoothing = value;
                    })
                  });
            },
          ),
          Text(
            widget.stringTaperStart ?? 'taper start',
            textAlign: TextAlign.start,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
          ),
          StatefulBuilder(
            builder: (context, setState) {
              return Slider(
                  value: settingsProvider.taperStart,
                  min: 0,
                  max: 100,
                  divisions: 100,
                  label: settingsProvider.taperStart.toStringAsFixed(2),
                  onChanged: (double value) => {
                    setState(() {
                      settingsProvider.taperStart = value;
                    })
                  });
            },
          ),
          Text(
            widget.stringTaperEnd ?? 'taper end',
            textAlign: TextAlign.start,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
          ),
          StatefulBuilder(
            builder: (context, setState) {
              return Slider(
                  value: settingsProvider.taperEnd,
                  min: 0,
                  max: 100,
                  divisions: 100,
                  label: settingsProvider.taperEnd.toStringAsFixed(2),
                  onChanged: (double value) => {
                    setState(() {
                      settingsProvider.taperEnd = value;
                    })
                  });
            },
          ),
         /* const Text(
            'Clear',
            textAlign: TextAlign.start,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
          ),
          GestureDetector(
            // onTap: clear,
            child: const Padding(
              padding: EdgeInsets.symmetric(vertical: 8.0),
              child: CircleAvatar(
                  child: Icon(
                    Icons.delete,
                    size: 20.0,
                    color: Colors.white,
                  )),
            ),
          ),*/
        ],
      ),
    );
  }
}

class StrokeOptions extends ChangeNotifier {
  /// The base size (diameter) of the stroke.
  double _size = 10;
  double get size => _size;

  /// The effect of pressure on the stroke's size.
  double _thinning = 0.10;
  double get thinning => _thinning;

  /// Controls the density of points along the stroke's edges.
  double _smoothing = 1.0;
  double get smoothing => _smoothing;

  /// Controls the level of variation allowed in the input points.
  double _streamline = 0.85;
  double get streamline => _streamline;

  // Whether to simulate pressure or use the point's provided pressures.
  bool _simulatePressure = true;
  bool get simulatePressure => _simulatePressure;

  // The distance to taper the front of the stroke.
  double _taperStart = 0.0;
  double get taperStart => _taperStart;

  // The distance to taper the end of the stroke.
  double _taperEnd = 0.0;
  double get taperEnd => _taperEnd;

  // Whether to add a cap to the start of the stroke.
  bool _capStart = true;
  bool get capStart => _capStart;

  // Whether to add a cap to the end of the stroke.
  bool _capEnd = true;
  bool get capEnd => _capEnd;

  // Whether the line is complete.
  bool _isComplete = false;
  bool get isComplete => _isComplete;



  set size(double value) {
    _size = value;
    notifyListeners();
  }

  set thinning(double value) {
    _thinning = value;
    notifyListeners();
  }

  set smoothing(double value) {
    _smoothing = value;
    notifyListeners();
  }

  set streamline(double value) {
    _streamline = value;
    notifyListeners();
  }

  set simulatePressure(bool value) {
    _simulatePressure = value;
    notifyListeners();
  }

  set taperStart(double value) {
    _taperStart = value;
    notifyListeners();
  }

  set taperEnd(double value) {
    _taperEnd = value;
    notifyListeners();
  }

  set capStart(bool value) {
    _capStart = value;
    notifyListeners();
  }


  set capEnd(bool value) {
    _capEnd = value;
    notifyListeners();
  }

  set isComplete(bool value) {
    _isComplete = value;
    notifyListeners();
  }
}
