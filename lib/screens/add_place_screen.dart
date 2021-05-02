import 'dart:io';

import 'package:flutter/material.dart';
import 'package:place_list/providers/great_places.dart';
import 'package:place_list/widgets/image_input.dart';
import 'package:provider/provider.dart';

class AddPlaceScreen extends StatefulWidget {
  static const routeName = '/add-place';

  @override
  _AddPlaceScreenState createState() => _AddPlaceScreenState();
}

class _AddPlaceScreenState extends State<AddPlaceScreen> {

  final _titleController = TextEditingController();
  File _pickedImage;

  void _selectImage(File pickedImage){
    _pickedImage = pickedImage;
  }

  void _savePlace(){
    if(_titleController.text.isEmpty || _pickedImage == null){
      AlertDialog(
        title: Text('Image Error Occur'),
        content: Text('Empty Image'),
        actions: [
          FlatButton(
            child: Text('Ok'),
            onPressed: (){
             Navigator.of(context).pop();
            },
          )
        ],
        elevation: 24.0,
      );
      return;
    }
    Provider.of<GreatPlaces>(context, listen: false).addPlace(_titleController.text, _pickedImage);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add a New Place'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          // take all the height
          Expanded(
            // Make it Scrollable
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(10),
                child: Column(
                  children: <Widget>[
                    TextField(
                      decoration: InputDecoration(
                        labelText: 'Title'
                      ),
                      controller: _titleController,
                    ),
                    SizedBox(height: 10,),
                    ImageInput(_selectImage),
                  ],
                ),
              ),
            ),
          ),
          RaisedButton.icon(
            icon: Icon(Icons.add),
            label: Text('Add Place'),
            onPressed: _savePlace,
            elevation: 0,
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            color: Theme.of(context).accentColor,
          )
        ],
      ),
    );
  }
}
