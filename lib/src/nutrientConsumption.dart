import 'package:flutter/material.dart';
import 'package:food_ingredients/src/utils/textFormatter.dart';

class NutrientConsumption extends StatelessWidget {
  final prefs;
  NutrientConsumption(this.prefs);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Today's Nutrition Consumption"),
          backgroundColor: Colors.black,
        ),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: nutritionalInfoWidget(prefs),
        ),
      ),
    );
  }
}

Widget nutritionalInfoWidget(prefs) {
  var table = DataTable(columns: <DataColumn>[
    DataColumn(
      label: Text(
        "Nutrient",
        style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.w900),
      ),
      tooltip: "This column contains the nutritional parameter.",
    ),
    DataColumn(
      label: Text(
        "Consumption",
        style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.w900),
      ),
      tooltip: "This column contains the nutritional consumption for today.",
    ),
  ], rows: getParamValues(prefs));
  return table;
}

List<DataRow> getParamValues(prefs) {
  List<DataRow> dataRows = [];
  prefs.getKeys().forEach((key) {
    if (key != 'last_day') {
      dataRows.add(
        DataRow(cells: <DataCell>[
          DataCell(Text(textFormatter(key))),
          DataCell(Text(textFormatter(prefs.get(key))))
        ]),
      );
    }
  });
  return dataRows;
}
