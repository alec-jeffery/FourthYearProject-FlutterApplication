// use this import to access the "inspect()" method
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

/// https://blog.logrocket.com/how-create-flutter-charts-with-charts-flutter/
///
/// to get a specific example chart (look for stateful one):
/// https://pub.dev/packages/flutter_charts
class NodeDataSeries {
  String time;
  int dataValue;
  // charts.Color barColor;

  NodeDataSeries(
    this.time,
    this.dataValue,
    /*this.barColor*/
  );

  set setTime(String time) {
    this.time = time;
  }
}

class NodeDataChart extends StatefulWidget {
  List<NodeDataSeries> dataList;
  final String chartName;

  NodeDataChart({Key? key, required this.dataList, required this.chartName})
      : super(key: key);

  @override
  State<NodeDataChart> createState() => _NodeDataChart();
}

class _NodeDataChart extends State<NodeDataChart> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<charts.Series<NodeDataSeries, String>> series = [
      charts.Series(
          id: "NodeDatas",
          data: widget.dataList,
          domainFn: (NodeDataSeries series, _) => series.time,
          measureFn: (NodeDataSeries series, _) => series.dataValue),
      // colorFn: (NodeDataSeries series, _) => series.barColor)
    ];

    return Container(
      height: 300,
      padding: const EdgeInsets.all(25),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(9.0),
          child: Column(
            children: <Widget>[
              Text(
                widget.chartName,
                style: Theme.of(context).textTheme.bodyText1,
              ),
              Expanded(
                child: charts.BarChart(series, animate: true),
              )
            ],
          ),
        ),
      ),
    );
  }
}
