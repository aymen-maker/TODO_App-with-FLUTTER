import 'package:flutter/material.dart';
import 'Task.dart';
import 'dismiss.dart';
class HistPage extends StatefulWidget {
  HistPage({Key key}) : super(key: key);

  @override
  _HistPageState createState() => new _HistPageState();

}

class _HistPageState extends State<HistPage> {
  Widget doneOrNot(bool test) => new IconButton(
    onPressed: null,
    icon:
    test ? new Icon(Icons.check_circle):new Icon(Icons.check_circle_outline),)
      ;

    Widget _buildListRow(Item item) {
    Widget titleRow = new Row(
      children: <Widget>[
        new Expanded(
          child: new Container(
            padding: new EdgeInsets.symmetric(horizontal: 4.0),
            child: new Text(item.name,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          ),
        ),
        new Text(item.date),
      ],
    );

    Widget textSection = new Container(
      child: new Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          titleRow,
          new Text(item.content,
            overflow: TextOverflow.ellipsis,
            maxLines: 2,)
        ],
      ),
    );

    return new Dismissible(
      key: new Key(item.id.toString()),
      direction: DismissDirection.horizontal,
      onDismissed: (DismissDirection direction) {
        _delete(item);
      },
      resizeDuration: null,
      dismissThresholds: _dismissThresholds(),
      background: new LeaveBehindView(),
      child: new Container (
        padding: new EdgeInsets.all(8.0),
        child: new Row(
          children: <Widget>[
            doneOrNot(item.done),
            new Expanded(
                child: textSection),
          ],
        ),
      ),
    );
  }

  Map<DismissDirection, double> _dismissThresholds() {
    Map<DismissDirection, double> map = new Map<DismissDirection, double>();
    map.putIfAbsent(DismissDirection.horizontal, () => 0.3);
    return map;
  }

  void _delete(Item item) {
    new ItemsRepositoryTot().delete(item);
    new ItemsRepository().delete(item);
    setState(() {
      _itemsTot = new ItemsRepositoryTot().getItems();
    });
  }
  List<Item> _itemsTot;

  @override
  void initState() {
    super.initState();
    _itemsTot = new ItemsRepositoryTot().getItems();
  }


  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Mon historique de tâches'),
        flexibleSpace: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: <Color>[
                    Colors.pink,
                    Colors.redAccent[100]
                  ])
          ),
        ),
      ),
      body: new Padding(
        padding: new EdgeInsets.symmetric(vertical: 0.0, horizontal: 0.0),
        child: new ListView(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          children: _itemsTot.map((Item value) {
            return _buildListRow(value);
          }).toList(),
        ),
      ),
    );
  }


}