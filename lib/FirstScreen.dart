import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/user.dart';
import 'TaskList.dart';
import 'package:provider/provider.dart';
import 'Task.dart';
import 'dismiss.dart';
import 'addTask.dart';
import 'NavDrawer.dart';
import 'auth.dart';
import 'userTasks.dart';
import 'loading.dart';
import 'package:intl/intl.dart';
import 'dart:math';

class MainPage extends StatefulWidget {
  MainPage({Key key}) : super(key: key);

  @override
  _MainPageState createState() => new _MainPageState();

}

class _MainPageState extends State<MainPage> {

  String name="";
  bool test=false;




  @override
  void initState() {

    new ItemsRepository().init();
    new ItemsRepositoryTot().init();
    //initUser();
    setState(() {
      _items = new ItemsRepository().getItems();
      /*try {name = user.displayName;}
      catch (e) {
        print (e.toString());
      }*/
    });
    super.initState();

    //_itemsTot = new ItemsRepositoryTot().getItems();

  }

  /*initUser() async {
    user = await _auth.currentUser();
    setState(() {});
  }*/


  List<Item> _items;
  Widget _buildListRow(Item item) {

    //TODO
    //final _items = Provider.of<List<Item>>(context);

    return new Dismissible(
        key: new Key(item.id.toString()),
        direction: DismissDirection.horizontal,
        onDismissed: (DismissDirection direction) {
            _delete(item);
        },
        resizeDuration: null,
        dismissThresholds: _dismissThresholds(),
        background: new LeaveBehindView(),
        child: Card(
          elevation: 4,
          margin: EdgeInsets.fromLTRB(20, 10, 20, 0),
          color: Colors.indigo[50],
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20)
          ),
          child: new CheckboxListTile(
            value: item.done,
            onChanged: (bool value) {
              setState(() {
                item.done=value;
              });
            },
            checkColor: Colors.indigoAccent,
            activeColor: Colors.black12,

            title: new Text(item.name),
            subtitle: new Text(item.content),
          ),
        ));
  }

  Map<DismissDirection, double> _dismissThresholds() {
    Map<DismissDirection, double> map = new Map<DismissDirection, double>();
    map.putIfAbsent(DismissDirection.horizontal, () => 0.5);
    return map;
  }

  void _delete(Item item) {
    new ItemsRepository().delete(item);
    setState(() {
      _items = new ItemsRepository().getItems();
      //_itemsTot = new ItemsRepositoryTot().getItems();
    });
  }


  Widget bouton() => Padding(
    padding: const EdgeInsets.fromLTRB(10, 10, 10, 20),
    child: Container(

width: 70,
height: 70,
child: FloatingActionButton(

elevation: 20,
backgroundColor: Colors.indigo,
onPressed:() {
 _addTask();

},
tooltip: 'Increment',
child: Icon(Icons.add),
),
),
  );

  Widget textePositif() =>  Padding(
    padding: const EdgeInsets.fromLTRB(0, 0, 0, 30),
    child: Center(
      child: Text("Soyons productifs aujourd'hui :D",
          style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.normal,
              fontFamily: "Pacifico",
              color: Colors.white
          )
      ),
    ),
  );

  Widget welcome() => Padding(
    padding: const EdgeInsets.all(8.0),
    child: Center(
      child: Text("Bonjour "+name+"!",
          textAlign: TextAlign.center,
          style: TextStyle(
              height: 1,
              fontSize: 40,
              fontWeight: FontWeight.bold,
              fontFamily: "Pacifico",
              color: Colors.white
          )
      ),
    ),
  );

  Widget banner() => ShaderMask(
    shaderCallback: (rect) {
      return LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [Colors.black, Colors.transparent],
      ).createShader(Rect.fromLTRB(0, 100, rect.width, rect.height));
    },
    blendMode: BlendMode.dstIn,
    child: Image.asset(
      "assets/main.jpg",
      height: 250,
      fit: BoxFit.cover,
    ),
  );



  @override
  Widget build(BuildContext context) {
    User user = Provider.of<User>(context);
    if (user!=null) {
      try {name = user.displayName;
      }
      catch (e) {
        print(e.toString());
      }
    }
    /*try {user = Provider.of<User>(context);}
    catch (e) {
      print(e.toString());
    }*/

    /*try {name = user.displayName;
    }
    catch (e) {
      print(e.toString());
    }*/


    List<Widget> widgets = [banner(),welcome(),textePositif(),bouton()];
     List<Widget> list = _items.map((Item value) {
      return _buildListRow(value);
    }).toList();

    List<Widget> elements = widgets+list;
    return new Scaffold(
      drawer: NavDrawer(),
      appBar: AppBar(
          title: Text('My To Do app'),
          flexibleSpace: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: <Color>[
                      Colors.indigo[300],
                      Colors.tealAccent[100]
                    ])
            ),
          )),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [Colors.indigo[200],Colors.tealAccent[100]])),
        child: new ListView(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          children:
          elements,

        ),
      ),

    );
  }




/*void _addTask(){
  Navigator.of(context).push(new MaterialPageRoute<dynamic>(
    builder: (BuildContext context) {
      return new TaskFormPage();

    },
  ));
}*/
void _addTask() {
  Navigator
      .push(
    context,
    new MaterialPageRoute(builder: (context) => new TaskFormPage()),
  )
      .then((value) {
    setState(() {

    });
  });
}

}

