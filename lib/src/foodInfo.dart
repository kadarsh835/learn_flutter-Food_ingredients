import 'package:flutter/material.dart';
import 'package:food_ingredients/src/utils/textFormatter.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:food_ingredients/src/nutrientConsumption.dart';

class FoodInfo extends StatelessWidget {
  final jsonFoodDetail;
  SharedPreferences prefs;
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
          onPressed: () => {
            storeToDisk(jsonFoodDetail).then((prefs) => {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => NutrientConsumption(prefs)),
                  ),
                })
          },
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

Future<SharedPreferences> storeToDisk(foodJsonData) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  // await prefs.clear();
  // return prefs;

  DateTime lastStoredDay;
  var value;
  try {
    lastStoredDay = DateTime(prefs.get('last_day'));
  } catch (e) {
    lastStoredDay = DateTime.now();
    prefs.setString('last_day', lastStoredDay.toString());
  }

  // prefs.getKeys().forEach((key) {
  //   value = prefs.get(key);
  //   print('$key: $value');
  // });

  var now = new DateTime.now();
  if (now.day - lastStoredDay.day != 0 ||
      now.difference(lastStoredDay).inDays >= 1) await prefs.clear();

  foodJsonData.keys.forEach((key) {
    value = prefs.get(key) ?? "%";
    if (value.runtimeType == String &&
        foodJsonData[key][foodJsonData[key].length - 1] == '%') {
      try {
        value = double.parse(value.substring(0, value.length - 1));
      } catch (e) {
        value = 0.0;
      }
      value = value +
          double.parse(
              foodJsonData[key].substring(0, foodJsonData[key].length - 1));
      value = value.toString() + '%';
      prefs.setString(key, value);
    }
  });
  return prefs;
}
