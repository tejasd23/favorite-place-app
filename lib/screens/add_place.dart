// import 'package:flutter/src/foundation/key.dart';
// import 'package:flutter/src/widgets/container.dart';
// import 'package:flutter/src/widgets/framework.dart';

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:places/widget/location_input.dart';
import 'package:provider/provider.dart';

import '../widget/image_input.dart';
import '../provider/great_place.dart';

class AddPlace extends StatefulWidget {
  static const routeName = '/add-place';

  @override
  State<AddPlace> createState() => _AddPlaceState();
}

class _AddPlaceState extends State<AddPlace> {
  final _titleContorller = TextEditingController();
  File _pickedImage;

  void _selectImage(File pickedImage) {
    _pickedImage = pickedImage;
  }

  void _savePlace() {
    if (_titleContorller.text.isEmpty || _pickedImage == null) {
      return;
    }
    Provider.of<GreatPlace>(context, listen: false)
        .addPlace(_titleContorller.text, _pickedImage);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add a new Place'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: SingleChildScrollView(
                child: Padding(
              padding: EdgeInsets.all(10),
              child: Column(
                children: [
                  TextField(
                    decoration: InputDecoration(labelText: 'Title'),
                    controller: _titleContorller,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  ImageInput(_selectImage),
                  SizedBox(height: 10,),
                  LocationInput(),
                ],
              ),
            )),
          ),
          ElevatedButton.icon(
            icon: Icon(Icons.add),
            label: Text('Add Place'),
            onPressed: _savePlace,
            style: ElevatedButton.styleFrom(
              primary: Theme.of(context).accentColor,
            ),
          ),
        ],
      ),
    );
  }
}
