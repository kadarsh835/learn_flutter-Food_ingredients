import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:http/http.dart' as http;

void main() => runApp(MyApp());

class MyApp extends StatelessWidget{
	@override
	Widget build(BuildContext context){
		return MaterialApp(
			home: Scaffold(
				appBar: AppBar(
					title: Text(
						'Food Ingredients',
					),
					backgroundColor: Colors.black,
				),
				body: Center(child: MyImagePicker()),
			),
		);
	}
}

class MyImagePicker extends StatefulWidget{
	@override
	MyImagePickerState createState() => MyImagePickerState();
}

class MyImagePickerState extends State<MyImagePicker>{
	File imageURI;

	Future getImageFromCamera() async{
		var image= await ImagePicker.pickImage(source: ImageSource.camera);
		setState(() {
		  	imageURI= image;
		});
	}

	Future getImageFromGallary() async{
		var image= await ImagePicker.pickImage(source: ImageSource.gallery);
		setState(() {
		  	imageURI= image;
		});
	}

	Container buttonContainerCamera(){
		return Container(
			margin: EdgeInsets.fromLTRB(0, 30, 0, 20),
			child: RaisedButton(
				onPressed: () =>getImageFromCamera(),
				child: Text(
					'Click Here to Capture Image From Camera'
				),
				textColor: Colors.white,
				color: Colors.grey,
				padding: EdgeInsets.fromLTRB(6, 6, 6, 6),
			)
		);
	}

	Container buttonContainerGallary(){
		return Container(
			margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
			child: RaisedButton(
				onPressed: () =>getImageFromGallary(),
				child: Text(
					'Click Here to get Image From Gallary'
				),
				textColor: Colors.white,
				color: Colors.grey,
				padding: EdgeInsets.fromLTRB(6, 6, 6, 6),
			)
		);
	}

	Container buttonGetFoodDetails(File imageURI){
		if(imageURI==null)
			return new Container();
		return Container(
			margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
			child: RaisedButton(
				onPressed: () async {
          String result = await sendImage(imageURI);
          print('Hey $result');},
				child: Text(
					'Get Details'
				),
				textColor: Colors.white,
				color: Colors.black,
				padding: EdgeInsets.fromLTRB(12, 12, 12, 12),
			)
		);
	}

	String convertImgToBase64(File imageURI){
		final bytes= imageURI.readAsBytesSync();
		String imgB64= base64Encode(bytes);
		return imgB64;
	}
	// Future<http.Response> sendImage(File imageURI) async{

	Future<String> sendImage(File imageURI) async{
		String imgBase64= convertImgToBase64(imageURI);
		print('$imgBase64');
    Map foodItem= {
      'food_item': imgBase64
    };
    var body= json.encode(foodItem);
		http.Response response= await http.post(
			'http://c471f2f1.ngrok.io/food_item/',   //Using Ngrok Temporarily.
			headers:{
			  "Content-Type": "application/json"
			},
			body: body
		);
		print('Status Code: ${response.statusCode}');
		if(response.statusCode==201){
			Map<String, dynamic> decodedJson= jsonDecode(response.body);
			print(decodedJson);
			return decodedJson['food_item'];
		}
		else
			throw Exception('Failed');
	}

	Text uploadImageMessage(){
		return Text(
			'Capture Image/ Select from Gallary',
			textAlign: TextAlign.center,
		);
	}

	@override
	Widget build(BuildContext context){
		return Scaffold(
			body: Center(
				child: Column(
					mainAxisAlignment: MainAxisAlignment.center,
					children: <Widget>[
						imageURI == null?uploadImageMessage():Image.file(imageURI,
										width: 300, height: 200, fit: BoxFit.cover),
						buttonGetFoodDetails(imageURI),
						buttonContainerCamera(),
						buttonContainerGallary(),
					],
				),
			)
		);
	}

}