// import 'package:flutter/src/foundation/key.dart';
// import 'package:flutter/src/widgets/container.dart';
// import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './add_place.dart';
import '../provider/great_place.dart';

class PlacesListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Places'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed(AddPlace.routeName);
            },
            icon: Icon(Icons.add),
          ),
        ],
      ),
      body: FutureBuilder(
        future:
            Provider.of<GreatPlace>(context, listen: false).fetchAndSetPlaces(),
        builder: (ctx, snapshot) => snapshot.connectionState ==
                ConnectionState.waiting
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Consumer<GreatPlace>(
                child: Center(
                  child: const Text('Got no places yet,start adding some!'),
                ),
                builder: (ctx, greatPlace, ch) => greatPlace.items.length <= 0
                    ? ch
                    : ListView.builder(
                        itemCount: greatPlace.items.length,
                        itemBuilder: (ctx, i) => ListTile(
                          leading: CircleAvatar(
                            backgroundImage: FileImage(
                              greatPlace.items[i].image,
                            ),
                          ),
                          title: Text(greatPlace.items[i].title),
                          onTap: () {},
                        ),
                      ),
              ),
      ),
    );
    // );
  }
}
