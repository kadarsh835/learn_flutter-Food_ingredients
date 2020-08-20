import 'package:flutter/material.dart';
import 'package:food_ingredients/src/servingSizePage.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:food_ingredients/src/nutrientConsumption.dart';

class MyImagePicker extends StatefulWidget {
  @override
  MyImagePickerState createState() => MyImagePickerState();
}

class MyImagePickerState extends State<MyImagePicker> {
  File imageURI;

  Future getImageFromCamera() async {
    var image = await ImagePicker.pickImage(source: ImageSource.camera);
    setState(() {
      imageURI = image;
    });
  }

  Future getImageFromGallery() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      imageURI = image;
    });
  }

  Container buttonContainerCamera() {
    return Container(
        margin: EdgeInsets.fromLTRB(0, 30, 0, 20),
        child: RaisedButton.icon(
          onPressed: () => getImageFromCamera(),
          icon: Icon(Icons.camera_alt),
          label: Text('Camera '),
          textColor: Colors.white,
          color: Colors.black,
          padding: EdgeInsets.fromLTRB(6, 6, 6, 6),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
        ));
  }

  Container buttonContainerGallery() {
    return Container(
        margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
        child: RaisedButton.icon(
          onPressed: () => getImageFromGallery(),
          icon: Icon(Icons.image),
          label: Text('Gallery '),
          textColor: Colors.white,
          color: Colors.black,
          padding: EdgeInsets.fromLTRB(6, 6, 6, 6),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
        ));
  }

  Container buttonGetFoodDetails(File imageURI) {
    if (imageURI == null) return new Container();
    return Container(
        margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
        child: RaisedButton.icon(
          onPressed: () async {
            var result = await sendImage(imageURI);
            // print('Food Item Predicted: $result');

            // var result = testJSON();

            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ServingSize(result)),
            );
          },
          icon: Icon(Icons.list),
          label: Text('Get Details'),
          textColor: Colors.white,
          color: Colors.black,
          padding: EdgeInsets.fromLTRB(12, 12, 12, 12),
        ));
  }

  String convertImgToBase64(File imageURI) {
    final bytes = imageURI.readAsBytesSync();
    String imgB64 = base64Encode(bytes);
    return imgB64;
  }
  // Future<http.Response> sendImage(File imageURI) async{

  Future<List<dynamic>> sendImage(File imageURI) async {
    String imgBase64 = convertImgToBase64(imageURI);
    Map foodItem = {'food_image': imgBase64};
    var body = json.encode(foodItem);
    http.Response response = await http.post(
        'https://84b295c0deaa.ngrok.io/diet_suggestion_api/predict_food_item/', //Using Ngrok Temporarily.
        headers: {"Content-Type": "application/json"},
        body: body);
    print('Status Code: ${response.statusCode}');
    if (response.statusCode == 200) {
      Map<String, dynamic> decodedJson = jsonDecode(response.body);
      print(decodedJson);
      return decodedJson['nutritional_info'];
    } else
      throw Exception('Failed');
  }

  Text uploadImageMessage() {
    return Text(
      'Capture Image/ Select from Gallery',
      textAlign: TextAlign.center,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              child: imageURI == null
                  ? uploadImageMessage()
                  : Image.file(imageURI,
                      width: 300, height: 200, fit: BoxFit.cover),
            ),
            Container(
              child: imageURI != null ? buttonGetFoodDetails(imageURI) : null,
            ),
            Row(
              children: <Widget>[
                Container(
                  child: buttonContainerCamera(),
                  alignment: Alignment.centerLeft,
                ),
                Container(
                  child: buttonContainerGallery(),
                  alignment: Alignment.centerRight,
                ),
              ],
              mainAxisAlignment: MainAxisAlignment.spaceAround,
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async => {
          await SharedPreferences.getInstance().then((prefs) => {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => NutrientConsumption(prefs)),
                ),
              })
        },
        tooltip: 'Today\'s Nutritional Consumption',
        label: Text("Today\'s Nutritional Consumption"),
        icon: Icon(Icons.assessment),
        backgroundColor: Colors.black,
      ),
    );
  }
}

// For debugging purpose only
List<Map<String, dynamic>> testJSON() {
  return [
    {
      "food_item": "butter_chicken",
      "serving_size": "1 cup",
      "calories": "485",
      "calories_from_fat": "0",
      "total_fat": "34.9g",
      "total_fat_percent": "54%",
      "saturated_fat": "12.4g",
      "saturated_fat_percent": "62%",
      "trans_fat": "0g",
      "cholesterol": "126mg",
      "cholesterol_percent": "42%",
      "sodium": "455mg",
      "sodium_percent": "19%",
      "potassium": "537mg",
      "potassium_percent": "15%",
      "total_carbohydrate": "10.4g",
      "total_carbohydrate_percent": "3%",
      "dietary_fiber": "2.9g",
      "dietary_fiber_percent": "12%",
      "sugars": "3.4g",
      "protein": "33.3g",
      "protein_percent": "67%",
      "vitamin_A_percent": "22%",
      "vitamin_C_percent": "12%",
      "calcium_percent": "12%",
      "iron_percent": "22%"
    },
    {
      "food_item": "butter_chicken",
      "serving_size": "240 grams",
      "calories": "485",
      "calories_from_fat": "0",
      "total_fat": "34.9g",
      "total_fat_percent": "54%",
      "saturated_fat": "12.4g",
      "saturated_fat_percent": "62%",
      "trans_fat": "0g",
      "cholesterol": "126mg",
      "cholesterol_percent": "42%",
      "sodium": "455mg",
      "sodium_percent": "19%",
      "potassium": "537mg",
      "potassium_percent": "15%",
      "total_carbohydrate": "10.4g",
      "total_carbohydrate_percent": "3%",
      "dietary_fiber": "2.9g",
      "dietary_fiber_percent": "12%",
      "sugars": "3.4g",
      "protein": "33.3g",
      "protein_percent": "67%",
      "vitamin_A_percent": "22%",
      "vitamin_C_percent": "12%",
      "calcium_percent": "12%",
      "iron_percent": "22%"
    },
    {
      "food_item": "butter_chicken",
      "serving_size": "1 serving (120 g)",
      "calories": "243",
      "calories_from_fat": "0",
      "total_fat": "17.5g",
      "total_fat_percent": "27%",
      "saturated_fat": "6.2g",
      "saturated_fat_percent": "31%",
      "trans_fat": "0g",
      "cholesterol": "63.1mg",
      "cholesterol_percent": "21%",
      "sodium": "228mg",
      "sodium_percent": "9%",
      "potassium": "269.1mg",
      "potassium_percent": "8%",
      "total_carbohydrate": "5.2g",
      "total_carbohydrate_percent": "2%",
      "dietary_fiber": "1.5g",
      "dietary_fiber_percent": "6%",
      "sugars": "1.7g",
      "protein": "16.7g",
      "protein_percent": "33%",
      "vitamin_A_percent": "11%",
      "vitamin_C_percent": "6%",
      "calcium_percent": "6%",
      "iron_percent": "11%"
    },
    {
      "food_item": "butter_chicken",
      "serving_size": "1 oz",
      "calories": "57",
      "calories_from_fat": "0",
      "total_fat": "4.1g",
      "total_fat_percent": "6%",
      "saturated_fat": "1.5g",
      "saturated_fat_percent": "7%",
      "trans_fat": "0g",
      "cholesterol": "14.8mg",
      "cholesterol_percent": "5%",
      "sodium": "53.5mg",
      "sodium_percent": "2%",
      "potassium": "63.1mg",
      "potassium_percent": "2%",
      "total_carbohydrate": "1.2g",
      "total_carbohydrate_percent": "0%",
      "dietary_fiber": "0.3g",
      "dietary_fiber_percent": "1%",
      "sugars": "0.4g",
      "protein": "3.9g",
      "protein_percent": "8%",
      "vitamin_A_percent": "3%",
      "vitamin_C_percent": "1%",
      "calcium_percent": "1%",
      "iron_percent": "3%"
    }
  ];
}
