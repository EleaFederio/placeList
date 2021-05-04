import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:place_list/helpers/location_helper.dart';

class LocationInput extends StatefulWidget {
  @override
  _LocationInputState createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {
  @override
  Widget build(BuildContext context) {

    String _previewImageUrl;

    Future<void> _getUserCurrentLocation() async {
      final locationData = await Location().getLocation();
      final staticMapImageUrl = LocationHelper.generateLocationPreviewImage(
        latitude: locationData.latitude,
        longitude: locationData.longitude,
      );
      print('***********************************************');
      print(staticMapImageUrl);
      print('***********************************************');
      setState(() {
        _previewImageUrl = staticMapImageUrl;
      });
    }

    return Column(
      children: <Widget>[
        Container(
          height: 170,
          width: double.infinity,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            border: Border.all(
              width: 1,
              color: Colors.grey
            )
          ),
          child: _previewImageUrl == null ?
          Text(
            'No Location Chosen',
            textAlign: TextAlign.center,
          ):
          Image.network(
            _previewImageUrl,
            fit: BoxFit.cover,
            width: double.infinity,
          )
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
          FlatButton.icon(
            icon: Icon(Icons.location_on),
            label: Text('Current Location'),
            textColor: Theme.of(context).primaryColor,
            onPressed: _getUserCurrentLocation,
          ),
          FlatButton.icon(
            icon: Icon(Icons.map),
            label: Text('Select on Map'),
            textColor: Theme.of(context).primaryColor,
            onPressed: (){

            },
          )
        ],)
      ],
    );
  }
}