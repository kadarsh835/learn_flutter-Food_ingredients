import 'package:flutter/material.dart';
import 'package:food_ingredients/src/foodInfo.dart';
import 'package:food_ingredients/src/utils/textFormatter.dart';

class ServingSize extends StatelessWidget {
  final jsonFoodDetailList;
  ServingSize(this.jsonFoodDetailList);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text(
            "Select Food & Quantity"
          ),
					backgroundColor: Colors.black,
        ),
        body: getListView(jsonFoodDetailList),
      ),
    );
  }
}

Widget getListView(jsonFoodDetailList){
  var listView= ListView.builder(
    itemCount: jsonFoodDetailList.length,
    itemBuilder: (context, index){
      return ListTile(
        leading: Icon(Icons.fastfood),
        title: Row(children: <Widget>[
            Text(textFormatter(jsonFoodDetailList[index]['food_item']),
              style: TextStyle(
                fontWeight: FontWeight.w900,
              ),
            ),
          ],
        ),
        subtitle: Row(children: <Widget>[
            Text("Quantity: ", 
              style: TextStyle(
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(jsonFoodDetailList[index]['serving_size'])
          ],
        ),
        onTap: ()=>{
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => FoodInfo(jsonFoodDetailList[index])),
          )
        },
      );
    },
  );
  return listView;
}
