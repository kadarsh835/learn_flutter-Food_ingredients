
import 'package:flutter/material.dart';
import 'package:food_ingredients/src/imagePicker.dart';

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