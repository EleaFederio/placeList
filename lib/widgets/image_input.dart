import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart' as syspath;
import 'package:image_picker/image_picker.dart';

class ImageInput extends StatefulWidget {
  final Function onSelectImage;


  ImageInput(this.onSelectImage);

  @override
  _ImageInputState createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  File _storedImage;

  Future<void> _takePicture() async {
    final _picker = ImagePicker();
    final imageFile = await _picker.getImage(
      source: ImageSource.camera,
      maxWidth: 600,
    );
    // catch error it user didn't take a picture and go back to previous screen
    if(imageFile == null){
      return;
    }
    setState(() {
      _storedImage = File(imageFile.path);
    });
    final appDir = await syspath.getApplicationDocumentsDirectory();
    final fileName = path.basename(imageFile.path);
    final savedImage = await _storedImage.copy('${appDir.path}/$fileName');
    widget.onSelectImage(savedImage);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Container(
          width: 150,
          height: 150,
          decoration: BoxDecoration(
            border: Border.all(
              width: 1,
              color: Colors.grey
            )
          ),
          child: _storedImage != null ?
          Image.file(
            _storedImage,
            fit: BoxFit.cover,
            width: double.infinity,
          ):
          Text(
            'No Image Taken',
            textAlign: TextAlign.center,
          ),
          alignment: Alignment.center,
        ),
        SizedBox(width: 10,),
        Expanded(
          child: FlatButton.icon(
            icon: Icon(Icons.camera),
            label: Text('Take Picture'),
            textColor: Theme.of(context).primaryColor,
            onPressed: _takePicture,
          ),
        )
      ],
    );
  }
}
