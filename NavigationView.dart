import 'package:flutter/material.dart';
import 'package:flutter_music/ScreenData.dart';




class ListScreen<T extends DataListScreen> extends StatelessWidget {
  final List<T> itemsList;
  final ValueChanged<T> onTapped;
  final String title;
  ListScreen({
    @required this.itemsList,
    @required this.onTapped,
    this.title
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title, textAlign: TextAlign.center, textDirection: TextDirection.rtl,)),
      body: ListView(
        children: [
          for (var item in itemsList)
            ListTile(
             contentPadding: EdgeInsets.symmetric(horizontal: 20.0),
              title: Text( item.title,textDirection: TextDirection.rtl,),
             // subtitle: Text(itemData.author),
              onTap: () => onTapped(item),
            )
        ],
      ),
    );
  }
}

class ItemDataDetailsPage extends Page {
  final DataItem itemData;

  ItemDataDetailsPage({
    this.itemData,
  }) : super(key: ValueKey(itemData));

  Route createRoute(BuildContext context) {
    return MaterialPageRoute(
      settings: this,
      builder: (BuildContext context) {
        return ItemDataDetailsScreen(itemData: itemData);
      },
    );
  }
}

class ItemDataDetailsScreen extends StatelessWidget {
  final DataItem itemData;
  final String title;
  ItemDataDetailsScreen({
    @required this.itemData,
    this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (itemData!= null) ...[
              Text(itemData.content, style: Theme.of(context).textTheme.headline6,textDirection: TextDirection.rtl,),
              //Text(itemData.author, style: Theme.of(context).textTheme.subtitle1),
            ],
          ],
        ),
      ),
    );
  }
}

class LoadScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Center(
        child:
        Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Stack(
              children: <Widget>[
                // Stroked text as border.
                Text(
                  'Loading',
                  style: TextStyle(
                    fontSize: 40,
                    foreground: Paint()
                      ..style = PaintingStyle.stroke
                      ..strokeWidth = 6
                      ..color = Colors.blue[700],
                  ),
                ),
                // Solid text as fill.
                Text(
                  'Loading',
                  style: TextStyle(
                    fontSize: 40,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(100.0),
              child:
              Column(
                children: [
                  Text("Please wait"),
                  Padding(
                  padding: const EdgeInsets.all(50.0),
                  child:CircularProgressIndicator(
                    valueColor: new AlwaysStoppedAnimation<Color>(
                        Colors.blue),
                  )
                  )
                ],
              ),
            )],
        )
      )
    );
  }
}
class UnknownScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Text('404!'),
      ),
    );
  }
}