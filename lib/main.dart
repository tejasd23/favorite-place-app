import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './provider/great_place.dart';
import './screens/places_list.dart';
import './screens/add_place.dart';

void main() {
  runApp( MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: GreatPlace(),
      child: MaterialApp(
        title: 'Great Places',
        theme: ThemeData(
          primarySwatch: Colors.indigo,
          accentColor: Colors.amber
        ),
        home:  PlacesListScreen(),
        routes: {
          AddPlace.routeName: (ctx) => AddPlace(),
        },
      ),
    );
  }
}


