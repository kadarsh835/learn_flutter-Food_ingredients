import 'package:flutter/material.dart';
import 'package:food_ingredients/src/utils/textFormatter.dart';

class FoodInfo extends StatelessWidget {
  final jsonFoodDetail;
  FoodInfo(this.jsonFoodDetail);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Nutritional Info"),
          backgroundColor: Colors.black,
        ),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: nutritionalInfoWidget(jsonFoodDetail),
        ),
        floatingActionButton: FloatingActionButton.extended(
          // onPressed: storeToDisk(this.jsonFoodDetail),
          tooltip: 'Add to today\'s diet',
          label: Text("Add to today\'s diet"),
          icon: Icon(Icons.fastfood),
          backgroundColor: Colors.black,
        ),
      ),
    );
  }
}

Widget nutritionalInfoWidget(jsonFoodNutritionalInfo) {
  var table = DataTable(columns: <DataColumn>[
    DataColumn(
      label: Text(
        "Parameter",
        style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.w900),
      ),
      tooltip:
          "This column contains the nutritional parameter in the food selected.",
    ),
    DataColumn(
      label: Text(
        "Content",
        style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.w900),
      ),
      tooltip: "This column contains the nutritional content.",
    ),
  ], rows: getParamValues(jsonFoodNutritionalInfo));
  return table;
}

List<DataRow> getParamValues(jsonFoodNutritionalInfo) {
  List<DataRow> dataRows = [];
  jsonFoodNutritionalInfo.keys.forEach((key) {
    dataRows.add(
      DataRow(cells: <DataCell>[
        DataCell(Text(textFormatter(key))),
        DataCell(Text(textFormatter(jsonFoodNutritionalInfo[key])))
      ]),
    );
  });
  return dataRows;
}

void storeToDisk(foodJsonDataFood) {}
