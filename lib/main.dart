import 'package:flutter/material.dart';
import 'package:place_list/providers/great_places.dart';
import 'package:place_list/screens/place_list_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: GreatPlaces(),
      child: MaterialApp(
        title: 'Place List',
        theme: ThemeData(
          primarySwatch: Colors.indigo,
          accentColor: Colors.amber
        ),
        home: PlacesListScreen(),
      ),
    );
  }
}

