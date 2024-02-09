import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_heatmap_calendar/flutter_heatmap_calendar.dart';

class MyHeatMap extends StatelessWidget {

  final DateTime startDate;
  final Map<DateTime, int> datasets;

  const MyHeatMap({super.key,
  required this.startDate,
    required this.datasets,
  });

  @override
  Widget build(BuildContext context) {
    return HeatMap(
      startDate: startDate,
          endDate: DateTime.now(),
          datasets: datasets,
          colorMode: ColorMode.color,
          defaultColor: Theme.of(context).colorScheme.tertiary,
          textColor:  Colors.white,
          showColorTip: false,
          showText: true,
          scrollable: true,
          size: 30,
          colorsets: {
            1: Colors.green.shade100,
            2: Colors.green.shade300,
            3: Colors.green.shade500,
            4: Colors.green.shade700,
            5: Colors.green.shade900,

          }
   );
  }
}
