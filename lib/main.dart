import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

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
				padding: EdgeInsets.fromLTRB(12, 12, 12, 12),
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
				padding: EdgeInsets.fromLTRB(12, 12, 12, 12),
			)
		);
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
						buttonContainerCamera(),
						buttonContainerGallary(),
					],
				),
			)
		);
	}

}